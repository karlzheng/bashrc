#!/usr/bin/env python
#encoding:utf8

import sys
import time
import commands as cmds

#EV_SYN             0x00
#EV_ABS             0x03

#ABS_MT_POSITION_X  0x35
#ABS_MT_POSITION_Y  0x36
#ABS_MT_PRESSURE    0x3a
#ABS_MT_TOUCH_MAJOR 0x30
#ABS_MT_TRACKING_ID 0x39

typedict = {"EV_SYN":0x00, "EV_ABS":0x03}
codedict = {
    "ABS_MT_POSITION_X":0x35,
    "ABS_MT_POSITION_Y":0x36, 
    "ABS_MT_PRESSURE":0x3a,
    "ABS_MT_TOUCH_MAJOR":0x30,
    "ABS_MT_TRACKING_ID":0x39,
    "SYN_REPORT":0
}

def sendSimTouch(fn):
    #fd = open(fn, "rb")
    #lines = fd.readlines()
    #print lines
    for l in lines:
	if l.startswith('#'):
	    #print l
	    continue
	elems = l.strip().split()
	if len(elems) == 0:
	    time.sleep(0.2)
	elif len(elems) == 1:
	    if elems[0] == "sleep":
		time.sleep(0.2)
	else:
	    a1 = typedict.get(elems[0])
	    a2 = codedict.get(elems[1])
	    a3 = int(("0x"+elems[2]), 16)
	    cmd_prefix = "adb shell sendevent /dev/input/event8 "
	    cmd = cmd_prefix + "%d %d %d"%(a1, a2, a3)
	    #print a1, a2, a3
	    #print elems
	    print cmd
	    cmds.getstatusoutput(cmd)
    #fd.close()

lines = """

EV_ABS       ABS_MT_TRACKING_ID   000015de
EV_ABS       ABS_MT_POSITION_X    000000f7
EV_ABS       ABS_MT_POSITION_Y    0000035b
EV_SYN       SYN_REPORT           00000000
EV_ABS       ABS_MT_POSITION_X    00000383
EV_SYN       SYN_REPORT           00000000
EV_ABS       ABS_MT_POSITION_X    00000384
EV_SYN       SYN_REPORT           00000000
EV_ABS       ABS_MT_TRACKING_ID   ffffffff
EV_SYN       SYN_REPORT           00000000




EV_ABS       ABS_MT_TRACKING_ID   00001a8e
EV_ABS       ABS_MT_POSITION_X    0000011a
EV_ABS       ABS_MT_POSITION_Y    00000423
EV_SYN       SYN_REPORT           00000000
EV_ABS       ABS_MT_POSITION_X    0000021b
EV_SYN       SYN_REPORT           00000000
EV_ABS       ABS_MT_POSITION_X    00000355
EV_SYN       SYN_REPORT           00000000
EV_ABS       ABS_MT_TRACKING_ID   ffffffff
EV_SYN       SYN_REPORT           00000000








EV_ABS       ABS_MT_TRACKING_ID   000015e0
EV_ABS       ABS_MT_TOUCH_MAJOR   00000008
EV_ABS       ABS_MT_POSITION_X    000002c8
EV_ABS       ABS_MT_POSITION_Y    00000438
EV_SYN       SYN_REPORT           00000000
EV_ABS       ABS_MT_TRACKING_ID   ffffffff
EV_SYN       SYN_REPORT           00000000








"""
lines = lines.split("\n")

while True:
    sendSimTouch("code.mk")
#sendSimTouch("code.mk")
