#!/bin/bash - 
#===============================================================================
#
#          FILE:  rmBlank.sh
# 
#         USAGE:  ./rmBlank.sh 
# 
#   DESCRIPTION:  rm line tail blank 
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#       COMPANY: Meizu
#       CREATED: 2014年10月28日 09时44分58秒 CST
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

find *.c -exec sed -i -e 's#[[:blank:]]\+$##' {} \;
find *.h -exec sed -i -e 's#[[:blank:]]\+$##' {} \;
