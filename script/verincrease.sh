#!/bin/bash -

python - $1 << EEOOFF
#!/usr/bin/env python
#encoding:utf8

import sys
import struct

def p(lines):
	a1, a2, b1, b2, c1, c2 = struct.unpack('cccccc', lines)
	v1 = int(a1 + a2)
	v2 = int(b1 + b2)
	v3 = int(c1 + c2)
	v3 += 1
	if v3 > 99:
		v2 += 1
		v3 = 1
	if v2 > 99:
		v1 += 1
		v2 = 1

	ver = ("%02d%02d%02d"%(v1, v2, v3))
	return ver

def main(argv):
	if len(argv) > 1:
		filename = argv[1]
	else:
		print "No file is designated!!"
		sys.exit(1)

	ifd = open(filename, "rb")
	#print filename

	lines = ifd.readline().strip()
	ifd.close()

	print p(lines)

if __name__ == '__main__':
	main(sys.argv)

EEOOFF
