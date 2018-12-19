#!/bin/bash

function readEnsureKey()
{
	read -p "are you sure want do: $@" c
	if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
		return 0
	else
		return 1
	fi
}
