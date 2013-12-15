#!/usr/bin/env python  
import Image  
import sys   
im = Image.open(sys.argv[1])  
width = im.size[0]  
height = im.size[1]  
print "/* width:%d, height:%d*/"%(width, height)  
#print "/* height:%d */"%(height)  
count = 0   
for h in range(0, height):  
  for w in range(0, width):  
    pixel = im.getpixel((w, h))   
    #print type(pixel)
    count = (count+1)%16  
    if (count == 0):   
      print "0x%02x,\n"%(pixel),  
    else:  
      print "0x%02x,"%(pixel),  
