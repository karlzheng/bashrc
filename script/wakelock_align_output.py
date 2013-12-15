#!/usr/bin/env python
#encoding:utf8
#===============================================================================
#
#          FILE:  wakelock_align_output.py
# 
#         USAGE:  1. execute: adb shell cat /proc/wake_lock > wake_lock.log
#                 2. execute: python wakelock_align_output.py wake_lock.log
# 
#   DESCRIPTION:  
# 
#        AUTHOR: Karl Zheng 
#       COMPANY: Alibaba
#       CREATED: 2011年10月18日 15时25分15秒 CST
#      REVISION:  ---
#===============================================================================

import sys

if len(sys.argv) > 1:
	filename = sys.argv[1]
else:
	print "No file is designated!!"
	sys.exit(1)
ifd = open(filename, "rb")

lines = ifd.readlines()

mwpl = 0
for l in lines:
	words = l.strip().split()
	if (len(words) > mwpl):
		mwpl = len(words)

wordlen = range(0, mwpl)
i = 0
while i < mwpl:
	wordlen[i] = 0
	i += 1

for l in lines:
	words = l.strip().split()
	i = 0
	while i < len(words):
		if (wordlen[i] < len(words[i].strip())):
			wordlen[i] = len(words[i].strip()) 
		i += 1

for l in lines:
	words = l.strip().split()
	i = 0
	while i < len(words):
		print words[i].strip(),
		if (wordlen[i] > len(words[i])):
			print ' '*(wordlen[i]-len(words[i])-1),
		i += 1
	print ""

ifd.close()

