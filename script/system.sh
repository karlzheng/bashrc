#!/bin/bash

#out/host/linux-x86/bin/make_ext4fs 

if [ -f system.img ];then
    if [ -f old.system.img ];then
	mv -i system.img old.system.img
    else
	mv system.img old.system.img
    fi
fi
#make_ext4fs -s -l 314572800 -a system system.img system
make_ext4fs -s -l 414572800 -a system system.img system

