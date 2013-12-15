#!/bin/bash 
#===============================================================================
#
#          FILE:  mgrep.sh
# 
#         USAGE:  ./mgrep.sh 
# 
#   DESCRIPTION:  mgrep = grep in multi dirs
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

SEACH_RESULT_FILE="/dev/shm/$(whoami)/quickfix.txt"

: > $SEACH_RESULT_FILE

echo "$@" | tee -a $SEACH_RESULT_FILE

if [ $(whoami) != "karlzheng" ];then
    cp  $SEACH_RESULT_FILE "${HOME}/quickfix.txt"
fi

