#!/bin/bash - 
#===============================================================================
#
#          FILE:  svnd.sh
# 
#         USAGE:  cp this file to /etc/init.d/svnd.sh
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#       COMPANY: Alibaba
#       CREATED: 2014年01月26日 20时58分50秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#/etc/init.d/svnd.sh
/usr/bin/svnserve -d -r /1t/svn
