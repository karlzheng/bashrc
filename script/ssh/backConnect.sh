#!/bin/bash - 
#===============================================================================
#
#          FILE:  backConnect.sh
# 
#         USAGE:  ./backConnect.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#       COMPANY: Alibaba
#       CREATED: 2014年07月16日 11时39分09秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

ssh -fN -R 2222:localhost:22 $(whoami)@${localhostIP}
