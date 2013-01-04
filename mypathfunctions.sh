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
#       COMPANY: Meizu
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

function ca()
{
	if [ ! -f ~/pwd.mk ];then
		echo "no ~/pwd.mk file"
		return 1;
	fi
	if [ ! -f /dev/shm/pwd_pos ]; then
		echo "1" > /dev/shm/pwd_pos;
		local  pwd_pos=1;
	else local pwd_pos=$(cat /dev/shm/pwd_pos);
		#if [ ! -f /dev/shm/pwd_total_count ];then
			wc -l ~/pwd.mk |awk '{print $1}' > /dev/shm/pwd_total_count
		#fi
		local total_count=$(cat /dev/shm/pwd_total_count);
		((pwd_pos ++));
		if [ $pwd_pos -gt $total_count ];
		then pwd_pos=$(expr $pwd_pos - $total_count);
		fi
		echo $pwd_pos > /dev/shm/pwd_pos;
	fi
	local enter_dir=$(sed -n "$pwd_pos{p;q;}"  ~/pwd.mk)
	builtin cd "$enter_dir"
}

function cdc()
{
	if [ $# -eq 0 ];then
		if [ -d arch/arm/configs ];then
		    cd arch/arm/configs
		else
		    if [ -d device ];then
			local enter_dir_file=/dev/shm/$(whoami)/cd_enter_dirs
			if [ -d device/meizu/ ];then
			    find device/meizu/ -maxdepth 1 -type d -name "m*" \
			    | sed -n -e '{2,$p}' | tee $enter_dir_file
			else
			    if [ -d device/samsung/ ];then
				find device/samsung/ -maxdepth 1 -type d -name "smdk4*" \
				| tee $enter_dir_file
			    fi
			fi
			cd_dir_in_file
		    fi
		fi
	else
		cd $1
	fi
}

function cds()
{
    if [ "$(whoami)" != "karlzheng" ];then
	pwd > ~/server_path.mk
    else
	local cds_path="${HOME}/$(cat ~/241/server_path.mk | \
	    sed -e "s#/home/\w*/##" | sed -e "s#/disk/##" | tr -d '\r')"
	echo "$cds_path"
	builtin cd "$cds_path"
    fi
}

function cdv()
{
    if [ ! -f /dev/shm/vim_cur_file_path ];
        then echo "no /dev/shm/vim_cur_file_path file";
    else
        local enter_dir="$(cat /dev/shm/vim_cur_file_path)";
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
	#echo $keycode > /dev/shm/keycode.txt
	echo $keycode
}

function cd_dir_in_file()
{
	if [ $# -eq 0 ];then
		local enter_dir_file=/dev/shm/$(whoami)/cd_enter_dirs
	else
		local enter_dir_file="$1"
	fi
	local cnt=$(cat "$enter_dir_file" | wc -l)
	if [ $cnt -eq 1 ];then
		cd $(cat "$enter_dir_file")
		return ;
	fi
	trap 'stty icanon iexten echo echoe echok;printf "%-100s\r" " ";break;' SIGINT SIGHUP SIGTERM
	local  cur_pos=0;
	for file in $(cat $enter_dir_file)
	do
		local the_dirs[$cur_pos]="$file"
		((cur_pos++))
	done
	cur_pos=0;
	while true;do
		local enter_dir=${the_dirs[cur_pos]}
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
				if [ -d "${enter_dir}" ];then
					cd "${enter_dir}"
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
	local enter_dir_file=/dev/shm/$(whoami)/cd_enter_dirs
	mkdir -p /dev/shm/"$(whoami)"
	: > $enter_dir_file
	if [ $# -eq 0 ];then
		cat -n ${HOME}/pwd.mk | sed -e '/^\s*[1-9]*\s*#.*/d'
		cat  ${HOME}/pwd.mk > "$enter_dir_file"
	else
		cat -n ${HOME}/pwd.mk | sed -e 's#^\#.*##g' | grep -i "$*"
		cat  ${HOME}/pwd.mk | sed -e 's#^\#.*##g' | grep -i "$*" \
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
		    local enter_dir_file=/dev/shm/$(whoami)/cd_enter_dirs
		    mkdir -p /dev/shm/"$(whoami)"
		    : > $enter_dir_file
		    for d in $(/bin/ls -la | grep -E "^d|^l" | grep "$1" \
			| awk '{print $8}');
		    do
			if [ -d "$d" ];then
			    echo "$d" >> $enter_dir_file
			fi
		    done
		    local cnt=$(cat "$enter_dir_file" | wc -l)
		    if [ $cnt -gt 0 ];then
			cat -n "$enter_dir_file"
			cd_dir_in_file
		    fi
		else
		    builtin cd "$@"
		fi
	    fi
	fi
}

function dlb_dirs()
{
	local enter_dir_file=/dev/shm/$(whoami)/cd_enter_dirs
	local kfb_samba_dir="/home/karlzheng/kfb"
	root_dirs=(
	"$kfb_samba_dir/DailyBuild/DailyBuildM03X/app/IceCreamSandwich/eng"
	"$kfb_samba_dir/DailyBuild/DailyBuildM03X/app/IceCreamSandwich/user"
	"$kfb_samba_dir/DailyBuild/DailyBuildM03X/app/JellyBean/user"
	"$kfb_samba_dir/DailyBuild/DailyBuildM03X/app/JellyBean/eng"
	"$kfb_samba_dir/DailyBuild/DailyBuildM040/app/IceCreamSandwich/user"
	"$kfb_samba_dir/DailyBuild/DailyBuildM040/app/IceCreamSandwich/eng"
	"$kfb_samba_dir/DailyBuild/DailyBuildM040/app/JellyBean/user"
	"$kfb_samba_dir/DailyBuild/DailyBuildM040/app/JellyBean/eng"
	)

	: > ${enter_dir_file}

	for i in ${root_dirs[*]};
	do
	    if [ -d "$i" ];then
		local recent_dirs=$(echo "$(ls -lt "$i" | awk '{print $8}'\
		    | grep -E -v '^\.' | sed -n '2,3p')" | tac )
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
	touch ${HOME}/pwd.mk
	grep -q "^$(pwd)$" ${HOME}/pwd.mk
	if [ $? != 0 ]; then
		pwd >> ${HOME}/pwd.mk
		awk '!a[$0]++' ${HOME}/pwd.mk > $$.pwd.mk
		#cat $$.pwd.mk | sort > ${HOME}/pwd.mk
		#rm $$.pwd.mk
		/bin/mv $$.pwd.mk ${HOME}/pwd.mk
	else
		echo "$(pwd) has already in ${HOME}/pwd.mk"
	fi
}

function ci()
{
    if [ -d "arch/arm/boot" ];then
	echo "arch/arm/boot"
	cd "arch/arm/boot"
    else
	if [ -d "$imgout" ];then
	    cd $imgout
	    local recent_product_dir=$(ls -latr | tail -n 1 |awk '{print $NF}');
	    cd "${recent_product_dir}"
	    echo $imgout/"${recent_product_dir}"
	fi
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
	if [ -f $ANDROIDENVSETUP ] || [ -d '.repo' ] || [ -d '.git' ] ||\
	    [ -d $KERNELCONFIGDIR ] || ( [ -f .project ] &&\
	    [ -f project.properties ] );then
	    let is_root_dir=1
	fi
	return $is_root_dir;
    }
    if [ -n "$T" ]; then
	echo "auto change to TOP dir: $T"
	cd "$T";
	return 0;
    fi
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
    if [ $is_root_dir == 1 ]; then
	echo "$HERE => $T";
	cd "$T";
    else
	if [ -n $SAVE_OLDPWD ];then
	    OLDPWD=$(echo $SAVE_OLDPWD)
	fi
    fi;
    unset is_project_root_dir
}

