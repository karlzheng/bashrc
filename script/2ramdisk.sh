#!/bin/bash

#mkimage -A arm -O linux -T ramdisk -C none -a 0x40080000 -n "ramdisk" -d $OUT_DIR/ramdisk-recovery.img $OUT_DIR/ramdisk-recovery-uboot.img

mkbootfs ./root | minigzip > ./ramdisk.img 
mkimage -A arm -O linux -T ramdisk -C none -a 0x40800000 -n "ramdisk" -d ramdisk.img ramdisk-uboot.img

#out/host/linux-x86/bin/mkbootfs out/target/product/mx/recovery/root | out/host/linux-x86/bin/minigzip > out/target/product/mx/ramdisk-recovery.img && mkimage -A arm -O linux -T ramdisk -C none -a 0x30800000 -n "ramdisk" -d out/target/product/mx/ramdisk-recovery.img out/target/product/mx/ramdisk-recovery-uboot.img && out/host/linux-x86/bin/mkbootimg --kernel out/target/product/mx/zImage --ramdisk out/target/product/mx/ramdisk-recovery-uboot.img -o out/target/product/mx/recovery-uboot.img
