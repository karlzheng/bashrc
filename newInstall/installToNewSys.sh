#!/bin/bash - 
#===============================================================================
#
#          FILE:  installToNewSys.sh
# 
#         USAGE:  ./installToNewSys.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#       COMPANY: Alibaba
#       CREATED: 2013年12月31日 17时12分08秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if [ "x${NEWIP} == "x" ];then
    echo "pls export NEWIP env var"
else
    rsync -avP ~/.ssh $(whoami)@${NEWIP}:~/ 
    rsync -avP ~/bashrc $(whoami)@${NEWIP}:~/ 
    rsync -avP ~/vimrc $(whoami)@${NEWIP}:~/ 
fi
