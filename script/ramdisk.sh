#!/bin/bash


function r()
{
	echo "Modify the ramdisk.img"

	echo "1.Inflate the image"
	echo "2.Create the image"

	read -p "Choose:" CHOOSE

	fn=ramdisk-uboot.img
	if [ ! -f ${fn} ];then
		if [ -f ramdisk.img.ub ];then
			fn=ramdisk.img.ub
		fi
	fi

	if [ "${CHOOSE}" == "1" ];then
		echo "inflate()"
		if [ -d root ];then 
			echo "exist root dir!!"
			echo "mv root root_old"
			if [ -d root_old ];then 
				/bin/rm -rf root_old
			fi
			/bin/mv root root_old
			#exit 1;
		fi
		mkdir root &&  cd root
		if [ -f ../ramdisk.img.gz ];then
			mv ../ramdisk.img.gz ../ramdisk.img.gz.old
		fi
		dd if=../${fn} of=../ramdisk.img.gz bs=1 skip=64
		gzip -dc ../ramdisk.img.gz | cpio -idm
		rm ../ramdisk.img.gz
		#chmod 777 -R ./
	elif [ "2" = "${CHOOSE}" ];then
		echo "create()"
		if [ ! -d root ];then 
			echo "no a dir name root in sub dir"
			exit 1
		fi
		cd root
		find . | cpio -H newc -o | gzip -9 > ../ramdisk_new.img
		cd -
		if [ -f ${fn} ];then
			mv ${fn} ${fn}.old
		fi
		mkimage -A arm -O linux -T ramdisk -C none -a 0x41000000 -n "ramdisk" -d ramdisk_new.img ${fn}
		rm ramdisk_new.img
	else
		echo -e "\npls choose inflate or create ramdisk!!\n"
	fi
cat << EEOOFF > /dev/null
	echo "1. mkimage for meizum8(s3c6410)"
	echo "2. mkimage for meizu3g(s5pc100)"
	echo "3. mkimage for meizum9(S5PC110)"
	echo "4. mkimage for meizumx(S5PC210)"
	echo "5. mkimage for meizumxse(4412)"
	read -p "Choose:" CHOOSE
	if [ "${CHOOSE}" == "1" ];then
		#ramdisk-uboot-s3c6410.img
		mkimage -A arm -O linux -T ramdisk -C none -a 0x50800000 -n "ramdisk" -d ramdisk_new.img ramdisk-uboot-s3c6410.img
	elif [ "2" = ${CHOOSE} ];then
		rm -f ramdisk-uboot-s5pc100.img
		mkimage -A arm -O linux -T ramdisk -C none -a 0x20800000 -n "ramdisk" -d ramdisk_new.img ramdisk-uboot-s5pc100.img
	elif [ "3" = ${CHOOSE} ];then
		rm -f ramdisk-uboot-s5pc110.img
		mkimage -A arm -O linux -T ramdisk -C none -a 0x30800000 -n "ramdisk" -d ramdisk_new.img ramdisk-uboot-s5pc110.img
	elif [ "4" = ${CHOOSE} ];then
		rm -f ramdisk-uboot-s5pc210.img
		mkimage -A arm -O linux -T ramdisk -C none -a 0x40800000 -n "ramdisk" -d ramdisk_new.img ramdisk-uboot-s5pc210.img
	elif [ "5" = ${CHOOSE} ];then
		rm -f ramdisk-uboot-4412.img
		mkimage -A arm -O linux -T ramdisk -C none -a 0x41000000 -n "ramdisk" -d ramdisk_new.img ramdisk-uboot-4412.img
	fi
EEOOFF
}

r "$@"

