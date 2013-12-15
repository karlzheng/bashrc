#!/usr/bin/env python
#encoding:utf8
#===============================================================================
#
#          FILE:  getRepoLog.py
# 
#         USAGE:  ./getRepoLog.py [logFileName]
# 
#   DESCRIPTION:  run ./getRepoLog.py [logFileName], and then it will generate
#                 a file repo.log in the current dir.
# 
#        AUTHOR: Karl Zheng 
#       COMPANY: Alibaba,inc 
#       CREATED: 2011年10月18日 15时25分15秒 CST
#      REVISION:  ---
#===============================================================================

import sys
import re
import commands as cmds

def add_dir_line(fn):
    fd = open(fn, "rb")
    lines = fd.readlines()
    outlines = []
    line_dict = {}
    predir = lines[0]
    loglen = len(lines)
    i = 1
    outlines.append(predir)
    for l in lines[1:]:
      if re.search("commit [a-z|0-9]{40}$", l):
	  if len(lines[i-1].strip()) == 0:
	      outlines.append(predir)
	  else:
	      predir = lines[i-1]
      outlines.append(l)
      i += 1
    fd.close()
    
    fd = open(fn, "wb")
    fd.writelines(outlines)
    fd.close()

def sortLog(fn):
    fd = open(fn, "rb")
    lines = fd.readlines()
    fd.close()

    log = []
    logs = []
    loglen = len(lines)
    i = 0
    start = 0
    end = 0
    for l in lines[0:]:
	if len(l.strip()) == 0:
	    end = i
	else:
	    if re.search("commit [a-z|0-9]{40}$", l):
		if start < end:
		    log = []
		    log.append(lines[start:end + 1])
		    log.append(datestr)
		    logs.append(log)
		    start = end + 1
	    if re.search("^Date:   ", l):
		cmdarg = 'date -d "%s" +%%s'%(l[8:32])
		datestr = cmds.getstatusoutput(cmdarg)[1]
	i += 1
	if i == len(lines):
	    log = []
	    log.append(lines[start:])
	    log.append(datestr)
	    logs.append(log)
    logs = sorted(logs, key=lambda d:d[1], reverse=True)

    fd = open(fn, "wb")
    for l in logs:
	fd.writelines(l[0])
    fd.close()

if __name__ == '__main__':
    if len(sys.argv) > 1:
      fn = sys.argv[1]
    else:
      fn = "/tmp/git.tmp.log"

    cmdarg = ": > %s"%(fn)
    cmds.getstatusoutput(cmdarg)
    
    cmdarg = "repo forall -c \"pwd >> %s;git log >> %s;echo >> %s\""%(fn, fn, fn)
    cmds.getstatusoutput(cmdarg)
    
    add_dir_line(fn)
    sortLog(fn)
    
    cmdarg = "mv %s repo.log"%(fn)
    cmds.getstatusoutput(cmdarg)
