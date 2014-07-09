#!/bin/bash

#time sudo dd if=/dev/zero of=svn.img bs=1M count=35000

function is_loopi_mounted()
{
    mounted_dev=$(sudo losetup -a |awk -F: '{print $1}')
    local dev_name="/dev/loop"$1
    for i in $mounted_dev;do
        if [ $dev_name = $i ];then
            is_mounted=1
        fi
    done
    #return $is_mounted
}

function mountAllImage()
{
	for img in $(dir *.img);do
		imgdir=${img%%.*}
		cnt=0

		while [ $cnt -lt 8 ];do
			is_mounted=0
			is_loopi_mounted $cnt
			if [ $is_mounted == 0 ];then
				break;
			fi
			((cnt++))
		done

		if [ $cnt -lt 8 ];then
			mount_dev="/dev/loop$cnt"
			sudo losetup $mount_dev $img
			echo "cryptsetup loop point for:$img, in:$mount_dev"
			if [ -f ${HOME}/person_tools/cryptsetup.txt ];then
				let local phase=$(cat ${HOME}/person_tools/cryptsetup.txt | \
					tr -d "\r"|tr -d "\n")
				echo "$phase" | sudo cryptsetup create $imgdir $mount_dev
			else
				sudo cryptsetup create $imgdir $mount_dev
			fi
			if [ $? != 0 ];then
				echo "sudo losetup -d $mount_dev"
				sudo losetup -d $mount_dev
				echo "exit 1"
				exit 1
			else
				echo "cryptsetup successful!"
			fi
			if [ ! -d $imgdir ];then
				mkdir $imgdir
			fi
			local gid=$(id -g $(whoami))
			local uid=$(id -u $(whoami))
			#echo "sudo mount -o uid=${uid},gid=${gid} /dev/mapper/$imgdir $imgdir"
			#sudo mount -o uid=${uid},gid=${gid} /dev/mapper/$imgdir $imgdir
			echo "sudo mount /dev/mapper/$imgdir $imgdir"
			sudo mount /dev/mapper/$imgdir $imgdir
			if [ $? != 0 ];then
				echo "sudo losetup -d $mount_dev"
				sudo losetup -d $mount_dev
			fi
		else
			echo "Has no loop dev to mount!!"
			exit 1
		fi
	done
}

mountAllImage

#sudo losetup /dev/loop6 svn.img
#sudo cryptsetup create svndisk /dev/loop6

#sudo mkfs.ext4 /dev/mapper/svndisk
#sudo mkdir svndisk
#sudo mount /dev/mapper/svndisk svndisk
#sudo chown karlzheng.karlzheng svndisk/ -R

#sudo umount svndisk
#sudo cryptsetup remove /dev/mapper/svndisk
#sudo losetup -d /dev/loop6

#sudo cryptsetup remove /dev/mapper/svndisk
#sudo losetup -d /dev/loop6
