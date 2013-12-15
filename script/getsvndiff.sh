#!/bin/bash

ver=`svn log $1 |sed -n '2p;' |awk '{print $1}'`
a=${ver#*r}
echo $a |hexdump
a=`echo $a|tr -d '\r\n'`
#echo $a |hexdump
#let ver+=1
#a=320
echo $a 
#b=`expr $a + 1`
let b=$a+1

echo "b:" $b

