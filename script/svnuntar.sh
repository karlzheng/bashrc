#!/bin/bash -
#===============================================================================
#
#          FILE:  svnuntar.sh
#
#         USAGE:  ./svnuntar.sh
#
#   DESCRIPTION:
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (http://blog.csdn.net/zhengkarl), ZhengKarl@gmail.com
#       COMPANY: Alibaba
#       CREATED: 2010年10月07日 16时08分13秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

svn_tar_file=""
for f in $(ls svn_diff_[0-9]*_[0-9]*.tar);
do
  if [[ "x$f" > "x$svn_tar_file" ]];then
    svn_tar_file="$f"
  fi
done

if [[ "x$svn_tar_file" != "x" ]];then
  echo "Would you like to un tar $svn_tar_file?"
  echo "input y to confirm, other key to cancle:"
  read yes
  if [ x"$yes" = "xy" -o x"$yes" = "xY" ];then
    tar xvf "$svn_tar_file"
  fi
fi

