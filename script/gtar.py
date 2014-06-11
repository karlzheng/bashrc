#!/usr/bin/env python
#encoding:utf8
#===============================================================================
#
#          FILE:  gtar.py
#
#         USAGE:  gtar.py gitLogHash1 gitLogHash2 for save changes between 
#                 gitLogHash1 and gitLogHash2; or only type "gtar.py" for save 
#                 changes between HEAD^ and HEAD
#
#   DESCRIPTION:  save all modified files in a tar file: gtar.tar
#                 save deleted file name to rm.list
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

def processLog(fn):
	deletedFileNames = []
	modifiedFileNames = []

	fd = open(fn, "rb")
	lines = fd.readlines()
	fd.close()
	predir = ""
	# ms: machine state;
	# ms: 0 not start
	# ms: 1 delte file
	ms = 0
	fa = ""
	fb = ""
	for l in lines:
		if re.search("^diff --git a/", l):
			#print l
			ms = 1
			pattern = 'diff --git a/(.*)b/(.*)'
			m = re.match(pattern, l)
			fa = m.groups()[0]
			fb = m.groups()[1]
		else:
			if ms > 0:
				if re.search("deleted file mode", l):
					deletedFileNames.append(fa)
					ms = 0
			if ms > 0:
				if re.search("new file mode", l):
					modifiedFileNames.append(fa)
					ms = 0
			if ms > 0:
				if re.search("Binary files a/.*differ", l):
					modifiedFileNames.append(fa)
					ms = 0
			if ms > 0:
				if re.search("--- a/", l):
					modifiedFileNames.append(fa)
					ms = 0

	cmdarg = "if [ -f gtar.tar ];then rm gtar.tar;fi"
	cmds.getstatusoutput(cmdarg)
	print "/tmp/mf.list :"
	fd = open("/tmp/mf.list", "wb")
	for l in modifiedFileNames:
		l=l.strip()
		#cmdarg = "IFS=$'\n' tar rf gtar.tar \"%s\""%(l)
		cmdarg = "tar rf gtar.tar \"%s\""%(l)
		cmds.getstatusoutput(cmdarg)
		print l
		fd.writelines(l + "\n")
	fd.close()
	print ""
	print "rm.list :"
	fd = open("rm.list", "wb")
	for l in deletedFileNames:
		print l
		fd.writelines(l + "\n")
	fd.close()

def genGitLog(h1, h2, fn):
	cmdarg = "git diff %s %s | grep -A 5 'diff \-\-git' > %s"%(h1, h2, fn)
	cmds.getstatusoutput(cmdarg)

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

	#printTimeStamp()
	genGitLog(hash1, hash2, fn)
	processLog(fn)
