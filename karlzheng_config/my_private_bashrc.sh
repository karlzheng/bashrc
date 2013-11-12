#!/bin/bash

#my_bash_login_auto_exec_func
alias rsync241="rsync cefanty@172.16.10.241:/home/cefanty/svn/kernel/linux-2.6.35-meizu/arch/arm/boot/zImage ~/img/241/zImage"
alias smbmount99_common='sudo smbmount //172.16.10.99/开发部公共文件夹/ /media/mzf_common/ -o iocharset=utf8,username=zhengkl,password=zheng09,dir_mode=0777,file_mode=0777'
alias smbmount99='sudo umount /media/mzf/;sudo smbmount //172.16.10.99/开发部/ /media/mzf/ -o iocharset=utf8,username=zhengkl,password=zheng09,dir_mode=0777,file_mode=0777'

alias s='ssh zkl@192.168.2.133'

function ssshfs()
{
    local SERVER_USER="sztv"
    local SERVER_IP="10.232.128.24"
    #local localip=$(ifconfig | sed -n -e '/Bcast/{s/.*addr:*\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\).*/\1/p}')
    local localip=$(ifconfig | grep 'Bcast' | awk -F ":| +" '{ print $4 }')

    if [ ${#localip} != 0 ];then
	ping -c 1 -w 1 ${SERVER_IP}
	if [ $? == 0 ];then
	    echo "sshfs -o nonempty -o reconnect -o follow_symlinks -o allow_other -o uid=1000,gid=1000 ${SERVER_USER}@$SERVER_IP:/home/${SERVER_USER} ~/dev"
	    sshfs -o nonempty -o reconnect -o follow_symlinks -o allow_other -o uid=1000,gid=1000 ${SERVER_USER}@$SERVER_IP:/home/${SERVER_USER} ~/dev
	else
	    echo "ping ${SERVER_IP} is not okay."
	fi
    fi
}


function ssshfs_unmount()
{
    sudo umount ~/dev
}

function ssshfs_auto_mount()
{
    local is_dev_dir_mounted=$(mount | grep "${HOME}/dev" | wc -l)
    if [ $is_dev_dir_mounted == 0 ];then
	ssshfs
    fi
}

function mtoshiba()
{
    if [ $# == 1 ];then
	sudo mount -t ntfs $1 ~/tmp/toshiba
    fi
}

function m106_hardware()
{
    local is_106_mounted=$(mount | grep "192.168.1.106/hardware" | wc -l)
    if [ "$is_106_mounted" == 0 ];then
	sudo mount -t cifs -o iocharset=utf8,pass="" //192.168.1.106/hardware/ /home/karlzheng/de/106
    fi
}

ssshfs_auto_mount

