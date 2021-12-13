#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from PIL import Image
img = Image.open('screenshot.png')
 
Img = img.convert('L')
Img.save("gray.jpg")
 
threshold = 200
#threshold = 100
 
table = []
for i in range(256):
    if i < threshold:
        table.append(0)
    else:
        table.append(1)
 
photo = Img.point(table, '1')
#photo.save("test2.jpg")

# 480 -> 540
# 340 -> 368
x = 480
y = 340
w = 60
h = 28
region = photo.crop((x, y, x + w, y + h))
region.save("./z.jpeg")

#zt 736 344 -> 786,368
zt = (736,344,786,368)
region = photo.crop(zt)
region.save("./zt.jpeg")

x = 430
y = 340
region = photo.crop((x, y, 1100, 430))
region.save("./num.jpeg")
