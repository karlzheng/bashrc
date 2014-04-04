#!/bin/bash

function extract_system()
{
	pwd
	if [ -f system.img ];then
		echo "extracting system.img"
		simg2img.py system.img 1>/dev/null
		if [ $? != 0 ];then
			echo "simg2img.py system.img error with code $?"
			exit 1
		else
			if [ -f simg2img.img ];then
				echo "sudo mount -o loop -t ext4 simg2img.img /tmp/simg2img"
				mkdir -p /tmp/simg2img
				sudo mount -o loop -t ext4 simg2img.img /tmp/simg2img
				if [ -d system ];then
					mv system system.old
				fi
				mkdir system
				sudo cp /tmp/simg2img/* system/ -a
				sudo chown -hR $(whoami).$(whoami) system
				sudo umount /tmp/simg2img
				/bin/rm simg2img.img
			fi
		fi
	else
		echo "Not found system.img"
	fi
}

function package_system()
{
	if [ -f system.img ];then
		if [ -f system.img.old ];then
			/bin/mv system.img.old system.img.old2
		fi
		/bin/mv system.img system.img.old
	fi
	##out/host/linux-x86/bin/make_ext4fs 
	make_ext4fs -s -l $((480*1024*1024)) -a system system.img system
}

function chooseOperation()
{
	echo "system.img:"
	echo "1. extract_system"
	echo "2. package_system"
	
	local choose=""
	read -p "Choose:" choose
	echo "Choose: ${choose}"
	if [ "${choose}" == "1" -o "xs{choose}" == "x" ];then
		echo "extract_system"
		extract_system
	else
		if [ "${choose}" == "2" ];then
			echo "package_system"
			package_system
		else
			echo -e "\npls choose inflate or create system.img!!\n"
		fi
	fi
}
chooseOperation
