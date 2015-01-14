#!/bin/bash -
#===============================================================================
#
#          FILE:  svnco.sh
#
#         USAGE:  ./svnco.sh
#
#   DESCRIPTION:
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#       COMPANY: Alibaba
#       CREATED: 2011年11月14日 14时51分07秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

svn cleanup
echo "svn up"
svn up
while [ $? != 0 ];do
	echo "svn up again"
	svn up
	sleep 1
done

