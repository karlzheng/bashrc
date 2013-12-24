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
	    print a1, a2, a3
	    print elems
	    print cmd
	    cmds.getstatusoutput(cmd)
    #fd.close()

lines = """

EV_ABS       ABS_MT_TRACKING_ID   000015de            
EV_ABS       ABS_MT_PRESSURE      00000050            
EV_ABS       ABS_MT_TOUCH_MAJOR   00000008            
EV_ABS       ABS_MT_POSITION_X    000000f7            
EV_ABS       ABS_MT_POSITION_Y    0000035b            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000055            
EV_ABS       ABS_MT_TOUCH_MAJOR   00000009            
EV_ABS       ABS_MT_POSITION_X    000000f8            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000000fa            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000056            
EV_ABS       ABS_MT_POSITION_X    000000fe            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000105            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000057            
EV_ABS       ABS_MT_POSITION_X    0000010f            
EV_ABS       ABS_MT_POSITION_Y    0000035a            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    0000011a            
EV_ABS       ABS_MT_POSITION_Y    00000359            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000058            
EV_ABS       ABS_MT_POSITION_X    00000126            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000059            
EV_ABS       ABS_MT_POSITION_X    00000134            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000058            
EV_ABS       ABS_MT_POSITION_X    00000144            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000059            
EV_ABS       ABS_MT_POSITION_X    00000158            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000058            
EV_ABS       ABS_MT_POSITION_X    0000016a            
EV_ABS       ABS_MT_POSITION_Y    00000358            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000059            
EV_ABS       ABS_MT_POSITION_X    00000180            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000198            
EV_ABS       ABS_MT_POSITION_Y    00000357            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000001b0            
EV_ABS       ABS_MT_POSITION_Y    00000356            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      0000005a            
EV_ABS       ABS_MT_POSITION_X    000001c8            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000059            
EV_ABS       ABS_MT_POSITION_X    000001e3            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000001fe            
EV_ABS       ABS_MT_POSITION_Y    00000355            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      0000005a            
EV_ABS       ABS_MT_POSITION_X    00000219            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      0000005b            
EV_ABS       ABS_MT_POSITION_X    00000237            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000059            
EV_ABS       ABS_MT_POSITION_X    00000250            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      0000005a            
EV_ABS       ABS_MT_POSITION_X    00000269            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000286            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000059            
EV_ABS       ABS_MT_POSITION_X    000002a2            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      0000005a            
EV_ABS       ABS_MT_POSITION_X    000002ba            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000002d1            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000002e8            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000002fb            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    0000030f            
EV_ABS       ABS_MT_POSITION_Y    00000356            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      0000005b            
EV_ABS       ABS_MT_POSITION_X    00000321            
EV_ABS       ABS_MT_POSITION_Y    00000357            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_TOUCH_MAJOR   0000000a            
EV_ABS       ABS_MT_POSITION_X    00000333            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000341            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    0000034c            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      0000005c            
EV_ABS       ABS_MT_POSITION_X    00000356            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    0000035f            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000367            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    0000036e            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      0000005b            
EV_ABS       ABS_MT_POSITION_X    00000374            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      0000005a            
EV_ABS       ABS_MT_POSITION_X    00000379            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000058            
EV_ABS       ABS_MT_TOUCH_MAJOR   00000009            
EV_ABS       ABS_MT_POSITION_X    0000037d            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000054            
EV_ABS       ABS_MT_TOUCH_MAJOR   00000008            
EV_ABS       ABS_MT_POSITION_X    00000380            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      0000004a            
EV_ABS       ABS_MT_POSITION_X    00000383            
EV_ABS       ABS_MT_POSITION_Y    00000358            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      0000003c            
EV_ABS       ABS_MT_TOUCH_MAJOR   00000007            
EV_ABS       ABS_MT_POSITION_X    00000384            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_TRACKING_ID   ffffffff            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_TRACKING_ID   000015df            
EV_ABS       ABS_MT_PRESSURE      0000004a            
EV_ABS       ABS_MT_POSITION_X    00000105            
EV_ABS       ABS_MT_POSITION_Y    00000402            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000058            
EV_ABS       ABS_MT_TOUCH_MAJOR   00000009            
EV_ABS       ABS_MT_POSITION_X    00000106            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000107            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_TOUCH_MAJOR   0000000a            
EV_ABS       ABS_MT_POSITION_X    00000109            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    0000010c            
EV_ABS       ABS_MT_POSITION_Y    00000403            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000059            
EV_ABS       ABS_MT_POSITION_X    00000111            
EV_ABS       ABS_MT_POSITION_Y    00000404            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000117            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000058            
EV_ABS       ABS_MT_TOUCH_MAJOR   00000009            
EV_ABS       ABS_MT_POSITION_X    0000011e            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000124            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000057            
EV_ABS       ABS_MT_POSITION_X    0000012b            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000059            
EV_ABS       ABS_MT_TOUCH_MAJOR   0000000a            
EV_ABS       ABS_MT_POSITION_X    00000135            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    0000013f            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_TOUCH_MAJOR   00000009            
EV_ABS       ABS_MT_POSITION_X    0000014a            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000156            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000163            
EV_ABS       ABS_MT_POSITION_Y    00000403            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    0000016e            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    0000017a            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      0000005a            
EV_ABS       ABS_MT_POSITION_X    00000187            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000059            
EV_ABS       ABS_MT_POSITION_X    00000195            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000001a3            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000001b2            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000001c1            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      0000005a            
EV_ABS       ABS_MT_POSITION_X    000001d1            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000059            
EV_ABS       ABS_MT_POSITION_X    000001e2            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000001f3            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000058            
EV_ABS       ABS_MT_POSITION_X    00000203            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000059            
EV_ABS       ABS_MT_POSITION_X    00000213            
EV_ABS       ABS_MT_POSITION_Y    00000402            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000223            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000058            
EV_ABS       ABS_MT_POSITION_X    00000234            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000059            
EV_ABS       ABS_MT_POSITION_X    00000244            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000252            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000058            
EV_ABS       ABS_MT_POSITION_X    0000025f            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000059            
EV_ABS       ABS_MT_POSITION_X    0000026c            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000279            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000287            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000058            
EV_ABS       ABS_MT_POSITION_X    00000294            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000002a2            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000002ad            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000002bb            
EV_ABS       ABS_MT_POSITION_Y    00000403            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000002c8            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000002d5            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000002e2            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000002ef            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    000002fa            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000303            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000059            
EV_ABS       ABS_MT_POSITION_X    0000030d            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000317            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000321            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000058            
EV_ABS       ABS_MT_POSITION_X    0000032b            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000334            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000057            
EV_ABS       ABS_MT_POSITION_X    0000033c            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_POSITION_X    00000345            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000056            
EV_ABS       ABS_MT_TOUCH_MAJOR   00000008            
EV_ABS       ABS_MT_POSITION_X    0000034d            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000053            
EV_ABS       ABS_MT_POSITION_X    00000354            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      0000004e            
EV_ABS       ABS_MT_POSITION_X    0000035b            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      00000046            
EV_ABS       ABS_MT_POSITION_X    00000365            
EV_ABS       ABS_MT_POSITION_Y    00000404            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_PRESSURE      0000003a            
EV_ABS       ABS_MT_TOUCH_MAJOR   00000007            
EV_ABS       ABS_MT_POSITION_X    0000036f            
EV_ABS       ABS_MT_POSITION_Y    00000406            
EV_SYN       SYN_REPORT           00000000            
EV_ABS       ABS_MT_TRACKING_ID   ffffffff            
EV_SYN       SYN_REPORT           00000000            




EV_ABS       ABS_MT_TRACKING_ID   000015e0            
EV_ABS       ABS_MT_PRESSURE      00000051            
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
    time.sleep(1)
#sendSimTouch("code.mk")
