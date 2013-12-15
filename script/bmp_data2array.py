#!/usr/bin/env python
import bmp_data

data_len = len(bmp_data.data)
width = bmp_data.width
height = bmp_data.height

if (data_len != width*height*3):
  print data_len
  print width*height*3
  print "data_len != width*height*3)"
  exit(1)

data = []

h = height-1
while h >= 0:
  w = 0
  while w < width:
    #print "%d"%(((width*h + w) * 3 + 1))
    data.append(bmp_data.data[(width*h + w) * 3 + 0]) 
    data.append(bmp_data.data[(width*h + w) * 3 + 1]) 
    data.append(bmp_data.data[(width*h + w) * 3 + 2]) 
    w += 1
  h -= 1

i = data_len-1

import sys
count = 0;
while i>=0:
  count = (count + 1)%16
  if (i != 0):
    if (count == 0):
      str = "0x%02x%c\n"%(data[i], ',')
    else:
      str = "0x%02x%c"%(data[i], ',')
  else:
    str = "0x%02x"%(data[i])

  sys.stdout.write(str);
  i -= 1
  
