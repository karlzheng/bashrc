#!/bin/sh

while true;do
	if [ -f ~/241/say_finish ];then
		rm ~/241/say_finish
		break;
	fi
	sleep 1
done
