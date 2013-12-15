#!/bin/bash 

for img in $(dir *.img);
do
    imgdir=${img%%.*}
    mount |grep "$imgdir" | grep "$(basename $(pwd))"
    if [ $? == 0 ];then 
        echo "unmount:"$imgdir
        sudo umount $imgdir
    fi
    if [ -e "/dev/mapper/$imgdir" ];then
        echo "cryptsetup remove:/dev/mapper/"$imgdir
        sudo cryptsetup remove /dev/mapper/$imgdir
    fi
    img_mounted_loop_point=$(sudo losetup -a |grep $img|awk -F: '{print $1}')
    if [ -n "$img_mounted_loop_point" ];then
        echo "rm loop point:"$img_mounted_loop_point
        sudo losetup -d $img_mounted_loop_point
    fi
done

