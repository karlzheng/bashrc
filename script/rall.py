#!/usr/bin/env python
#encoding:utf8
#===============================================================================
#
#          FILE:  rall.py
#
#         USAGE:  ./rall.py 
#
#   DESCRIPTION:  save all modified files in a repo dir to /tmp/rs.tar
#                 rs is short for "repo status"
#
#        AUTHOR: Karl Zheng
#       COMPANY: Alibaba,inc
#       CREATED: 2014年 06月 06日 星期五 09:26:13 CST
#      REVISION:  ---
#===============================================================================

import re
import sys
import time
import inspect;
import threading
import commands as cmds
from datetime import datetime

limit = 5000

def printTimeStamp():
    print time.strftime('%H:%M:%S', time.localtime())

logs = []

lock = threading.Lock() 
appendLock = threading.Lock() 

def processLog(fn):
    modifiedFileNames = []

    fd = open(fn, "rb")
    lines = fd.readlines()
    fd.close()

    predir = ""
    for l in lines:
      if re.search("^project.*branch", l):
          predir = l.split()[1].strip()
      else:
          if re.search(" -m.*", l):
              f = l.split()[1].strip()
              modifiedFileNames.append(predir + f)
          else:
              if re.search(" --.*", l):
                  f = l.split()[1].strip()
                  modifiedFileNames.append(predir + f)
    #print modifiedFileNames
    fd = open("/tmp/rs.log", "wb")
    for l in modifiedFileNames:
	fd.writelines(l+"\n")
    fd.close()
    fd = open("/tmp/rs.tar", "wb")
    fd.close()
    for l in modifiedFileNames:
        cmdarg = "tar rf /tmp/rs.tar %s"%(l)
        cmds.getstatusoutput(cmdarg)

def genRsLog(fn):
    cmdarg = ": > %s;"%(fn)
    cmdarg += "repo status > %s"%(fn)
    cmds.getstatusoutput(cmdarg)

if __name__ == '__main__':
    if len(sys.argv) > 1:
      fn = sys.argv[1]
    else:
      fn = "/tmp/tee.log"

    print "genRsLog(%s)"%(fn),
    printTimeStamp()
    genRsLog(fn)

    print "processLog(%s)"%(fn),
    printTimeStamp()
    processLog(fn)
