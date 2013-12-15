#!/usr/bin/env python

import sys
import binascii

fd = open(sys.argv[1], "r")
lines = fd.readlines()

func = lambda e:binascii.a2b_hex(e)

for l in lines:
  colon_index = 0
  try:
    colon_index = l.index(':')
    l = l[colon_index+1:]
  except:
    colon_index = 0

  elems = l.strip().split()
  for e in elems:
    hex = func(e)
    #print hex,
    sys.stdout.write(hex)

fd.close()


