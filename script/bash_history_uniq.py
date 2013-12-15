#!/usr/bin/env python

import sys

if len(sys.argv) > 1:
  filename = sys.argv[1]
else:
  filename = "/home/zkl/.bash_history"

fd = open(filename, "rb")
lines = fd.readlines()
line_dict = {}
cnt = 1
for l in lines:
  line_dict[l] = cnt
  cnt += 1
fd.close()

fd = open(filename, "wb")
#fd.writelines(dict(sorted(line_dict.items(), key=lambda d:d[1])).keys())
for sl in sorted(line_dict.items(), key=lambda d:d[1]):
  fd.writelines(sl[0])
fd.close()

