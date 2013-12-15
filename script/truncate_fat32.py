#!/usr/bin/env python
# This file uses the following encoding: utf-8
#===============================================================================
#          FILE:  truncate_fat32.py
# 
#         USAGE:  python ./truncate_fat32.py fat32.img 
# 
#   DESCRIPTION:  for rm all the empty data in the tail of fat32 img
# 
#        AUTHOR: Karl Zheng 
#       COMPANY: Alibaba
#       CREATED: 2011年10月18日 15时25分15秒 CST
#      REVISION:  ---
#===============================================================================

import sys

block_size = 4096
zero_buf = '\0'* block_size 

if len(sys.argv) == 2:
	filename = sys.argv[1]
else:
	print "Usage:python %s [file name to be truncated]"%(sys.argv[0])
	sys.exit(1)

ifd = open(filename, "r+wb")

buf=""

# get filelen
ifd.seek(0, 2)
file_len = ifd.tell()
print "file len:", file_len

remain_len = file_len

while remain_len >= block_size:
	remain_len -= block_size
	ifd.seek(remain_len, 0)
	buf = ifd.read(block_size)
	if (buf != zero_buf):
		remain_len += block_size
		break;
print "remain_len:", remain_len
ifd.seek(remain_len, 0)
ifd.truncate()

print "write done"

ifd.close()


