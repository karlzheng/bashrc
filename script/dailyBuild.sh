#!/bin/bash - 

function runBuild()
{
	local orgVerHash="5ee45d2e28dc216e8cedcd2decd156ef6d3ace50"
	#git clone gitolite@10.39.70.10:gameBox/samsung/5422-android-release
	if [ -d ${HOME}/dailyBuild ];then
		local prePath=${HOME}/dailyBuild
	else
		local prePath="/1t/home/share/arndale_img/dailyBuild_Android4.4"
	fi
	local oldBranch=$(git branch | grep '^*' |awk '{print $2}')
	if [ "x${oldBranch}" != "xmaster" ];then
		git checkout master
		git branch -D ${oldBranch}
	fi
	local logList=$(git log |grep "^commit"|awk '{print $2}')
	for ll in ${logList[@]};do
		if [ -d out ];then
			/bin/rm out -rf
		fi
		if [ ! -d ${prePath}/${ll} ];then
			git checkout ${ll} -b ${ll}
			git reset --hard
			git clean -df
			if [ "x${ll}" == "x${orgVerHash}" ];then
				echo ${ll}
				source build/envsetup.sh
				lunch full_xyref5422-eng
				make -j24
				cd out/target/product/xyref5422
				mkimage -A arm -O linux -T ramdisk -C none -a 0x40800000 -n "ramdisk" -d ramdisk.img ramdisk-uboot.img
				mkdir ${prePath}/${ll}
				/bin/cp ramdisk-uboot.img ${prePath}/${ll}/
				/bin/cp system.img ${prePath}/${ll}/
				cd -
			else
				source build/envsetup.sh
				lunch full_magiccube-eng
				make -j24
				cd out/target/product/magiccube
				mkimage -A arm -O linux -T ramdisk -C none -a 0x40800000 -n "ramdisk" -d ramdisk.img ramdisk-uboot.img
				mkdir ${prePath}/${ll}
				/bin/cp ramdisk-uboot.img ${prePath}/${ll}/
				/bin/cp system.img ${prePath}/${ll}/
				cd -
			fi
			git checkout master
			git branch -D ${ll}
		fi
	done
}

runBuild
