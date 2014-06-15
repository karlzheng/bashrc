#!/usr/bin/env python
#encoding:utf8
#===============================================================================
#
#          FILE:  rtar.py
#
#         USAGE:  "rtar.py gitLogHash1 gitLogHash2" for save changes between
#                 gitLogHash1 and gitLogHash2; or only type "rtar.py" for save
#                 changes between HEAD^ and HEAD
#
#   DESCRIPTION:  save all modified files in a tar file: /tmp/rtar.tar
#                 save deleted file name to /tmp/rm.list
#
#        AUTHOR: Karl Zheng
#       COMPANY: Alibaba,inc
#       CREATED: date: 2014/06/11 Wed 03:27:25 PM
#      REVISION:  ---
#===============================================================================

import re
import sys
import time
import commands as cmds

def printTimeStamp():
    print time.strftime('%H:%M:%S', time.localtime())

deletedFileNames = []
modifiedFileNames = []

def processAGitLog(d, fn):
	global deletedFileNames
	global modifiedFileNames
	cmdarg = "pwd"
	cwd = cmds.getstatusoutput(cmdarg)[1] + "/"
	d = d[len(cwd):] + "/"

	fd = open(fn, "rb")
	lines = fd.readlines()
	fd.close()
	predir = ""
	# sm: state machine
	# sm: 0 not start
	# sm: 1 got
	ms = 0
	fa = ""
	fb = ""
	for l in lines:
		pattern = '^A\s+(.*)'
		m = re.match(pattern, l)
		if m != None:
			f = m.groups()[0]
                        elem = d + f
                        if elem not in modifiedFileNames:
                            modifiedFileNames.append(d + f)
		else:
			pattern = '^M\s+(.*)'
			m = re.match(pattern, l)
			if m != None:
				f = m.groups()[0]
                                elem = d + f
                                if elem not in modifiedFileNames:
                                    modifiedFileNames.append(elem)
			else:
				pattern = '^D\s+(.*)'
				m = re.match(pattern, l)
				if m != None:
					f = m.groups()[0]
                                        elem = d + f
                                        if elem not in deletedFileNames:
                                            deletedFileNames.append(elem)

def saveModifiedFileName():
	global modifiedFileNames
	global deletedFileNames

	fd = open("/tmp/mf.list", "w+")
	for l in modifiedFileNames:
		l = l.strip()
		fd.writelines(l + "\n")
	fd.close()

        cmdarg = """for f in $(cat /tmp/mf.list);do tar rf /tmp/rtar.tar \
        ${f};done""" 
        cmds.getstatusoutput(cmdarg)

	fd = open("/tmp/rm.list", "w+")
        for l in deletedFileNames:
                l = l.strip()
                fd.writelines(l + "\n")
	fd.close()


def gitDiffLogAddPrefix(fn):
	cmdarg = "git diff --name-status %s %s > %s"%(h1, h2, fn)
	cmds.getstatusoutput(cmdarg)

def getRepoPathes(fn):
	cmdarg = ": > %s;repo forall -c 'pwd >> %s'"%(fn, fn)
	cmds.getstatusoutput(cmdarg)[1]

def getRepoModification(d):
	fn = "/tmp/gitdiff.log"
	cmdarg = "cd %s;git log | grep \"^commit \w\{40\}$\" | \
                awk '{print $2}' > %s"%(d, fn)
	cmds.getstatusoutput(cmdarg)
	cmdarg = "cat %s | head -n 1"%(fn)
	newHash = cmds.getstatusoutput(cmdarg)[1]
	cmdarg = "cat %s | tail -n 1"%(fn)
	oldHash = cmds.getstatusoutput(cmdarg)[1]
	cmdarg = "cd %s;git diff --name-status %s %s > %s" \
                %(d, oldHash, newHash, fn)
	cmds.getstatusoutput(cmdarg)
	processAGitLog(d, fn)

def getRepoesModifications(fn):
	fd = open(fn, "rb")
	lines = fd.readlines()
	fd.close()
	for l in lines:
		l = l.strip()
		getRepoModification(l)

if __name__ == '__main__':
	if len(sys.argv) > 2:
		hash2 = sys.argv[2]
	else:
		hash2 = "HEAD"
	if len(sys.argv) > 1:
		hash1 = sys.argv[1]
	else:
		hash1 = "HEAD^"
	fn = "/tmp/gitdiff.log"
	
        cmdarg = "if [ -f /tmp/mf.list ];then rm /tmp/mf.list;fi"
	cmds.getstatusoutput(cmdarg)

        cmdarg = "if [ -f /tmp/rm.list ];then rm /tmp/rm.list;fi"
	cmds.getstatusoutput(cmdarg)

        cmdarg = "if [ -f /tmp/rtar.tar ];then rm /tmp/rtar.tar;fi"
        cmds.getstatusoutput(cmdarg)

	getRepoPathes("/tmp/repoPathes.log")
	getRepoesModifications("/tmp/repoPathes.log")
        saveModifiedFileName()
