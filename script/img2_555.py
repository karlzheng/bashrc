#!/usr/bin/env python  
import Image  
import sys   
im = Image.open(sys.argv[1])  
width = im.size[0]  
height = im.size[1]  
print "/* width:%d, height:%d*/"%(width, height)  
count = 0   
for h in range(0, height):  
  for w in range(0, width):  
    pixel = im.getpixel((w, h))
    if (pixel[0] > 255 or pixel[1] > 255 or pixel[2] > 255):
      print "error!!"
      import os
      os.exit(1)
    data = ((pixel[0] & 0xf8) << 8);
    data |= ((pixel[1] & 0xf8) << 3);
    data |= ((pixel[2] & 0xf8) >> 3);
    for i in range(0,2):
      outdata = 0
      if (i == 1):
        outdata = (data & 0xff00) >> 8;
      else:
        outdata = data & 0xff;
      count = (count+1)%16  
      if (count == 0):   
        print "0x%02x,\n"%(outdata),  
      else:  
        print "0x%02x,"%(outdata),  
