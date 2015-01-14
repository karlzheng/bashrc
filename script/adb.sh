#!/bin/bash
#===============================================================================
#
#          FILE:  adb.sh
#
#         USAGE:  ./adb.sh
#
#   DESCRIPTION:
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#       COMPANY: Alibaba
#       CREATED: 2014年04月10日 17时24分54秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

function adblistpackages()
{
	adb shell pm list packages -f "$@"
}
