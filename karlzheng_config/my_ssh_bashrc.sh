#!/bin/bash

function s()
{
    netstat -nl | grep -q "tcp.*2222"
    if [ $? != 0 ];then
	ssh -fN -L 2222:localhost:2222 sztv@10.232.128.24
	sshfs -p 2222 -o uid=1000,gid=1000 changliang@localhost:/sztv/changliang ~/dev2
    fi
    ssh changliang@localhost -p 2222 -X
}

function stv()
{
    ssh sztv
}

function ssshfs()
{
    local SERVER_USER="sztv"
    local SERVER_IP="10.232.128.24"
    #local localip=$(ifconfig | sed -n -e '/Bcast/{s/.*addr:*\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\).*/\1/p}')
    local localip=$(ifconfig | grep 'Bcast' | awk -F ":| +" '{ print $4 }')

    if [ ${#localip} != 0 ];then
	ping -c 1 -w 1 ${SERVER_IP}
	if [ $? == 0 ];then
	    echo "sshfs -o nonempty -o reconnect -o follow_symlinks -o \
	    allow_other -o uid=1000,gid=1000 \
	    ${SERVER_USER}@$SERVER_IP:/home/${SERVER_USER} ~/dev1"
	    sshfs -o nonempty -o reconnect -o follow_symlinks -o allow_other \
	    -o uid=1000,gid=1000 \
	    ${SERVER_USER}@$SERVER_IP:/home/${SERVER_USER} ~/dev1
	
	    ssh -fNg -D 7001 sztv@10.232.128.24
	else
	    echo "ping ${SERVER_IP} is not okay."
	fi
    fi
}

function ssshfs_unmount()
{
    sudo umount ~/dev1
}

function ssshfs_auto_mount()
{
    local is_dev_dir_mounted=$(mount | grep "${HOME}/dev1" | wc -l)
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
