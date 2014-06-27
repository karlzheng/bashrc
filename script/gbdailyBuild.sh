#!/bin/bash -

function runBuild()
{
	date
	if [ -d /4t/samba/share/dailyBuild/5430firmware/ali/ ];then
		local imgDir=/4t/samba/share/dailyBuild/5430firmware/ali/$(date +%Y%m%d)
		local srcDir=/4t/karlzheng/clean/repo/dev/
	else
		local imgDir=/home/karlzheng/share/appDailyBuild/ali/$(date +%Y%m%d)
		local srcDir=/home/karlzheng/src/dev5430/
	fi

	if [ -f ${imgDir}/system.img ];then
		echo ${BASH_SOURCE[0]} $LINENO
		echo "system.img has been put at ${imgDir}. Exit."
		return;
	fi
	
	export PS1="PS1"
	source ${HOME}/.bashrc
	export CROSS_COMPILE=arm-linux-gnueabi-
	export PATH=${HOME}/bk/sw/jdk1.6.0_45/bin/:${PATH}
	export PATH=${HOME}/software/linaro-arm-linux-gnueabi-4.6.3/bin/:${PATH}
	export ANDROID_JAVA_HOME=${HOME}/bk/sw/jdk1.6.0_45/
	export JAVA_HOME=${HOME}/bk/sw/jdk1.6.0_45/

	#local imgDir=/tmp/mdir/appDailyBuild/ali/$(date +%Y%m%d)
	pushd ${srcDir}
	${HOME}/bashrc/script/ali_repo sync -j12
	if [ -d out ];then
		/bin/rm out -rf
	fi
	./build.sh magiccube all
	#(source build/envsetup.sh && lunch full_magiccube-eng && make -j24)
	#make update-api -j24 PRODUCT-full_magiccube-eng
	#make TARGET_NO_KERNEL=true update-api -j24 PRODUCT-full_magiccube-eng
	mkdir -p ${imgDir}
	cd out/target/product/magiccube
	/bin/cp kernel ${imgDir}/
	/bin/cp ramdisk-uboot.img ${imgDir}/
	/bin/cp system.img ${imgDir}/
	popd
	date
}

#runBuild 2>&1 | tee -a /tmp/build.log
runBuild 2>&1 | tee /tmp/build.log
