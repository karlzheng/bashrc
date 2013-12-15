#!/usr/bin/env python

import sys

fd = open(sys.argv[1], "rb")
data = fd.read(1024)
cnt = 0
while len(data):
  for c in data:
    if (cnt%16 == 0):
      print "%08x "%cnt,
    hex = ord(c)
    print "%02x"%(hex),
    if (cnt%16 == 15):
      print ""
    cnt += 1
   
  data = fd.read(1024)

fd.close()

