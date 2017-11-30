#!/bin/bash
#===============================================================================
#
#          FILE:  mig.sh
#
#         USAGE:  ./mig.sh
#
#   DESCRIPTION:  mig = multi dirs ignore-case grep
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (http://blog.csdn.net/zhengkarl), ZhengKarl#gmail.com
#       COMPANY: Alibaba
#       CREATED: 2010年09月26日 10时15分37秒 CST
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

SEACH_RESULT_FILE="${HOME}/shm/$(whoami)/quickfix.txt"

function get_root_dir()
{
    local is_root_dir=0;

    function is_project_root_dir()
    {
	local ANDROIDENVSETUP=build/core/envsetup.mk;
	local KERNELCONFIGDIR=arch/arm/configs;
	let is_root_dir=0
	if [ -f $ANDROIDENVSETUP ] || \
	   [ -f t ] || \
	   [ -d $KERNELCONFIGDIR ] || \
	   ( [ -d board ] && [ -d arch ] && [ -d drivers ] );then
	    let is_root_dir=1
	fi
	return $is_root_dir;
    }

    if [ -n $OLDPWD ];then
	local SAVE_OLDPWD="$OLDPWD"
    fi

    PWD=$(/bin/pwd);
    local HERE="$PWD";
    local T="";
    is_project_root_dir
    while [ $is_root_dir != 1 -a "$PWD" != "/" ]; do
	cd .. > /dev/null;
	PWD=$(/bin/pwd);
	T=${PWD};
	is_project_root_dir
    done;
    is_project_root_dir
    cd "${HERE}" > /dev/null;
    if [ -n $SAVE_OLDPWD ];then
	OLDPWD=$(echo $SAVE_OLDPWD)
    fi
    unset is_project_root_dir

    echo "$T"
}

function modify_seach_result_file()
{
    local r=$(get_root_dir)
    if [ "${r}" != "" -a "${r}" != "/" ];then
	local cur_dir="$(/bin/pwd)"
	#echo "r:$r"
	#echo "cur_dir:$cur_dir"
	if [ "${r}" != "${cur_dir}" ];then
	    r="${r}/"
	    local prefix=${cur_dir/${r}/}
	    #echo $prefix
	    sed -i -e "s#^#${prefix}/&#" ${SEACH_RESULT_FILE}
	fi
    fi
}

: > $SEACH_RESULT_FILE

if [ -f ./mg.mk ];then
	while read line;do
		line=$(echo -n "$line" |sed -e 's#^\#.*##g')
		if [ "x$line" != "x" ];then
			if [ -d "$line" ];then
				find "$line" \
					! -type d \
					-a ! -type l \
					-not -regex '.*.cmd' \
					-not -regex '.*.svn-base' \
					-not -regex  '.*\.svn.*' \
					-exec grep -HniI "$@" {} + \
					| grep -v "./tags" \
					| grep -v "./gtags" \
					| grep -v "./cscope" \
					| grep -v "./filenametags" \
					| grep -v "./fullfilenametags" \
					| grep -v ^tags \
					| grep -v cscope.out \
					| tee -a $SEACH_RESULT_FILE
			else
				echo "not exist dir: $line"
			fi
		fi
	done < ./mg.mk

	if [ $(whoami) != "karlzheng" ];then
		cp  $SEACH_RESULT_FILE "${HOME}/quickfix.txt"
	fi
else
	find . \
		! -type d \
		-a ! -type l \
		-not -regex '.*.map' \
		-not -regex '.*.htm' \
		-not -regex '.*.cmd' \
		-not -regex '.*.svn-base' \
		-not -regex  '.*\.svn.*' \
		-exec grep -HniI "$@" {} + \
		| grep -v "./tags" \
		| grep -v "./gtags" \
		| grep -v "./cscope" \
		| grep -v "./filenametags" \
		| grep -v "./fullfilenametags" \
		| grep -v ^tags \
		| grep -v cscope.out \
		| grep -v '/keil/Objects' \
		| tee -a $SEACH_RESULT_FILE

	if [ $(whoami) != "karlzheng" ];then
		cp  $SEACH_RESULT_FILE "${HOME}/quickfix.txt"
	fi
fi

#modify_seach_result_file
