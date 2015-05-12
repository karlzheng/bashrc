#!/bin/bash -
#===============================================================================
#
#          FILE:  ssh_sock_proxy.sh
#
#         USAGE:  ./ssh_sock_proxy.sh
#
#   DESCRIPTION:
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#       COMPANY: Meizu
#       CREATED: 2015年02月12日 21时52分29秒 CST
#      REVISION:  ---
#===============================================================================

#http://straightedgelinux.com/blog/howto/socks.html
ssh -Nn -D 1080 klaatu@home.linuxserver.com
