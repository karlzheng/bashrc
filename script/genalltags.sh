#!/bin/sh

: << EEOOFF
if [ -f cscope.out ];then
	/bin/rm cscope.out &
fi
if [ -f cscope.po.out ];then
	/bin/rm cscope.po.out &
fi
if [ -f cscope.in.out ];then
	/bin/rm cscope.in.out &
fi
EEOOFF

if [ -f newtags ];then rm newtags;fi
if [ -f newcscope.out ];then rm newcscope.out;fi
if [ -f newcscope.out.in ];then rm newcscope.out.in;fi
if [ -f newcscope.out.po ];then rm newcscope.out.po;fi
if [ -f modify.files ];then
	rm modify.files
fi

date
lookuptags.sh $1 

date
gencscopetags.sh 

date
gentags.sh $1 
date

