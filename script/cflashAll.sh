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

function flashImage()
{
	if [ -f u-boot-E5430-Espresso5430-*.bin ];then
		fastboot flash bootloader u-boot-E5430-Espresso5430-*.bin
	else
		if [ -f u-boot.bin ];then
			fastboot flash bootloader u-boot.bin
		fi
	fi
	if [ -f primary_gpt_Espresso5430_32G ];then
		fastboot flash  primary_gpt primary_gpt_Espresso5430_32G
	fi
	if [ -f second_gpt_Espresso5430_32G ];then
		fastboot flash  second_gpt second_gpt_Espresso5430_32G
	fi
	if [ -f zImage-dtb ];then
		fastboot flash kernel zImage-dtb
	else
		if [ -f zImage ];then
			fastboot flash kernel zImage
		fi
	fi
	if [ -f ramdisk-uboot.img ];then
		fastboot flash ramdisk ramdisk-uboot.img
	else
		if [ -f ramdisk.img ];then
			fastboot flash ramdisk ramdisk.img
		fi
	fi
	if [ -f ramdisk.img.ub ];then
		fastboot flash ramdisk ramdisk.img.ub
	fi
	if [ -f system.img ];then
		fastboot flash system system.img
	fi
}

flashImage
fastboot reboot
