#!/bin/bash

#set -x
#time sudo dd if=/dev/zero of=svn.img bs=1M count=35000
        
function is_loopi_mounted()
{
    mounted_dev=$(sudo losetup -a |awk -F: '{print $1}')
    dev_name=""
    for i in $mounted_dev;do
	if [ "/dev/loop$1" == $i ];then
	    is_mounted=1
	else
	    dev_name="/dev/loop"$1
	fi
    done
    #return $is_mounted
}

function format_crypt_disk()
{
	for img in $(dir *.img);
	do
		imgdir=${img%%.*}
		cnt=0

		while [ $cnt -lt 8 ]
		do
			is_mounted=0
			is_loopi_mounted $cnt
			if [ $is_mounted == 0 ];then
				break;
			fi
			((cnt++))
		done

		if [ $cnt -lt 8 ];then
			echo loop_dev="/dev/loop$cnt"
			loop_dev="/dev/loop$cnt"
			echo "sudo losetup $loop_dev $img"
			sudo losetup $loop_dev $img
			sudo cryptsetup create $imgdir $loop_dev
			sudo mkfs.ext4 /dev/mapper/$imgdir
			sleep 2
			if [ ! -d $imgdir ];then
				mkdir $imgdir
			fi
			sudo mount /dev/mapper/$imgdir $imgdir
			sudo chown $(whoami).$(whoami) $imgdir -R
			sleep 2
			sudo umount $imgdir
			sudo cryptsetup remove /dev/mapper/$imgdir
			if [ "x$dev_name" != "x" ];then
				sudo losetup -d $dev_name
			fi
			ls -d $imgdir/* 1>/dev/null 2>&1
			if [ $? != 0 ];then
				rmdir $imgdir
			fi
		else
			echo "Has no loop dev to mount!!"
			exit 1
		fi
	done
}

format_crypt_disk

