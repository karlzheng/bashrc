#!/bin/bash - 
#===============================================================================
#
#          FILE:  svn_revert_all.sh
# 
#         USAGE:  ./svn_revert_all.sh 
# 
#   DESCRIPTION:  do the "svn revert " command to all the modified files 
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (http://blog.csdn.net/zhengkarl), ZhengKarl@gmail.com
#       COMPANY: Alibaba
#       CREATED: 2010年10月07日 17时05分06秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

echo "pls input y to confirm svn revert all diff"
read y
if [ x"$y" = "xy" ]; then
svn diff |grep ^Index|awk '{print $2 }'|xargs svn revert
else
  echo "not exec svn diff |grep ^Index|awk '{print $2 }'|xargs svn revert"
fi
