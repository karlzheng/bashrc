#!/usr/bin/env python
#coding=utf-8

import hjson
import sys
import os
#sys.path.append("..")
import urllib
import json
from datetime import datetime
import time 
from lxml import etree
import re

if len(sys.argv) > 1:
  fn = sys.argv[1]

def read_lines(filename):
    ifd = open(filename, "rb")
    lines = ifd.readlines()
    ifd.close()
    return lines

def align_lines(lines):
    mwpl = 0
    for l in lines:
        words = l.strip().split()
        #print(words)
        if (len(words) > mwpl):
            mwpl = len(words)
    wordlen = range(0, mwpl)
    i = 0
    print(mwpl)
    while i < mwpl:
        wordlen[i] = 0
        i += 1

    for l in lines:
        words = l.strip().split()
        i = 0
        while i < len(words):
            if (wordlen[i] < len(words[i].strip())):
                wordlen[i] = len(words[i].strip())
            i += 1

    out_lines = []
    for l in lines:
        words = l.strip().split()
        i = 0
        ol = ""
        while i < len(words):
            #print(wordlen[i], len(words[i]))
            if (wordlen[i] > len(words[i])):
                ol += ' '*(wordlen[i]-len(words[i]))
            ol += words[i].strip()
            ol += " "
            i += 1
        #ol += "\r\n"
        out_lines.append(ol)
    return out_lines
    
def write_lines(fn, out_lines):
    ofd = open(fn, "wb")
    for l in out_lines:
        l = str(l) + "\r\n"
        ofd.write(l)
        #print(l)
    ofd.close()
    return

if __name__ == "__main__":
    lines = read_lines(fn)
    lines = align_lines(lines)
    #print(lines)
    write_lines(fn, lines)
