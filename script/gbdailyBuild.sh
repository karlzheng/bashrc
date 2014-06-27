#!/bin/bash -

function runBuild()
{
	date
	export PS1="PS1"
	#source /etc/profile
	#source /etc/bash.bashrc
	source ${HOME}/.bashrc
	#echo ${PATH}
	export CROSS_COMPILE=arm-linux-gnueabi-
	export PATH=${HOME}/bk/sw/jdk1.6.0_45/bin/:${PATH}
	export PATH=${HOME}/software/linaro-arm-linux-gnueabi-4.6.3/bin/:${PATH}
	export ANDROID_JAVA_HOME=${HOME}/bk/sw/jdk1.6.0_45/
	export JAVA_HOME=${HOME}/bk/sw/jdk1.6.0_45/
	echo ${PATH}
	echo "which javac"
	which javac
	#local imgDir=/tmp/mdir/appDailyBuild/ali/$(date +%Y%m%d)
	local imgDir=/4t/samba/share/dailyBuild/5430firmware/ali/$(date +%Y%m%d)
	pushd /4t/karlzheng/clean/repo/dev/
	${HOME}/bashrc/script/ali_repo sync -j12
	#pushd kernel
	#source build_kernel.sh
	#popd
	if [ -d out ];then
		/bin/rm out -rf
	fi
	./build.sh magiccube all
	#(source build/envsetup.sh && lunch full_magiccube-eng && make -j24)
	#(source build/envsetup.sh;lunch full_magiccube-eng;make -j24)
	#ANDROID_JAVA_HOME=${HOME}/bk/sw/jdk1.6.0_45/ && lunch full_magiccube-eng
	#export TARGET_NO_KERNEL=true
	#lunch 
	#make update-api -j24 PRODUCT-full_magiccube-eng
	#source build/envsetup.sh
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
