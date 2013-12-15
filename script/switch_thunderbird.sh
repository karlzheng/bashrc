#!/bin/bash - 
#===============================================================================
#
#          FILE:  switch.sh
# 
#         USAGE:  ./switch.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#       COMPANY: Alibaba
#       CREATED: 2013年03月20日 15时52分41秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if [ -h ~/.thunderbird ];then
    echo "is link"
    mv ~/.thunderbird /tmp
    mv ~/.thunderbird.de ~/.thunderbird
else
    mv ~/.thunderbird ~/.thunderbird.de
    ln -s $(pwd)/.thunderbird/ ~/.thunderbird
fi

