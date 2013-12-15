#!/usr/bin/env python

import sys

fd = open(sys.argv[1], "rb")
#fd = open(sys.argv[1], "r")
data = fd.read(1024)
cnt = 0
while len(data):
	for c in data:
		hex = ord(c)
		if (c == '\r'):
			sys.stdout.write("%c%c"%("\\", "r"))
		else:
			if (c == '\n'):
				sys.stdout.write("%c%c"%("\\", "n"))
			else:
				if (c == '\t'):
					sys.stdout.write("%c%c"%("\\", "t"))
				else:
					sys.stdout.write("%c"%(hex))
		if (cnt%16 == 15):
			sys.stdout.write("%c\n"%("\\"))
		cnt += 1
	data = fd.read(1024)

fd.close()

