#!/usr/bin/env python
# -*- coding: utf-8 -*-
# uzip.py
#https://blog.csdn.net/babys/article/details/71405731?utm_source=blogxgwz9

import os
import sys
import zipfile

reload(sys)
sys.setdefaultencoding('utf8')

print "Processing File " + sys.argv[1]

file=zipfile.ZipFile(sys.argv[1],"r");
for name in file.namelist():
    try:
        utf8name=name.decode('utf-8')
    except Exception:
        utf8name=name.decode('gbk')
    print "Extracting " + utf8name
    pathname = os.path.dirname(utf8name)
    if not os.path.exists(pathname) and pathname!= "":
        os.makedirs(pathname)
    data = file.read(name)
    if not os.path.exists(utf8name):
        fo = open(utf8name, "w")
        fo.write(data)
        fo.close
file.close()
