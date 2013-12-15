#!/bin/bash
#===============================================================================
#
#          FILE:  my_path_functions.sh
#
#         USAGE:  for quickly change directories.
#
#   DESCRIPTION:
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#          BLOG: http://blog.csdn.net/zhengkarl
#         WEIBO: http://weibo.com/zhengkarl
#       COMPANY: Alibaba
#       CREATED: 2012年05月21日 19时12分43秒 CST
#      REVISION:  ---
#===============================================================================

function .()
{
	if [ $# -eq 0 ];then
		cd ".."
	else
	    builtin . "$@"
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

function ac()
{
    if [ -f /dev/shm/${MYUSERNAME}/apwdpath ];then
	tmp_dir="$(cat /dev/shm/${MYUSERNAME}/apwdpath)"
	if [ -d "${tmp_dir/\~/${HOME}}" ];then
	    builtin cd "${tmp_dir/\~/${HOME}}" && unset "tmp_dir"
	else
	    echo "Not exist dir: $tmpfile"
	fi
    fi
}

function ap()
{
    if [ $# -ge 1 ];then
	if [ $1 == '.' ];then
	    export PATH="$(pwd):$PATH"
	    echo $PATH
	fi
    else
	pwd | sed -e "s#${HOME}#~#"
	[ -d /dev/shm/${MYUSERNAME} ] || mkdir -p /dev/shm/${MYUSERNAME}
	pwd | sed -e "s#${HOME}#~#" > /dev/shm/${MYUSERNAME}/apwdpath;
    fi
}

function apwd_abc()
{
	builtin pwd;
	local p=$(builtin pwd);
	grep -q "^$p$"  /dev/shm/${MYUSERNAME}/daily_path
	if [ $? != 0 ]; then
		builtin pwd >> /dev/shm/${MYUSERNAME}/daily_path;
	fi
	wc -l /dev/shm/${MYUSERNAME}/daily_path |awk '{print $1}' > \
	/dev/shm/${MYUSERNAME}/total_count
}

function avp()
{
    pwd > /dev/shm/diff_file_rela_path
}

function ca()
{
	if [ ! -f ~/bashrc/karlzheng_config/pwd.mk ];then
		echo "no ~/bashrc/karlzheng_config/pwd.mk file"
		return 1;
	fi
	if [ ! -f /dev/shm/${MYUSERNAME}/pwd_pos ]; then
		echo "1" > /dev/shm/${MYUSERNAME}/pwd_pos;
		local  pwd_pos=1;
	else local pwd_pos=$(cat /dev/shm/${MYUSERNAME}/pwd_pos);
		#if [ ! -f /dev/shm/${MYUSERNAME}/pwd_total_count ];then
			wc -l ~/bashrc/karlzheng_config/pwd.mk |awk '{print $1}' > /dev/shm/${MYUSERNAME}/pwd_total_count
		#fi
		local total_count=$(cat /dev/shm/${MYUSERNAME}/pwd_total_count);
		((pwd_pos ++));
		if [ $pwd_pos -gt $total_count ];
		then pwd_pos=$(expr $pwd_pos - $total_count);
		fi
		echo $pwd_pos > /dev/shm/${MYUSERNAME}/pwd_pos;
	fi
	local enter_dir=$(sed -n "$pwd_pos{p;q;}"  ~/bashrc/karlzheng_config/pwd.mk)
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
	if [ $# -eq 0 ];then
		if [ -d arch/arm/configs ];then
		    cd arch/arm/configs
		else
		    if [ -d device ];then
			local enter_dir_file=/dev/shm/${MYUSERNAME}/cd_enter_dirs
			if [ -d device/de/ ];then
			    find device/de/ -maxdepth 1 -type d -name "t*" \
			    | sed -n -e '{1,$p}' | tee $enter_dir_file
			else
			    if [ -d device/meizu/ ];then
				find device/meizu/ -maxdepth 1 -type d -name "m*" \
				| sed -n -e '{2,$p}' | tee $enter_dir_file
			    else
				if [ -d device/samsung/ ];then
				    find device/samsung/ -maxdepth 1 -type d -name "smdk4*" \
				    | tee $enter_dir_file
				fi
			    fi
			fi
			cd_dir_in_file
		    fi
		fi
	else
		cd $1
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

function cdr()
{
    #echo cd $(/bin/ls -Altr | tail -n 1 | awk '{print $NF}')
    #cd $(/bin/ls -Altr | tail -n 1 | awk '{print $NF}')
    local recent_dirs=$(echo "$(ls -lt | awk '{print $9}' | grep -E -v '^\.' | sed -n '2,2p')" | tac )
    echo cd ${recent_dirs}
    cd ${recent_dirs}
}

function cds()
{
    local DEV1=${HOME}/dev1
    local DEV2=${HOME}/dev2

    if [ ! -d ${DEV1} ];then
	touch ~/server_path.mk
	pwd > ~/server_path.mk
    else
	local PATHFILE=${DEV1}/server_path.mk
	local PREPATH=${DEV1}

	if [ ${PATHFILE} -ot ${DEV2}/server_path.mk ];then 
	    PATHFILE=${DEV2}/server_path.mk
	    PREPATH=${DEV2}
	fi
	
	local cds_path="$(cat ${PATHFILE} | \
	    sed -e "s#/\w*/\w*##" | tr -d '\r')"
	echo "cd ${PREPATH}/$cds_path"
	builtin cd "${PREPATH}/$cds_path"
    fi
}

function ct()
{
    local enter_dir_file=/dev/shm/${MYUSERNAME}/cd_enter_dirs

    echo "/tmp" >  ${enter_dir_file}
    echo "~/tmp" >>  ${enter_dir_file}
    echo "~/bashrc/script/" >>  ${enter_dir_file}
    cat -n ${enter_dir_file}
    cd_dir_in_file
}

function cv()
{
    if [ ! -f /dev/shm/${MYUSERNAME}/vim_cur_file_path ];
        then echo "no /dev/shm/${MYUSERNAME}/vim_cur_file_path file";
    else
        local enter_dir="$(cat /dev/shm/${MYUSERNAME}/vim_cur_file_path)";
        builtin cd "$enter_dir"
    fi
}

function bash_get_keycode()
{
#http://www.linuxquestions.org/questions/programming-9/bash-case-with-arrow-keys-and-del-backspace-etc-523441/
#http://mywiki.wooledge.org/ReadingFunctionKeysInBash
#set -o nounset
#set -o errexit
	function ord()
	{
		printf -v "${1?Missing Dest Variable}" "${3:-%d}" "'${2?Missing Char}"
	}

	function ord.eascii()
	{
		LC_CTYPE=C ord "${@}"
	}

	###############################
	##
	##    READ KEY CRAP
	##
	###############################

	KeyModifiers=(
	[2]="S"   [3]="A"   [4]="AS"   [5]="C"   [6]="CS"  [7]="CA"    [8]="CAS"
	[9]="M" [10]="MS" [11]="MA" [12]="MAS" [13]="MC" [14]="MCS" [15]="MCA" [16]="MCAS"
	)

	KeybFntKeys=(
	[1]="home" [2]="insert" [3]="delete"  [4]="end"   [5]="pageUp" [6]="pageDown"
	[11]="f1"  [12]="f2"    [13]="f3"     [14]="f4"   [15]="f5"
	[17]="f6"  [18]="f7"    [19]="f8"     [20]="f9"   [21]="f10"
	[23]="f11" [24]="f12"   [25]="f13"    [26]="f14"  [28]="f15"
	[29]="f16" [31]="f17"   [32]="f18"    [33]="f19"  [34]="f20"
	)

	KeybFntKeysAlt=(
	# A          B              C               D             E                   F             H
	[0x41]="up" [0x42]="down" [0x43]="right" [0x44]="left" [0x45]="keypad-five" [0x46]="end" [0x48]="home"
	# I               O
	[0x49]="InFocus" [0x4f]="OutOfFocus"
	# P           Q           R           S             Z
	[0x50]="f1" [0x51]="f2" [0x52]="f3" [0x53]="f4"  [0x5a]="S-HT"
	)

	C0CtrlChars=(
	[0x00]="Null" [0x01]="SOH" [0x02]="STX" [0x03]="ETX" [0x04]="EOT" [0x05]="ENQ" [0x06]="ACK"
	[0x07]="BEL"  [0x08]="BS"  [0x09]="HT"  [0x0A]="LF"  [0x0B]="VT"  [0x0C]="FF"  [0x0D]="CR"
	[0x0E]="SO"   [0x0F]="SI"  [0x10]="DLE" [0x11]="DC1" [0x12]="DC2" [0x13]="DC3" [0x14]="DC4"
	[0x15]="NAK"  [0x16]="SYN" [0x17]="ETB" [0x18]="CAN" [0x19]="EM"  [0x1A]="SUB" [0x1B]="ESC"
	[0x1C]="FS"   [0x1D]="GS"  [0x1E]="RS"  [0x1F]="US"  [0x20]="SP"  [0x7F]="DEL"
	)

	C1CtrlCharsAlt=(
	[0x01]="CA-A" [0x02]="CA-B" [0x03]="CA-C" [0x04]="CA-D"  [0x05]="CA-E" [0x06]="CA-F" [0x07]="CA-G"
	[0x08]="CA-H" [0x09]="CA-I" [0x0a]="CA-J" [0x0b]="CA-K"  [0x0c]="CA-L" [0x0d]="CA-M" [0x0e]="CA-N"
	[0x0f]="CA-O" [0x10]="CA-P" [0x11]="CA-Q" [0x12]="CA-R"  [0x13]="CA-S" [0x14]="CA-T" [0x15]="CA-U"
	[0x16]="CA-V" [0x17]="CA-W" [0x18]="CA-X" [0x19]="CA-Y"  [0x1a]="CA-Z" [0x1b]="CA-[" [0x1c]="CA-]"
	[0x1d]="CA-}" [0x1e]="CA-^" [0x1f]="CA-_" [0x20]="CA-SP" [0x7F]="A-DEL"
	)

	function ReadKey()
	{
		unset UInput[@]
		local escapeSequence
		local REPLY

		if IFS='' read -srN1 ${1:-} escapeSequence; then
			case "${escapeSequence}" in
				[^[:cntrl:]])
					UInput[0]="${escapeSequence}"
					;;
				$'\e')
					while IFS='' read -srN1 -t0.0001 ; do
						escapeSequence+="${REPLY}"
					done
					case "${escapeSequence}" in
					$'\e'[^[:cntrl:]]) echo -n "A-${escapeSequence:1}"
						;;
					${CSI}[0-9]*[ABCDEFHIOZPQRSz~])
						local CSI_Params=( ${escapeSequence//[!0-9]/ } )
						local CSI_Func="${escapeSequence:${#escapeSequence}-1}"
						case "${CSI_Func}" in
							'~') # Function Keys
								UInput[0]="${KeybFntKeys[${CSI_Params[0]}]-}"
								if [ -n "${UInput[0]}" ]; then
									[ ${#CSI_Params[@]} -le 1 ] ||  UInput[0]="${KeyModifiers[${CSI_Params[1]}]}-${UInput[0]}"
								else
									UInput[0]="CSI ${CSI_Params[*]} ${CSI_Func}"
								fi
								;;
							A|B|C|D|E|F|H|I|O|Z|P|Q|R|S)
								ord.eascii CSI_Func "${CSI_Func}"
								UInput[0]="${KeybFntKeysAlt[${CSI_Func}]}"
								if [ -n "${UInput[0]}" ]; then
									[ ${#CSI_Params[@]} -le 1 ] ||  UInput[0]="${KeyModifiers[${CSI_Params[1]}]}-${UInput[0]}"
								else
									UInput[0]="CSI ${CSI_Params[*]} ${CSI_Func}"
								fi
								;;
							*)
								UInput[0]="CSI ${CSI_Params[*]} ${CSI_Func}"
								;;
						esac ;;
					${SS3}*[ABCDEFHPQRSIO~])
						local SS3_Params=( ${escapeSequence//[!0-9]/ } )
						local SS3_Func="${escapeSequence:${#escapeSequence}-1}"
						case "${SS3_Func}" in
							A|B|C|D|E|F|H|P|Q|R|S|~)
								ord.eascii SS3_Func "${SS3_Func}"
								UInput[0]="${KeybFntKeysAlt[${SS3_Func}]-}"
								if [ -n "${UInput[0]}" ]; then
									[ ${#SS3_Params[@]} -lt 1 ] ||  UInput[0]="${KeyModifiers[${SS3_Params[0]}]}-${UInput[0]}"
								else
									UInput[0]="SS3 ${SS3_Params[*]-} ${SS3_Func}"
								fi
								;;
							*)
								UInput[0]="SS3 ${SS3_Params[*]-} ${SS3_Func}"
								;;
						esac
						;;
					$'\e'[[:cntrl:]])
						ord.eascii UInput[0] "${escapeSequence:1:1}"
						UInput[0]="${C1CtrlCharsAlt[${UInput[0]}]:-}"
						[ -n "${UInput[0]:-}" ] ||  UInput[0]="$(printf "%q" "${escapeSequence}")"
						;;
					$'\e')
						UInput[0]="ESC"
						;;
					*)
						UInput[0]="$(printf "%q" "${escapeSequence}")"
						;;
					esac
					;;
				*)
					ord.eascii UInput[0] "${escapeSequence}"
					UInput[0]="${C0CtrlChars[${UInput[0]}]:-}"
					[ -n "${UInput[0]:-}" ] ||  UInput[0]="$(printf '%q' "'${escapeSequence}")"
					;;
				esac
			fi
	}

	function HandleKey()
	{
		local -a UInput
		if ReadKey ; then
			case "${UInput[0]:-}" in
				up)
					echo UP
					;;
				down)
					echo DOWN
					;;
				CR|LF)
					echo "CR"
					;;
				' ')
					echo "SPACE"
					;;
				*)
					echo "${UInput[0]:-}"
					;;
			esac
		fi
	}

	#HandleKey
	keycode=$(HandleKey)
	#echo $keycode > /dev/shm/${MYUSERNAME}/keycode.txt
	echo $keycode
}

function cd_dir_in_file()
{
	if [ $# -eq 0 ];then
		local enter_dir_file=/dev/shm/${MYUSERNAME}/cd_enter_dirs
	else
		local enter_dir_file="$1"
	fi
	local cnt=$(cat "$enter_dir_file" | wc -l)
	if [ $cnt -eq 1 ];then
	    local enter_dir=$(cat "$enter_dir_file")
	    builtin cd "${enter_dir/\~/${HOME}}"
	    return ;
	fi
	trap 'stty icanon iexten echo echoe echok;printf "%-100s\r" " ";break;' SIGINT SIGHUP SIGTERM
	local  cur_pos=0;
	while read file; do
		local the_dirs[$cur_pos]="$file"
		((cur_pos++))
	done < $enter_dir_file
	cur_pos=0;
	while true;do
		local enter_dir="${the_dirs[cur_pos]}"
		printf '%-100s\r' "Enter: ${enter_dir} ?"
		local key=$(bash_get_keycode | tr -d '\r' | tr -d '\n')
		case "$key" in
			"UP")
				((cur_pos --));
				if [ $cur_pos -lt 0 ];then
					let cur_pos=$cur_pos+$cnt
				fi
				;;
			"DOWN"|"SPACE")
				((cur_pos ++));
				if [ $cur_pos -ge $cnt ];then
					let cur_pos=0
				fi
				;;
			"CR")
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
		esac
	done
	trap - SIGINT SIGHUP SIGTERM
}

function c()
{
	local enter_dir_file=/dev/shm/${MYUSERNAME}/cd_enter_dirs
	mkdir -p /dev/shm/"${MYUSERNAME}"
	: > $enter_dir_file
	if [ $# -eq 0 ];then
		cat -n ${HOME}/bashrc/karlzheng_config/pwd.mk | sed -e '/^\s*[1-9]*\s*#.*/d'
		echo "${HOME}" > "$enter_dir_file"
		cat  ${HOME}/bashrc/karlzheng_config/pwd.mk >> "$enter_dir_file"
	else
		cat -n ${HOME}/bashrc/karlzheng_config/pwd.mk | sed -e 's#^\#.*##g' | grep -i "$*"
		cat  ${HOME}/bashrc/karlzheng_config/pwd.mk | sed -e 's#^\#.*##g' | grep -i "$*" \
		    > "$enter_dir_file"
	fi

	cd_dir_in_file
}

function cd()
{
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
		    local enter_dir_file=/dev/shm/${MYUSERNAME}/cd_enter_dirs
		    mkdir -p /dev/shm/"${MYUSERNAME}"
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
	else
	    builtin cd "$@"
	fi
    fi
fi
}

#function cl()
#{
    #cd $(!!)
#}
#alias cl="cd $(!!)"

function dlb()
{
    local enter_dir_file=/dev/shm/${MYUSERNAME}/cd_enter_dirs
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
	    *)  break ;;
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
    /bin/mv  ${enter_dir_file}.$$.file ${enter_dir_file}
    echo ""

    cd_dir_in_file
}

function pa()
{
	touch ${HOME}/bashrc/karlzheng_config/pwd.mk
	grep -q "^$(pwd)$" ${HOME}/bashrc/karlzheng_config/pwd.mk
	if [ $? != 0 ]; then
		pwd | sed -e "s#${HOME}#~#" >> ${HOME}/bashrc/karlzheng_config/pwd.mk
		awk '!a[$0]++' ${HOME}/bashrc/karlzheng_config/pwd.mk > ${HOME}/bashrc/karlzheng_config/$$.pwd.mk
		#cat $$.pwd.mk | sort > ${HOME}/bashrc/karlzheng_config/pwd.mk
		#rm $$.pwd.mk
		/bin/mv ${HOME}/bashrc/karlzheng_config/$$.pwd.mk ${HOME}/bashrc/karlzheng_config/pwd.mk
	else
		echo "$(pwd) has already in ${HOME}/bashrc/karlzheng_config/pwd.mk"
	fi
}

function ci()
{
    local imgout=out/target/product/
    if [ -d "arch/arm/boot" ];then
	echo "arch/arm/boot"
	cd "arch/arm/boot"
    else
	OLDPWD=$(pwd)
	local SAVE_OLDPWD="$OLDPWD"
	if [ -d "$imgout" ];then
	    cd $imgout
	    local recent_product_dir=$(ls -latr | tail -n 1 |awk '{print $NF}');
	    cd "${recent_product_dir}"
	    echo $imgout/"${recent_product_dir}"
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

function crr()
{
    local is_root_dir=0;

    function is_project_root_dir()
    {
	local ANDROIDENVSETUP=build/core/envsetup.mk;
	local KERNELCONFIGDIR=arch/arm/configs;
	let is_root_dir=0
	if [ -f $ANDROIDENVSETUP ] || \
	   [ -d $KERNELCONFIGDIR ] || \
	   [ "$(pwd)" == "${HOME}" ] || \
	   [ "$(pwd)" == "/" ] || \
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

function cdt()
{
    cd /tmp/t
}
