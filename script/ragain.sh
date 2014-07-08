#!/bin/bash

echo "======start repo sync======"
echo repo sync -j$(/bin/grep processor /proc/cpuinfo | /usr/bin/awk '{field=$NF};END{print(field+1)}')
repo sync -j$(/bin/grep processor /proc/cpuinfo | /usr/bin/awk '{field=$NF};END{print(field+1)}')
while [ $? = 1 ]; do
        echo "======sync failed, re-sync again======"
        sleep 3
        #repo sync
	echo repo sync -j$(/bin/grep processor /proc/cpuinfo | /usr/bin/awk '{field=$NF};END{print(field+1)}')
	#repo sync -j$(/bin/grep processor /proc/cpuinfo | /usr/bin/awk '{field=$NF};END{print(field+1)*2}')
	repo sync -j$(/bin/grep processor /proc/cpuinfo | /usr/bin/awk '{field=$NF};END{print(field+1)}')
done

