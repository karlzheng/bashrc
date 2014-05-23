#!/bin/bash 

echo "Are you sure want to erase userdata ?"
read -p "y|n" c
if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
	fastboot erase userdata
	fastboot erase cache
else
	echo "Cancel erase userdata! Exit!"
	exit 1
fi

if [ -f u-boot.bin ];then
	fastboot flash bootloader u-boot.bin
fi
if [ -f zImage ];then
	fastboot flash kernel zImage
else
	if [ -f zImage-dtb ];then
		fastboot flash kernel zImage-dtb
	fi
fi
if [ -f ramdisk-uboot.img ];then
	fastboot flash ramdisk ramdisk-uboot.img
fi
if [ -f ramdisk.img.ub ];then
	fastboot flash ramdisk ramdisk.img.ub 
fi
if [ -f system.img ];then
	fastboot flash system system.img
fi
fastboot reboot
