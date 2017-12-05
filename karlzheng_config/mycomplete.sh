#!/bin/bash
#===============================================================================
#
#		   FILE: mycomplete.sh
#
#		  USAGE:
#
#	DESCRIPTION:
#
#		OPTIONS:  ---
#  REQUIREMENTS:  ---
#		   BUGS:  ---
#		  NOTES:  ---
#		 AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#		   BLOG: http://blog.csdn.net/zhengkarl
#		  WEIBO: http://weibo.com/zhengkarl
#		COMPANY: Alibaba
#		CREATED: 2012年05月21日 19时12分43秒 CST
#	   REVISION:  ---
#===============================================================================

function _bypy_completion()
{
	local cur
	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}
	prev=${COMP_WORDS[COMP_CWORD-1]}
	if [ $COMP_CWORD -eq 1 ];then
		COMPREPLY=($( compgen -W 'upload' -- $cur ))
	else
		if [ $COMP_CWORD -eq 2 ];then
			COMPREPLY=($(compgen -f -- "${COMP_WORDS[${COMP_CWORD}]}"))
		fi
	fi

	return 0
}

function _ct_complete()
{
	local cur=${COMP_WORDS[COMP_CWORD]};
	local com=${COMP_WORDS[COMP_CWORD-1]};
	local j k
	local k
	COMPREPLY=()
	local dir_list=$(compgen -d -- $cur)
	k="${#COMPREPLY[@]}"
	for j in $dir_list;do
		COMPREPLY[k++]=$j
	done
	local dir_list=$(compgen -f -- $cur)
	k="${#COMPREPLY[@]}"
	for j in $dir_list;
	do
		COMPREPLY[k++]=$j
	done
	return 0
}

function _dnw_complete()
{
	local cur=${COMP_WORDS[COMP_CWORD]};
	local com=${COMP_WORDS[COMP_CWORD-1]};
	local j k
	if [[ $COMP_CWORD==1 && -z "$cur" ]];then
		local my_complete_word=(
		"11111arch/arm/boot/zImage"
		"11111/media/x/compiled/v4.0-dev/arch/arm/boot/zImage"
		)
		COMPREPLY=($(compgen -W '${my_complete_word[@]}' -- $cur))
		local dir_list=$(compgen -d)
		k="${#COMPREPLY[@]}"
		for j in $dir_list;do
			COMPREPLY[k++]=$j
		done
	else   #dir complete
		local k
		COMPREPLY=()
		local dir_list=$(compgen -d -- $cur)
		k="${#COMPREPLY[@]}"
		for j in $dir_list;do
			COMPREPLY[k++]=$j
		done
		local dir_list=$(compgen -f -- $cur)
		k="${#COMPREPLY[@]}"
		for j in $dir_list;
		do
			COMPREPLY[k++]=$j
		done
	fi
	return 0
}

function _fastboot_completion()
{
		local cur
		COMPREPLY=()
		cur=${COMP_WORDS[COMP_CWORD]}
		prev=${COMP_WORDS[COMP_CWORD-1]}
		if [ $COMP_CWORD -eq 1 ];then
				COMPREPLY=($(compgen -W ' flash reboot erase ' -- $cur ))
		else
				if [ $COMP_CWORD -eq 2 ];then
					case "$prev" in
						"flash")
							COMPREPLY=($( compgen -W 'kernel boot bootloader \
								ramdisk system userdata' -- $cur ))
							;;
						"erase")
							COMPREPLY=($(compgen -W 'userdata cache' -- $cur ))
							;;
					esac
				else
						if [ $COMP_CWORD -eq 3 ];then
								case "$prev" in
										"system")
											if [ -f system.img ];then
												COMPREPLY=($( compgen -W 'system.img' -- $cur ))
											else
												COMPREPLY=($(compgen -f -- "${COMP_WORDS[${COMP_CWORD}]}"))
											fi
												;;
										"userdata")
												COMPREPLY=($( compgen -W 'userdata.img' -- $cur ))
												;;
										"ramdisk")
											if [ -f ramdisk-uboot.img ];then
												COMPREPLY=($( compgen -W 'ramdisk-uboot.img' -- $cur ))
											else
												COMPREPLY=($(compgen -f -- "${COMP_WORDS[${COMP_CWORD}]}"))
											fi
												;;
										"boot")
											if [ -f boot.img ];then
												COMPREPLY=($( compgen -W ' boot.img' -- $cur ))
											else
												COMPREPLY=($(compgen -f -- "${COMP_WORDS[${COMP_CWORD}]}"))
											fi
												;;
										"bootloader")
											if [ -f uboot_fuse.bin ];then
												COMPREPLY=($( compgen -W 'uboot_fuse.bin' -- $cur ))
											else
												COMPREPLY=($(compgen -f -- "${COMP_WORDS[${COMP_CWORD}]}"))
											fi
												;;
										"kernel")
											COMPREPLY=($(compgen -f -- "${COMP_WORDS[${COMP_CWORD}]}"))
											local specCompreply=(zImage zImage-dtb arch/arm/boot/zImage arch/arm/boot/zImage-dtb)
											for f in ${specCompreply[@]};
											do
												if [ -f ${f} ];then
													COMPREPLY=(${f} ${COMPREPLY[*]})
												fi
											done
												;;
										*)
												COMPREPLY=($(compgen -f -- "${COMP_WORDS[${COMP_CWORD}]}"))
												;;
								esac
						fi
				fi
		fi
  return 0
}

function _ksvn_complete()
{
		local my_complete_word=(
				'svn://172.16.9.63/svn_src'
				'https://172.16.1.21/svn/IceCreamSandwich'
		)
		COMPREPLY=($(compgen -W '${my_complete_word[@]}' -- $cur))
		return 0
}

function _make_complete()
{
	local cur
	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}
	prev=${COMP_WORDS[COMP_CWORD-1]}
	if [ $COMP_CWORD -eq 1 ];then
		COMPREPLY=($(compgen -W ' xconfig clean distclean ' -- $cur ))
	else
		COMPREPLY=($(compgen -f -- "${COMP_WORDS[${COMP_CWORD}]}"))
	fi
	return 0
}

function _mc_complete()
{
	COMPREPLY=()
	local com=${COMP_WORDS[COMP_CWORD-1]};
	local cur=${COMP_WORDS[COMP_CWORD]};
	local j k
	if [[ $COMP_CWORD==1 && -z "$cur" ]];then
		case $com in
			'mc')
				if [ -d arch/arm/configs ];then
					local my_complete_word=$(ls arch/arm/configs/m* -l |awk '{print $8}'|sed "s#.*/##")
					COMPREPLY=($(compgen -W '${my_complete_word[@]}' -- $cur))
				fi
				;;
			*)
				;;
		esac
	else
		if [ -d arch/arm/configs ];then
			local my_complete_word=$(ls arch/arm/configs/${cur}* -l |awk '{print $8}'|sed "s#.*/##")
			COMPREPLY=($(compgen -W '${my_complete_word[@]}' -- $cur))
		fi
	fi
	return 0
}

function _mcd_complete()
{
	 COMPREPLY=()
	 local cur=${COMP_WORDS[COMP_CWORD]};
	 local com=${COMP_WORDS[COMP_CWORD-1]};
	 case $com in
	 'mcd')
		 local my_complete_word=($(cat /dev/shm/${MYUSERNAME}/daily_path))
		 COMPREPLY=($(compgen -W '${my_complete_word[@]}' -- $cur))
		 ;;
	 'c')
		 local my_complete_word=($(cat /dev/shm/${MYUSERNAME}/daily_path))
		 COMPREPLY=($(compgen -W '${my_complete_word[@]}' -- $cur))
		 ;;
	 *)
		 ;;
	 esac
	 return 0
}

function _mj_complete()
{
	 COMPREPLY=()
	 local cur=${COMP_WORDS[COMP_CWORD]};
	 local com=${COMP_WORDS[COMP_CWORD-1]};
	 case $com in
	 'mj')
		 local my_complete_word=('zImage' "clean" "distclean" "xconfig")
		 COMPREPLY=($(compgen -W '${my_complete_word[@]}' -- $cur))
		 ;;
	 *)
		 ;;
	 esac
	 return 0
}


function _unzip_l_complete()
{
	#local cw=$(ls *.zip)
	#COMPREPLY=($(compgen -W '${cw[@]}' -- $cur))
	COMPREPLY=($(compgen -f -- "${COMP_WORDS[${COMP_CWORD}]}"))
	return 0
}

complete -c tp
complete -c vm

complete -F _bypy_completion     bypy.py
complete -F _dnw_complete        dnw
complete -F _fastboot_completion fastboot
complete -F _ksvn_complete       ksvn
complete -F _make_complete       make
complete -F _mc_complete         mc
complete -F _mj_complete         mj
complete -F _unzip_l_complete    uzl

complete -W 'arch/arm/configs' lac
complete -W 'xconfig clean distclean zImage' mj

if [ $MYUSERNAME == $MYNICKNAME ];then
	if [ "x${OS}" != "xMac" ];then
		complete -o default -F _longopt vi
	fi
fi
