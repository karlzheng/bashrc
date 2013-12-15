#!/bin/bash -
#http://blog.longwin.com.tw/2009/11/vimdiff-vs-git-diff-2009/
echo "$2" "$5"
#cp "$2" /tmp/gitdiff.c -a
cp "$2" "$2.git.c" -a
cp "$5" "$5.git.c" -a
ls -l "$2" "$5"
#vimdiff -R "$2" "$5"
bcompare "$2.git.c" "$5.git.c" &
#bcompare "/tmp/gitdiff.c" "$5" &

