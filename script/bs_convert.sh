#!/bin/sh
#str="'"$v1"'"
#echo $str
echo $1 |sed -e 's#\\#\/#g' > ~/tmp/filename.txt
filename=$(cat ~/tmp/filename.txt)
#echo $filename
#svn diff -r 196 $filename
#filename=`echo $1|sed -e 's#\\#\/#g'`
#echo $1|sed -e 's#\\#\/#g'
echo $filename
#svn diff -r 196 $filename
