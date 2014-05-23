#!/bin/bash
#===============================================================================
#
#          FILE:  sspatch.sh
# 
#         USAGE:  ./sspatch.sh
# 
#   DESCRIPTION:  use git am to apply Samsung patch zip file
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#       COMPANY: Alibaba
#       CREATED: 2014年 05月 23日 星期五 18:19:15 CST
#      REVISION:  ---
#===============================================================================

function unPatchZip()
{
	local d=/tmp/ssPatch
	[ ! -d ${d} ] || /bin/rm -rf ${d}
	mkdir -p ${d}
	local IFS=$'\n'
	echo "unzip $(ls -tr ~/ssPatch/*.zip | tail -n 1) -d ${d}"
	unzip $(ls -tr ~/ssPatch/*.zip | tail -n 1) -d ${d}
	echo ""
}

function gitamAfile()
{
	pwd
	echo "git am $@"
	git am $@
}

function makeAndroiAndKernelGitAM()
{
	local d=/tmp/ssPatch
	if [ -d bionic ] && [ -d packages ];then
		for f in $(ls ${d}/android/*.patch |sort);do
			gitamAfile ${f}
		done
	else
		if [ -d */bionic ] && \
			[ -d */packages ];then
			local androidDir=$(dirname $(ls */bionic -d))
			cd ${androidDir}
			for f in $(ls ${d}/android/*.patch |sort);do
				gitamAfile ${f}
			done
			cd -
		fi
	fi
	if [ -d arch ] && [ -d drivers ];then
		for f in $(ls ${d}/kernel/*.patch |sort);do
			gitamAfile ${f}
		done
	else
		if [ -d kernel/arch ] && [ -d kernel/drivers ];then
			cd kernel
			for f in $(ls ${d}/kernel/*.patch |sort);do
				gitamAfile ${f}
			done
			cd -
		else
			if [ -d *kern*/Documentation ];then
				local kernelDir=$(dirname $(ls *kern*/Documentation -d))
				cd ${kernelDir}
				for f in $(ls ${d}/kernel/*.patch |sort);do
					gitamAfile ${f}
				done
				cd -
			fi
		fi
	fi
}

unPatchZip 
makeAndroiAndKernelGitAM
