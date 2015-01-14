#!/bin/bash -
#===============================================================================
#
#          FILE:  1.sh
#
#         USAGE:  ./1.sh
#
#   DESCRIPTION:
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#       COMPANY: Alibaba
#       CREATED: 2012年08月07日 16时27分01秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

filename=$(basename $0)
: > /tmp/$filename.txt
while read l
do
	echo "$l" >> /tmp/$filename.txt
done

wakelock_align_output.py /tmp/$filename.txt

