#!/bin/sh

if [ $# -lt 2 ];then
  [ -f /tmp/mytesttar.tar ] && rm /tmp/mytesttar.tar
  target_file="/tmp/mytesttar.tar"
else
  target_file="$2"
fi

[ -f "$target_file" ] && rm "$target_file"

while read line
  do
    #echo $line
   if [ ! -d $line ]; then
      tar rvf "$target_file" $line
   fi
  done < $1

#echo "" "tar file is /tmp/mytesttar.tar"
echo "target_file is " "$target_file"
