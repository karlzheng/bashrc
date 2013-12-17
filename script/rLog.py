#!/usr/bin/env python
#encoding:utf8
#===============================================================================
#
#          FILE:  rLog.py
#
#         USAGE:  ./rLog.py [logFileName]
#
#   DESCRIPTION:  run ./rLog.py [logFileName], and then it will generate a file 
#                 repo.log in the current Android repo dir.
#
#        AUTHOR: Karl Zheng
#       COMPANY: Alibaba,inc
#       CREATED: 2013年10月18日 15时25分15秒 CST
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

loglines = []
logs = []

lock = threading.Lock() 
appendLock = threading.Lock() 

def add_dir_line(fn):
    global loglines
    fd = open(fn, "rb")
    lines = fd.readlines()
    fd.close()
    line_dict = {}
    predir = lines[0]
    loglen = len(lines)
    i = 1
    loglines.append(predir)
    for l in lines[1:]:
      if re.search("commit [a-z|0-9]{40}$", l):
	  if len(lines[i-1].strip()) == 0:
	      loglines.append(predir)
	  else:
	      predir = lines[i-1]
      loglines.append(l)
      i += 1

def appendLog(log):
    appendLock.acquire()
    logs.append(log)
    appendLock.release()

def getLogSepPos(lines):
    global limit
    loglen = len(lines)
    end = 0

    if loglen <= limit:
	end = loglen
    else:
	end = limit
	while end > 0:
	    l = lines[end]
	    if re.search("commit [a-z|0-9]{40}$", l):
		l = lines[end - 1]
		while end > 0:
		    if len(l.strip()) == 0:
			return end
		    else:
			end -= 1
			l = lines[end - 1]
	    else:
		end -= 1
    return end

def seperateLogProcess(lines):
    loglen = len(lines)
    print "total count of log lines:", loglen
    global limit
    if (loglen / 40) > limit:
	limit = loglen / 40
    start = 0
    thread_pool = []
    while start < loglen -1:
	plen = getLogSepPos(lines[start:])
	end = start + plen + 1
	aThread = threading.Thread(target = processLog, args=(lines[start:end], ))
	thread_pool.append(aThread)
	start += plen + 1
    print "%s %d"%(__file__, inspect.currentframe().f_lineno),
    printTimeStamp()
    print " %d threads in thread_pool will run !!"%(len(thread_pool))
    for aThread in thread_pool:
	aThread.start()
    for aThread in thread_pool:
	aThread.join()

def processLog(lines):
    loglen = len(lines)
    i = 0
    end = 0
    start = 0
    log = []
    datestr = 0
    for l in lines[0:]:
	if l == "\n":
	    end = i
	else:
	    try:
		if re.search("^commit [a-z|0-9]{40}$", l):
		    if start < end:
			log = []
			log.append(lines[start:end + 1])
			log.append(datestr)
			appendLog(log)
			start = end + 1
		else:
		    if re.search("^Date:   ", l):
			try:
			    lock.acquire()
			    datestr = time.strptime(l[8:32].strip(), "%c")
			    datestr = int(time.mktime(datestr))
			    lock.release()
			except Exception,e:
			    print ("%s %d" %(__file__, inspect.currentframe().f_lineno))
			    lock.release()
			#datestr = l[8:32].strip()
			#delta = datetime.strptime(datestr, '%a %b %d %H:%M:%S %Y')
			#epoch = datetime.utcfromtimestamp(0)
			#delta = str((delta - epoch).total_seconds())
			#datestr = delta.split('.')[0]
	    except Exception,e:
		lock.acquire()
		print ("%s %d" %(__file__, inspect.currentframe().f_lineno))
		print e
		print "datestr: ", datestr
		print "log: ", log
		print ("%s %d" %(__file__, inspect.currentframe().f_lineno))
		lock.release()
	i += 1
    if i == len(lines):
	log = []
	log.append(lines[start:])
	log.append(datestr)
	logs.append(log)

def saveLog(fn):
    #fn = fn + ".tmp"
    fd = open(fn, "wb")
    for l in logs:
	if (l[1]) == 0:
	    print (l[1])
	    print (l[0])
	fd.writelines(l[0])
    fd.close()
    cmdarg = "mv %s repo.log"%(fn)
    cmds.getstatusoutput(cmdarg)

def sortLog():
    global logs
    print "logs count: ", len(logs)
    logs = sorted(logs, key=lambda d:d[1], reverse=True)
    
def genGitLog(fn):
    cmdarg = ": > %s;"%(fn)
    cmdarg += "repo forall -c 'pwd >> %s;git log >> %s;echo >> %s'"%(fn, fn, fn)
    cmds.getstatusoutput(cmdarg)

if __name__ == '__main__':
    if len(sys.argv) > 1:
      fn = sys.argv[1]
    else:
      fn = "/tmp/git.tmp.log"

    print "%s %d"%(__file__, inspect.currentframe().f_lineno),
    printTimeStamp()
    genGitLog(fn)

    print "%s %d"%(__file__, inspect.currentframe().f_lineno),
    printTimeStamp()
    add_dir_line(fn)

    print "%s %d"%(__file__, inspect.currentframe().f_lineno),
    printTimeStamp()
    seperateLogProcess(loglines)

    print "%s %d"%(__file__, inspect.currentframe().f_lineno),
    printTimeStamp()
    sortLog()

    print "%s %d"%(__file__, inspect.currentframe().f_lineno),
    printTimeStamp()
    saveLog("repo.log")

    print "%s %d"%(__file__, inspect.currentframe().f_lineno),
    printTimeStamp()
