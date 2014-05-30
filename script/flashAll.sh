#!/bin/bash 

function fastbootFlash()
{
	echo "fastboot flash $@"
	fastboot flash $@
}

function flashImage()
{
	if [ -f primary_gpt_*_32G ];then
		fastbootFlash  primary_gpt primary_gpt_*_32G
	fi
	if [ -f second_gpt_*_32G ];then
		fastbootFlash  second_gpt second_gpt_*_32G
	fi
	if [ -f u-boot-E5430-*.bin ];then
		fastbootFlash bootloader u-boot-E5430-*.bin
	else
		if [ -f u-boot.bin ];then
			fastbootFlash bootloader u-boot.bin
		fi
	fi
	if [ -f logo.bin ];then
		fastbootFlash bootlogo logo.bin 
	fi
	if [ -f zImage-dtb ];then
		fastbootFlash kernel zImage-dtb
	else
		if [ -f zImage ];then
			fastbootFlash kernel zImage
		fi
	fi
	if [ -f ramdisk-uboot.img ];then
		fastbootFlash ramdisk ramdisk-uboot.img
	else
		if [ -f ramdisk.img ];then
			fastbootFlash ramdisk ramdisk.img
		fi
	fi
	if [ -f ramdisk.img.ub ];then
		fastbootFlash ramdisk ramdisk.img.ub
	fi
	if [ -f system.img ];then
		fastbootFlash system system.img
	fi
}

flashImage
fastboot reboot
