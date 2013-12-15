#!/bin/bash - 
#===============================================================================
#
#          FILE:  sgmf.sh
# 
#         USAGE:  ./sgmf.sh 
# 
#   DESCRIPTION:  sgmf = svn get modified files
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (http://blog.csdn.net/zhengkarl), ZhengKarl#gmail.com
#       COMPANY: Alibaba
#       CREATED: 2010年09月26日 10时15分37秒 CST
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

function gitloghead()
{
	local tmpfile="/tmp/gitloghead.log"
	if [ $# -ge 1 ];then
		if [ -f $tmpfile ];then
			mv $tmpfile $tmpfile.old -f
		fi
		local startaddress=$(($1-200))
		if [ $startaddress -lt 0 ];then
			startaddress=0
		fi;
		if [ $# -ge 2 ];then
			local stopaddress=$2
		else
			local stopaddress=$(($startaddress+400))
		fi
		echo "$startaddress,${stopaddress}p"
		sed -n "$startaddress,${stopaddress}p" git.log > $tmpfile
		vi $tmpfile
	fi
}

gitloghead $@

