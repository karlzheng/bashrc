#!/bin/sh

while read l
  do
	if [ -d "$l" ];then
		svn log "$l"
		if [ "$?" != 0 ];then
			svn add "$l"
		fi
	fi
  done < $1

while read l
  do
	if [ ! -d "$l" ];then
		svn add "$l"
	fi
  done < $1
