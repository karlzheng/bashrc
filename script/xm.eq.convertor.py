#!/usr/bin/env python
#encoding:utf8
#===============================================================================
#
#          FILE:  wakelock_align_output.py
#
#         USAGE:
#
#   DESCRIPTION:
#
#        AUTHOR: Karl Zheng
#       COMPANY: Anker
#       CREATED: 2011年10月18日 15时25分15秒 CST
#      REVISION:  ---
#===============================================================================

import sys
from struct import *

if len(sys.argv) > 1:
	filename = sys.argv[1]
else:
	print "No file is designated!!"
	sys.exit(1)

ifd = open(filename, "rb")

lines = ifd.readlines()

for l in lines:
	words = l.strip().split()
	ofn = (words[0]) + ".eq"
	ofd = open(ofn, "wb")
	bin = pack('H', int(words[1]))
	data = words[2:]
	for d in data:
		bin += pack('B', int(d))
	ofd.write(bin)
	ofd.close()
