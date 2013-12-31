#!/bin/bash - 
#===============================================================================
#
#          FILE:  firstExecInNew.sh
# 
#         USAGE:  ./firstExecInNew.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#       COMPANY: Alibaba
#       CREATED: 2013年12月31日 17时15分06秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

echo "$(whoami) ALL=(ALL:ALL) NOPASSWD:ALL" > /tmp/tmp.txt
sudo bash -c "cat /tmp/tmp.txt >> /etc/sudoers"

sudo apt-get install ssh
