#!/bin/bash
#===============================================================================
#
#		   FILE:  my_path_functions.sh
#
#		  USAGE:  for quickly change directories.
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

function .()
{
		if [ $# -eq 0 ];then
				cd ".."
		else
			builtin . "$@"
		fi
}

function 。()
{
	read -p "call function '.()' y|n ?" c

	if [ "x${c}" == "xy" -o "x${c}" == "x" ];then
		. "$@"
	fi
}

function ..()
{
		if [ $# -eq 0 ];then
				cd "../.."
		else
			builtin .. "$@"
		fi
}

function ...()
{
		if [ $# -eq 0 ];then
				cd "../../.."
		else
			builtin ... "$@"
		fi
}

function ac()
{
	if [ -f ${HOME}/dev/${MYUSERNAME}/apwdpath ];then
		local tmpDir="$(cat ${HOME}/dev/${MYUSERNAME}/apwdpath)"
		if [ -d "${tmpDir/\~/${HOME}}" ];then
			builtin cd "${tmpDir/\~/${HOME}}" && unset "tmpDir"
		else
			echo "Not exist dir: ${tmpDir}"
		fi
	fi
}

function ap()
{
	if [ $# -ge 1 ];then
		if [ $1 == '.' ];then
			export PATH="$(pwd):$PATH"
			echo $PATH
			export LD_LIBRARY_PATH="$(pwd):${LD_LIBRARY_PATH}"
			echo $LD_LIBRARY_PATH
		fi
	else
		pwd | sed -e "s#^${HOME}#~#"
		[ -d ${HOME}/dev/${MYUSERNAME} ] || mkdir -p ${HOME}/dev/${MYUSERNAME}
		pwd | sed -e "s#^${HOME}#~#" > ${HOME}/dev/${MYUSERNAME}/apwdpath;
	fi
}

function apwd_abc()
{
		builtin pwd;
		local p=$(builtin pwd);
		grep -q "^$p$"	${HOME}/dev/${MYUSERNAME}/daily_path
		if [ $? != 0 ]; then
				builtin pwd >> ${HOME}/dev/${MYUSERNAME}/daily_path;
		fi
		wc -l ${HOME}/dev/${MYUSERNAME}/daily_path |awk '{print $1}' > \
		${HOME}/dev/${MYUSERNAME}/total_count
}

function ca()
{
		if [ ! -f ~/pwd.mk ];then
				echo "no ~/pwd.mk file"
				return 1;
		fi
		if [ ! -f ${HOME}/dev/${MYUSERNAME}/pwd_pos ]; then
				echo "1" > ${HOME}/dev/${MYUSERNAME}/pwd_pos;
				local  pwd_pos=1;
		else local pwd_pos=$(cat ${HOME}/dev/${MYUSERNAME}/pwd_pos);
				#if [ ! -f ${HOME}/dev/${MYUSERNAME}/pwd_total_count ];then
						wc -l ~/pwd.mk |awk '{print $1}' > ${HOME}/dev/${MYUSERNAME}/pwd_total_count
				#fi
				local total_count=$(cat ${HOME}/dev/${MYUSERNAME}/pwd_total_count);
				((pwd_pos ++));
				if [ $pwd_pos -gt $total_count ];
				then pwd_pos=$(expr $pwd_pos - $total_count);
				fi
				echo $pwd_pos > ${HOME}/dev/${MYUSERNAME}/pwd_pos;
		fi
		local enter_dir=$(sed -n "$pwd_pos{p;q;}"  ~/pwd.mk)
		builtin cd "$enter_dir"
}

function cda()
{
	if [ -d /tmp/a ];then
		cd /tmp/a
	fi
}

function cdb()
{
	if [ -d /tmp/b ];then
		cd /tmp/b
	fi
}

function cdc()
{
	if [ -d arch/arm/configs ];then
		cd arch/arm/configs
		return 0;
	fi
	local prjn=""
	if [ $# -ge 1 ];then
		prjn=$1
	else
		if [ -f ${HOME}/dev/${MYUSERNAME}/androidProjectName ];then
			prjn=$(cat ${HOME}/dev/${MYUSERNAME}/androidProjectName)
		fi
	fi
	if [ -d device/ ];then
		local enter_dir_file=${HOME}/dev/${MYUSERNAME}/cd_enter_dirs
		: > ${enter_dir_file}
		local tmpDir
		if [ "x${prjn}" != "x" ];then
			for tmpDir in $(find device/ -name BoardConfig.mk);do
				dirname ${tmpDir}  | grep ${prjn} | tee -a ${enter_dir_file}
			done
		else
			for tmpDir in $(find device/ -name BoardConfig.mk);do
				dirname ${tmpDir} | tee -a ${enter_dir_file}
			done
		fi
		cd_dir_in_file
		return 0;
	fi
}

function cdd()
{
	local docdir=${HOME}/Documents/
	if [ -d ${docdir} ];then
		cd ${docdir}
	fi
}

function cdm()
{
	if [ -d arch/arm/mach-exynos4/ ];then
		cd arch/arm/mach-exynos4/
	fi
	if [ -d arch/arm/mach-exynos/ ];then
		cd arch/arm/mach-exynos/
	fi
}

function cdo()
{
	export TIME_STYLE=long-iso
	local old_dir=$(echo "$(ls -ltr | grep "^d" | awk '{print $8}' |\
		grep -E -v '^\.' | sed -n '1,1p')" | tac )
	echo cd ${old_dir}
	cd ${old_dir}
}

function cds()
{
	local sDev=dev1
	local newFile=${HOME}/${sDev}/server_path.mk

	if [ ! -d ${HOME}/person_tools ];then
		touch ~/server_path.mk
		pwd > ~/server_path.mk
	else
		local devlist=(dev1/2t/home/karlzheng dev2/sztv/changliang \
			dev3/home/karlzheng)
		local dev
		for dev in ${devlist[@]}; do
			local file=${HOME}/${dev}/server_path.mk
			if [ -f ${file} ];then
				if [ ${newFile} -ot ${file}  ];then
					newFile=${file}
					sDev=${dev}
				fi
			fi
		done
		echo ${newFile}
		local cds_path="$(cat ${newFile} | tr -d '\r')"
		echo "cd ${HOME}/${sDev%%/*}${cds_path}"
		builtin cd "${HOME}/${sDev%%/*}${cds_path}"
	fi
}

function ct()
{
	if [ $# -eq 1 ];then
		cat "$@"
	else
		local f=${HOME}/dev/${MYUSERNAME}/cd_enter_dirs
		: > ${f}
		echo "~/tmp" >>	 ${f}
		echo "~/bashrc/script/" >>	${f}
		echo "/tmp" >>  ${f}
		cat -n ${f}
		cd_dir_in_file
	fi
}

function t.sh()
{
	local fn=${HOME}/tmp/tee.log

	cat ${fn}
}

function ctlog()
{
	local lfp=${HOME}/tmp/log/t

	mkdir -p ${lfp}
	cd ${lfp}
}

function ctt()
{
	mkdir -p ~/tmp/t
	cd ~/tmp/t
}

function cv()
{
	if [ ! -f ${HOME}/dev/${MYUSERNAME}/vim_cur_file_path ];
		then echo "no ${HOME}/dev/${MYUSERNAME}/vim_cur_file_path file";
	else
		local enter_dir="$(cat ${HOME}/dev/${MYUSERNAME}/vim_cur_file_path)";
		builtin cd "$enter_dir"
	fi
}

#http://tldp.org/LDP/abs/html/internal.html
function bash_get_keycode()
{
	local a;
	IFS='' read -srn1 a
    if [ "$a" == $'\x1b' ];then
        read -sn1 a
        if [ "$a" == $'\x5b' ];then
            read -sn1 a
            case "$a" in
                A)  echo "up";;
                B)  echo "down";;
                C)  echo "right";;
                D)  echo "left";;
            esac
        fi
    else
        if [ "x$a" == "xq" -o "x$a" == "xQ" ];then
            echo "q"
        else
			if [ "x$a" == "x" ];then
                echo "enter"
			else
				if [ "x$a" == "x " ];then
					echo "space"
				fi
            fi
        fi
    fi
}

function cd_dir_in_file()
{
	if [ $# -eq 0 ];then
		local enter_dir_file=${HOME}/dev/${MYUSERNAME}/cd_enter_dirs
	else
		local enter_dir_file="$1"
	fi
	local cnt=$(wc -l ${enter_dir_file} | awk '{print $1}')
	if [ $cnt -eq 1 ];then
		local enter_dir=$(cat "$enter_dir_file")
		builtin cd "${enter_dir/\~/${HOME}}"
		return ;
	fi
	#trap 'stty icanon iexten echo echoe echok;printf "%-100s\r" " ";break;' SIGINT SIGHUP SIGTERM
	trap 'stty icanon iexten echo echoe echok;printf "%-100s\r" " ";break;' SIGHUP SIGTERM
	local  cur_pos=0;
	while read file; do
		local the_dirs[$cur_pos]="$file"
		((cur_pos++))
	done < $enter_dir_file
	cur_pos=0;
	while true;do
		local enter_dir="${the_dirs[cur_pos]}"
		printf '%-100s\r' "Enter: ${enter_dir} ?"

		local key=$(bash_get_keycode | tr -d '\r' | tr -d '\n');

		case "$key" in
			"up" | "-up")
				((cur_pos --));
				if [ $cur_pos -lt 0 ];then
					let cur_pos=$cur_pos+$cnt
				fi
				;;
			"down"| "-down" | "space")
				((cur_pos ++));
				if [ $cur_pos -ge $cnt ];then
					let cur_pos=0
				fi
				;;
			"enter" | "ENTER")
				if [ -d "$(eval echo ${enter_dir/\~/${HOME}})" ];then
					builtin cd "${enter_dir/\~/${HOME}}"
					break;
				else
					printf "No dir:%-120s\n" "${enter_dir}"
				fi
				;;
			"q"|"Q")
				printf "%-100s\r" " "
				break;
				;;
			*)
				echo "anything: $key"
				;;
		esac
	done
	#trap - SIGINT SIGHUP SIGTERM
	trap - SIGHUP SIGTERM
}

mkdir -p ${HOME}/dev/"${MYUSERNAME}"

function c()
{
	local ef=${HOME}/dev/${MYUSERNAME}/cd_enter_dirs
	: > $ef
	if [ $# -eq 0 ];then
		#cat -n ${HOME}/pwd.mk | sed -e '/^\s*[1-9]*\s*#.*/d'
		#echo "${HOME}" > "$ef"
		cat	${HOME}/pwd.mk | grep -E -v "^#" >> "$ef"
	else
		cat	${HOME}/pwd.mk | grep -i "$*" | grep -E -v "^#" >> "$ef"
	fi
	cat -n "$ef"
	cd_dir_in_file
}

function cd()
{
	local d
	if [ $# -eq 0 ];then
		builtin cd "$@"
	else
		if [ -d "$1" -o "$1" == '-' ];then
			builtin cd "$@"
		else
			if [ $# -eq 1 ];then
				local no_host_dir=$(echo $1 | \
					sed -e 's#\w*@.*:\(.*\)#\1#')
				if [ -d "${no_host_dir/\~/${HOME}}" ];then
					builtin cd "${no_host_dir/\~/${HOME}}"
				else
					local OLD_IFS=${IFS}
					IFS=$'\n'
					local bn=$(dirname $1)
					if [ -d "${bn}" -a "x${bn}" != 'x.' ];then
						builtin cd ${bn}
					else
						local enter_dir_file=${HOME}/dev/${MYUSERNAME}/cd_enter_dirs
						mkdir -p ${HOME}/dev/"${MYUSERNAME}"
						: > $enter_dir_file
						for d in $(/bin/ls -la | grep -E "^d|^l" | \
							awk '{print $NF}' | grep -i "$1" );
						do
							if [ -d "${d}" ];then
								echo "${d}" >> $enter_dir_file
							fi
						done
						if [ -f "$1" ];then
							echo "$(dirname $1)" >> $enter_dir_file
						fi
						local cnt=$(cat "$enter_dir_file" | wc -l)
						if [ $cnt -gt 0 ];then
							cat -n "$enter_dir_file"
							cd_dir_in_file
						fi
					fi
					IFS=${OLD_IFS}
				fi
			else
				if [ $# -eq 3 ];then
					if [ $2 == "is" ];then
						echo "cd $3"
						cd "$3"
					fi
				else
					if [ $# -eq 4 ];then
						if [ $2 == "is" -a $3 == "hashed" ];then
							local td=$(echo ${a#(*})
							local td=$(echo ${td%*)})
							echo "cd ${td}"
							if [ -d "${td}" ];then
								builtin cd "${td}"
							else
								builtin cd $(dirname "${td}")
							fi
						fi
					else
						builtin cd "$@"
					fi
				fi
			fi
	fi
fi
}

function cdt()
{
	cd /tmp/t
}

function ci()
{
	local productDir=out/target/product/
	local SAVE_OLDPWD=""
	if [ -d "arch/arm/boot" ];then
		SAVE_OLDPWD="$(pwd)"
		echo "arch/arm/boot"
		cd "arch/arm/boot"
	else
		if [ -d out/debug/target/product/ ];then
			#if [ $productDir -ot out/debug/target/product/ ];then
				#productDir=out/debug/target/product/
			#fi
			productDir=out/debug/target/product/
		fi
		if [ -d "$productDir" ];then
			SAVE_OLDPWD="$(pwd)"
			cd $productDir
			local recent_productDir=$(ls -latr | tail -n 1 |awk '{print $NF}');
			cd "${recent_productDir}"
			echo $productDir/"${recent_productDir}"
		fi
	fi
	if [ -n $SAVE_OLDPWD ];then
		OLDPWD=$(echo $SAVE_OLDPWD)
	fi
}

function cr()
{
	local is_root_dir=0;

	function is_project_root_dir()
	{
		local ANDROIDENVSETUP=build/core/envsetup.mk;
		local KERNELCONFIGDIR=arch/arm/configs;
		let is_root_dir=0
		if [ -f ${ANDROIDENVSETUP} ] || \
		   [ "$(pwd)" == "${HOME}" ] || \
		   [ "$(pwd)" == "/" ] || \
		   ([ -d $KERNELCONFIGDIR ] && [ ! -f ../${ANDROIDENVSETUP} ]) || \
		   ([ -d '.git' ] && [ ! -f ../${ANDROIDENVSETUP} ]) || \
		   ([ -d '.repo' ] && [ ! -f ../${ANDROIDENVSETUP} ]) || \
		   ( [ -f .project ] && [ -f project.properties ] ) || \
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
	local T=;
	is_project_root_dir
	while [ $is_root_dir != 1 -a "$PWD" != "/" ];
	do
		builtin cd .. > /dev/null;
		T=`PWD= /bin/pwd`;
		is_project_root_dir
	done;
	is_project_root_dir
	cd "$HERE" > /dev/null;
	if [ $is_root_dir == 1 -a "x$T" != "x" ]; then
		echo "$HERE => $T";
		cd "$T";
	else
		if [ -n $SAVE_OLDPWD ];then
			OLDPWD=$(echo $SAVE_OLDPWD)
		fi
	fi;
	unset is_project_root_dir
}

function crm()
{
	local is_root_dir=0;

	function is_project_root_dir()
	{
		local ANDROIDENVSETUP=build/core/envsetup.mk;
		local KERNELCONFIGDIR=arch/arm/configs;
		let is_root_dir=0
		if [ -e Android.mk ] || [ -e Makefile ] || [ -e makefile ] ||
		   [ "$(pwd)" == "${HOME}" ] || [ "$(pwd)" == "/" ];then
			let is_root_dir=1
		fi
		return $is_root_dir;
	}
	if [ -n $OLDPWD ];then
		local SAVE_OLDPWD="$OLDPWD"
	fi
	PWD=$(/bin/pwd);
	local HERE="$PWD";
	local T=;
	is_project_root_dir
	while [ $is_root_dir != 1 -a "$PWD" != "/" ];
	do
		cd .. > /dev/null;
		T=`PWD= /bin/pwd`;
		is_project_root_dir
	done;
	is_project_root_dir
	cd "$HERE" > /dev/null;
	if [ $is_root_dir == 1 -a "x$T" != "x" ]; then
		echo "$HERE => $T";
		cd "$T";
	else
		echo "$HERE";
		if [ -n $SAVE_OLDPWD ];then
			OLDPWD=$(echo $SAVE_OLDPWD)
		fi
	fi;
	unset is_project_root_dir
}

function crr()
{
	local is_root_dir=0;

	function is_project_root_dir()
	{
		local ANDROIDENVSETUP=build/core/envsetup.mk;
		local KERNELCONFIGDIR=arch/arm/configs;
		let is_root_dir=0
		if [ -f $ANDROIDENVSETUP ] || \
		   [ -d '.repo' ] || [ -d '.git' ] || \
		   [ -d $KERNELCONFIGDIR ] || \
		   [ "$(pwd)" == "${HOME}" ] || \
		   [ "$(pwd)" == "/" ] || \
		   ( [ -f .project ] && [ -f project.properties ] ) || \
		   ( [ -d board ] && [ -d arch ] && [ -d drivers ] );then
			let is_root_dir=1
		fi
		return $is_root_dir;
	}
	#if [ -n "$T" ]; then
		#echo "auto change to TOP dir: $T"
		#cd "$T";
		#return 0;
	#fi
	if [ -n $OLDPWD ];then
		local SAVE_OLDPWD="$OLDPWD"
	fi
	PWD=$(/bin/pwd);
	local HERE="$PWD";
	local T=;
	is_project_root_dir
	while [ $is_root_dir != 1 -a "$PWD" != "/" ];
	do
		cd .. > /dev/null;
		T=`PWD= /bin/pwd`;
		is_project_root_dir
	done;
	is_project_root_dir
	cd "$HERE" > /dev/null;
	if [ $is_root_dir == 1 -a "x$T" != "x" ]; then
		echo "$HERE => $T";
		cd "$T";
	else
		if [ -n $SAVE_OLDPWD ];then
			OLDPWD=$(echo $SAVE_OLDPWD)
		fi
	fi;
	unset is_project_root_dir
}

function dlb()
{
	local enter_dir_file=${HOME}/dev/${MYUSERNAME}/cd_enter_dirs
	local kfb_samba_dir="/home/karlzheng/kfb"
	local dir_prefix="$kfb_samba_dir/DailyBuild/DailyBuildM0"
	local dir3x=(
	"${dir_prefix}3X/app/IceCreamSandwich/eng"
	"${dir_prefix}3X/app/IceCreamSandwich/user"
	"${dir_prefix}3X/app/JellyBean/user"
	"${dir_prefix}3X/app/JellyBean/eng"
	)
	local dir40=(
	"${dir_prefix}40/app/IceCreamSandwich/user"
	"${dir_prefix}40/app/IceCreamSandwich/eng"
	"${dir_prefix}40/app/JellyBean/user"
	"${dir_prefix}40/app/JellyBean/eng"
	)
	local buid_dirs
	local machine=( "3x" "40" )

	while [ $# -gt 0 ] ; do
			case "$1" in
			3x) machine=("3x"); shift ;;
			40) machine=("40"); shift ;;
			*)	break ;;
			esac
	done
	for i in ${machine[@]}; do
		eval buid_dirs=( \${buid_dirs[@]} \${dir${i}[@]} )
	done
	#echo ${buid_dirs[*]}
	for i in ${buid_dirs[*]}; do
		if [ -d "$i" ];then
			if [ "x$LANG" == "xC" ];then
				local recent_dirs=$(echo "$(ls -lt "$i" | awk '{print $9}'\
					| grep -E -v '^\.' | sed -n '2,3p')" | tac )
			else
				local recent_dirs=$(echo "$(ls -lt "$i" | awk '{print $8}'\
					| grep -E -v '^\.' | sed -n '2,3p')" | tac )
			fi
			for j in ${recent_dirs[*]};
			do
				echo -e "$i/$j" | tee -a ${enter_dir_file}
			done
		fi
	done

	tac ${enter_dir_file} > ${enter_dir_file}.$$.file
	/bin/mv	 ${enter_dir_file}.$$.file ${enter_dir_file}
	echo ""

	cd_dir_in_file
}

function ajavapath()
{
	local WHICH_JAVA=$(which java)

	if [ "x${WHICH_JAVA}" == "x" ];then
		return
	fi

	if [ -h ${WHICH_JAVA} ];then
		local JAVA_BIN_PATH="$(dirname $(readlink ${WHICH_JAVA}))"
	else
		local JAVA_BIN_PATH="$(dirname ${WHICH_JAVA})"
	fi

	if [ "x${JAVA_BIN_PATH}" != "x" ];then
		export PATH=${JAVA_BIN_PATH}:${PATH}:
	fi

	if [ ${OS} == "OSX" ];then
		export JAVA_HOME=$(java_home 2>/dev/null)
	else
		local JAVA_BIN_PATH="$(dirname $(readlink -f ${WHICH_JAVA}))"
		if [ -f java ];then
			JAVA_BIN_PATH="$(pwd)"
		else
			if [ -f bin/java ];then
				JAVA_BIN_PATH="$(pwd)/bin"
			fi
		fi
		local JAVA_PATH="${JAVA_BIN_PATH}/.."
		export JAVA_HOME="${JAVA_PATH}/"
	fi
}

function p()
{
	pwd
}

function pa()
{
		touch ${HOME}/pwd.mk
		grep -q "^$(pwd)$" ${HOME}/pwd.mk
		if [ $? != 0 ]; then
				pwd | sed -e "s#^${HOME}#~#" >> ${HOME}/pwd.mk
				awk '!a[$0]++' ${HOME}/pwd.mk > ${HOME}/$$.pwd.mk
				#cat $$.pwd.mk | sort > ${HOME}/pwd.mk
				#rm $$.pwd.mk
				/bin/mv ${HOME}/$$.pwd.mk ${HOME}/pwd.mk
		else
				echo "$(pwd) has already in ${HOME}/pwd.mk"
		fi
}

function ed()
{
	export TIME_STYLE=long-iso
	if [ ${OS} == "OSX" ];then
		local recent_dir=$(echo "$(ls -lt | grep "^d" | awk '{print $9}' |\
			grep -E -v '^\.' | sed -n '1,1p')" | tac )
	else
		local recent_dir=$(echo "$(ls -lt | grep "^d" | awk '{print $8}' |\
			grep -E -v '^\.' | sed -n '1,1p')" | tac )
	fi
	echo cd ${recent_dir}
	cd ${recent_dir}
}
