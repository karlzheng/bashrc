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
	local d=~/tmp/sspatch
	[ ! -d ${d} ] || /bin/rm -rf ${d}
	mkdir -p ${d}
	local IFS=$'\n'
	echo "unzip $(ls -tr ~/sspatch/*.zip | tail -n 1) -d ${d}"
	unzip $(ls -tr ~/sspatch/*.zip | tail -n 1) -d ${d}
	echo ""
}

function gitamAfile()
{
	pwd
	echo "git am -s $@"
	git am -s $@
}

function makeAndroiAndKernelGitAM()
{
	local d=~/tmp/sspatch
	if [ -d bionic ] && [ -d packages ];then
		if [ -f ${d}/android/android_update.zip ];then
			unzip -DD -d $(pwd) ${d}/android/android_update.zip
		else
			ls ${d}/android/gtar*.tar 1>/dev/null 2>&1
			if [ $? == 0 ];then
				for f in $(ls ${d}/android/gtar*.tar);do
					echo "tar xmf ${f}"
					tar xmf ${f}
				done
			else
				for f in $(ls ${d}/android/*.patch |sort);do
					gitamAfile ${f}
				done
			fi
		fi
	else
		if [ -d */bionic ] && [ -d */packages ];then
			local androidDir=$(dirname $(ls */bionic -d))
			cd ${androidDir}
			if [ -f ${d}/android/android_update.zip ];then
				unzip -DD -d $(pwd) ${d}/android/android_update.zip
			else
				for f in $(ls ${d}/android/*.patch |sort);do
					gitamAfile ${f}
				done
			fi
			cd -
		fi
	fi

	if [ -d android ] && [ -d drivers ];then
		for f in $(ls ${d}/kernel/*.patch |sort);do
			gitamAfile ${f}
		done
	else
		if [ -d kernel/android ] && [ -d kernel/drivers ];then
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

	if [ -d nand_spl ] && [ -d onenand_ipl ];then
		for f in $(/bin/ls ${d}/uboot/*.patch |sort);do
			gitamAfile ${f}
		done
	else
		if [ -d uboot/nand_spl ] && [ -d uboot/onenand_ipl ];then
			cd uboot
			for f in $(ls ${d}/uboot/*.patch |sort);do
				gitamAfile ${f}
			done
			cd -
		else
			if [ -d *uboot*/onenand_ipl ];then
				local ubootDir=$(dirname $(ls *uboot*/onenand_ipl -d))
				cd ${ubootDir}
				for f in $(ls ${d}/uboot/*.patch |sort);do
					gitamAfile ${f}
				done
				cd -
			fi
		fi
	fi
}

unPatchZip
makeAndroiAndKernelGitAM
