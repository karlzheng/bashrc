#!/bin/bash 

if [ -f u-boot.bin ];then
	fastboot flash bootloader u-boot.bin
fi
if [ -f zImage ];then
	fastboot flash kernel zImage
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
