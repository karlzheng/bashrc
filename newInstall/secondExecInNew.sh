#!/bin/bash - 
#===============================================================================
#
#          FILE:  secondExecInNew.sh
# 
#         USAGE:  ./secondExecInNew.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#       COMPANY: Alibaba
#       CREATED: 2013年12月31日 17时17分20秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

echo "user_allow_other" > /tmp/tmp.txt
echo "allow_other" >> /tmp/tmp.txt
sudo bash -c "cat /tmp/tmp.txt >> /etc/fuse.conf 
sudo chmod a+r /etc/fuse.conf 
