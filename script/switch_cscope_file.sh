#!/bin/bash -

files=(tags cscope.files cscope.in.out cscope.out cscope.po.out GPATH GTAGS GRTAGS GSYMS filenametags fullfilenametags)

if [ -f tags ];then
    for f in ${files[@]};do
	if [ -f $f ];then
	    echo mv $f my$f
	    mv $f my$f
	fi
    done
else
    if [ -f mytags ];then
	for f in ${files[@]};do
	    if [ -f my$f ];then
		echo mv my$f $f
		mv my$f $f
	fi
	done
    fi
fi
