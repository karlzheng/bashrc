#!/usr/bin/python

#https://github.com/JiaminMa/write_rtos_in_3days
import os

ret = os.popen("ps aux | grep qemu")
line = ret.read().split(" ")
#print line
kill_cmd = "kill -9 {}".format(line[8])
#print(kill_cmd)
os.system(kill_cmd)

