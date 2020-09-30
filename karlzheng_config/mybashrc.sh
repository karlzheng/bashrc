#!/bin/bash
#===============================================================================
#
#		   FILE:  mybashrc.sh
#
#		  USAGE:  put it to your home directory
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

if [ -f ~/skipmybashrc ];then
	return
fi

if [ "${SHELL}" != "/bin/bash" -a "${SHELL}" != "/usr/bin/bash" ];then
		echo 'use "chsh -s /bin/bash" to change ${SHELL}'
fi

export OS=Linux
if [ $(uname -s) == Darwin ];then
	export OS="OSX"
fi

unset MAILCHECK

# . /etc/bash_completion
shopt -s dotglob
shopt -s histappend
shopt -s histreedit
shopt -s histverify
shopt -s lithist

set completion-ignore-case on
set expand-tild on
set match-hidden-files off

export GTAGSFORCECPP=
export LC_MESSAGES="C"

export MINICOM=" -C /tmp/minicom.log "

export MYNICKNAME="karlzheng"
export MYUSERNAME=$(whoami)

#export ANDROID_LOG_TAGS='Sensors:V *:S'
#export ARCH=arm
#http://huangyun.wikispaces.com/%E7%BB%99man+pages%E5%8A%A0%E4%B8%8A%E5%BD%A9%E8%89%B2%E6%98%BE%E7%A4%BA
export BROWSER="$PAGER"
#export CROSS_COMPILE=arm-linux-gnueabi-
export D=~/桌面/
export EDITOR=vim
export GRADLE_HOME=${HOME}/bk/sw/gradle-1.6
#命令文件最大行数
export HISTSIZE=5000000
#最大命令历史记录数
export HISTCONTROL="erasedups:ignoreboth"
export HISTFILESIZE=5000000
export HISTIGNORE="c:h:history:ha:hd:he:hi:la:ls:sb"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./:
export LESS_TERMCAP_mb=$'\E[01;34m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;33m'
export NODE_PATH=/usr/lib/nodejs:/usr/lib/node_modules:/usr/share/javascript:/usr/local/lib:
export PAGER="`which less` -s"
#export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
#export PROMPT_COMMAND="history -a;history -n;$PROMPT_COMMAND"
#export PROMPT_COMMAND="history -a"
export PS4='+[$LINENO]'
export SVN_EDITOR=/usr/bin/vim

#add other info here just for android
#export ANDROID_PRODUCT_OUT=out/target/product/
#export ANDROID_SWT=/home/${MYUSERNAME}/svn/app_group_android/Eclair/out/host/linux-x86/framework
#export ANDROID_SWT=/media/cdriver/work/software/android-sdk-linux_86/tools/lib/x86/
#export TARGET_BUILD_TYPE=debug

case $- in
	*i*)
		stty -ixon
		bind -m emacs '"\en": history-search-forward'
		bind -m emacs '"\ep": history-search-backward'
		bind -m emacs '"\ew": backward-kill-word'
		bind -m emacs '"\e/": menu-complete'
		bind -m emacs '"\C-ga": "grep \"\" * --color -rHniI|grep -v ^tags|grep -v ^cscopef"'
		#bind -m emacs '"\C-gc": "grep \"\" * --color -rHnIf"'
		bind -m emacs '"\C-gc": "$(!!)"'
		bind -m emacs '"\C-ge": "$()"'
		bind -m emacs '"\C-gf": "$(fa)"'
		bind -m emacs '"\C-gg": "$(fb)"'
		bind -m emacs '"\C-gh": "--help"'
		bind -m emacs '"\C-gm": "grep mei Makefile"'
		bind -m emacs '"\C-gn": " 2>&1 > /dev/null"'
		bind -m emacs '"\C-gr": "$(lf)"'
		bind -m emacs '"\C-gt": " 2>&1 3>&1 |tee ~/tmp/tee.log "'
		bind -m emacs '"\C-gv": "--version"'
		bind -m emacs '"\C-gz": " arch/arm/boot/zImage"'

		bind -m emacs '"\C-g\C-a": "mgrep.sh "'
		bind -m emacs '"\C-g\C-b": "grep \"\" * --color -rHnIC2f"'
		bind -m emacs '"\C-g\C-f": "bcompare \"$(fa)\" \"$(fb)\" &"'
		bind -m emacs '"\C-g\C-h": "--hard"'
		bind -m emacs '"\C-g\C-n": "find -name "'
		bind -m emacs '"\C-g\C-[": " $()OD"'
		#bind -m emacs '"\C-]": character-search-backward'
		#bind -m emacs '"\e\C-]": character-search'
		#bind -m emacs '"\C-i": menu-complete'
		bind -m emacs '"\C-o": menu-complete'
		;;
	*) ;;
esac

#unalias ls
alias|grep -q 'la='
if [ $? == 0 ]; then
	unalias la;
fi
if [ ${OS} == "OSX" ];then
	alias ls='ls -G -a '
else
	alias ls='ls --color=tty -a '
fi
alias LS='ls'
#alias adb_="sudo adb kill-server && sudo adb start-server"
alias CD='cd'
alias cdance_rsync="rsync -avurP ${HOME}/rjb/BSP/BSP_PRIVATE/ /media/sdb9/work/BSP_PRIVATE/"
alias cdg='cd /media/work/kernel/meizu/git/mx/linux-2.6.35-mx-rtm'
alias ck="cd /media/cdriver/work/kernel/meizu/"
alias co="cd -"
alias copy_to_m8="rsync -av /media/x/english/voa/ /media/Meizu\ M8/Music/voa/"
#alias cp='cp -i '
alias cw="cd /media/work/"
alias git_vim_diff="git diff --no-ext-diff -w |vim -R -"
#alias grep='grep --exclude-dir=.svn --exclude="*.o" --exclude="*.o.cmd" '
alias j='jobs '
alias killgtags="ps |grep global|awk '{print \$1}'|xargs kill -9;ps |grep gtags|awk '{print \$1}'|xargs kill -9"
alias LA='ls -latr'
#alias la='ls -latr'
alias l='ls -CF '
alias lm='ls arch/arm/configs/m*'
#alias lr='ls -latr'
alias lsr='ls -lasr '
alias lsr='ls -lasr '
alias lt='ls -lat '
alias ltr='ls -latr '
#alias mt3='mount -t ext3 '
#alias mtnfs=' mount -t nfs '
#alias mto='mount -o loop '
alias mv='mv -i '
alias mz='make zImage -j32 '
alias MZ='mz'
alias po='popd'
alias pp="cat -n ${HOME}/dev/${MYUSERNAME}/daily_path"
alias sb='source ~/bashrc/karlzheng_config/mybashrc.sh'
alias slog='svn log | tac '
alias smbmount242_home='sudo smbmount //172.16.10.242/home/ /media/242/ -o iocharset=utf8,username=${MYUSERNAME},dir_mode=0777,file_mode=0777'
alias smbmount242='mount |grep -q 242; if [ $? = 0 ];then sudo umount /media/x;fi;sudo smbmount //172.16.10.242/home/svn /media/x/ -o iocharset=utf8,dir_mode=0777,file_mode=0777,username=${MYUSERNAME}'
alias svnaw="svn diff --diff-cmd=diff | grep ^Index | awk '{printf \$2 \" \"}END{print \" \"}'"
alias svnaw_touch="svn diff --diff-cmd=diff | grep ^Index | awk '{printf \$2 \" \"}END{print \" \"}' |xargs touch"
alias VI='vi'
alias um="umount "
alias wg="wget"

#alias mydate="echo $(date +%Y%m%d_%T)"
#alias svnawtar="date_str=$(date +%Y%m%d_%T) && tmp_file_name=svn_diff_$date_str && svnaw |xargs \
#tar --force-local -rvf \$tmp_file_name.tar && echo \$tmp_file_name && unset \
#tac ~/.bash_history |awk '!a[$0]++' |tac > /tmp/.bash_history &&  mv /tmp/.bash_history ~/.bash_history -f
function a()
{
	ack-grep -H --nogroup "$@"
}

function aa()
{
	ack-grep -H -a --nogroup "$@"
}

function ak()
{
	#http://www.techug.com/ten-tips-for-wonderful-bash-productivity
	awk -v col=$1 '{print $col}'
}

function a-s()
{
	apt-cache search "$@"
}

function adblistpackages()
{
	adb shell pm list packages -f "$@"
}

function alert()
{
	if [ "x${OS}" == "xOSX" ];then
		local message="$@"
		osascript<<-EOF
		tell application "Finder"
			activate
			display Dialog "$message"
		end tell
		EOF
	else
		notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)"
		#"$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"
	fi
}

function androidsetrootpath()
{
	export ANDROID_SRC_ROOT="$(pwd)"
}

function atar()
{
		#http://www.ibm.com/developerworks/cn/aix/library/au-spunixpower.html?ca=drs-#history
		  if [ -f $1 ] ; then
				case $1 in
				  *.tar.bz2)   tar xjf $1	  ;;
				  *.tar.gz)	   tar xzf $1	  ;;
				  *.bz2)	   bunzip2 $1	  ;;
				  *.rar)	   rar x $1		  ;;
				  *.gz)		   gunzip $1	  ;;
				  *.tar)	   tar xf $1	  ;;
				  *.tbz2)	   tar xjf $1	  ;;
				  *.tgz)	   tar xzf $1	  ;;
				  *.zip)	   unzip $1		  ;;
				  *.Z)		   uncompress $1  ;;
				  *.7z)		   7z x $1		  ;;
				  *)		   echo "'$1' cannot be extracted via extract()" ;;
				esac
		  else
				echo "'$1' is not a valid file"
		  fi
}

function append_daily_path()
{
		local path_list=(
		~/person_tools/
		);
		[ -f ${HOME}/dev/${MYUSERNAME}/daily_path ] || touch ${HOME}/dev/${MYUSERNAME}/daily_path
		for p in ${path_list[@]}; do
			if [ -d ${p} ];then
				grep -q "^$p$"	${HOME}/dev/${MYUSERNAME}/daily_path
				if [ $? != 0 ]; then
					echo "$p" >> ${HOME}/dev/${MYUSERNAME}/daily_path;
				fi
			fi
		done
		wc -l ${HOME}/dev/${MYUSERNAME}/daily_path |awk '{print $1}' > ${HOME}/dev/${MYUSERNAME}/total_count
}

function attachjlink()
{
	local jlinkuuid=$(VBoxManage list usbhost -l|grep J-Link -B 8|grep UUID|awk '{print $2}')
	VBoxManage controlvm win7 usbattach ${jlinkuuid}
}

function addversion()
{
	if [ -e $VERSIONFILE ];then
		local v=$(verincrease.sh $VERSIONFILE);
		echo $v > $VERSIONFILE;
		git diff $VERSIONFILE
		read -p "commit $1? y|n" c
		if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
			git add $VERSIONFILE
			git commit  -m "bump up version to $(cat $VERSIONFILE)"
			git push
		else
			git checkout $VERSIONFILE
		fi
	fi
}

function ba()
{
	local fn=${HOME}/dev/bcFn1
	if [ $# -eq 1 ];then
		: > ${fn}
		echo "$(pwd)/$1" > ${fn}
	fi
}

function bcompare()
{
	if [ "x${OS}" == "xOSX" ];then
		#open -W -a /Applications/Beyond\ Compare.app/ "$@"
		bcomp "$@"
	fi
}

function bcp()
{
	/bin/cp "$@"
}

function brm()
{
	echo "Are you really want to remove $@ ?"
	read -p "y|n" c
	if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
		# set field seperator for bash
		local IFS=$'\n'
		echo "/bin/rm -rf $@"
		while [ "x$1" != x ];do
			if [ -f "$1" -o -d "$1" ];then
				local d=${1%/}
				/bin/mv $d $d.dir.tmp
				/bin/rm -rf $d.dir.tmp &
			fi
			shift
		done
	else
		echo "Removing $@ cancled !!"
	fi
}

function cl()
{
	if [ -e ~/tmp/bash_history ];then
		cat ~/tmp/bash_history "$@"
	fi
}

function ctrash()
{
	#/bin/rm -rf ~/.trash;
	#mkdir ~/.trash;
	mkdir -p /tmp/.trash/;
	#rsync --delete-before -avH --progress --stats /tmp/.trash/ ${HOME}/.trash
	rsync  --delete -rlptD /tmp/.trash/ ${HOME}/.trash/
	sync;
}

function cp()
{
	echo "Are you really want to cp -a $@ ?"
	read -p "y|n" c
	if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
		echo "cp -a $@"
		/bin/cp -a $@
	else
		echo "Cancle cp -a $@"
	fi
}

function cx()
{
	echo "Are you really want to chmod u+x $@ ?"
	read -p "y|n" c
	if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
		echo "chmod u+x $@"
		chmod u+x "$@"
	else
		echo "Cancle chmod u+x $@"
	fi
}

function del_carried_return()
{
		find -name "*.h" -o -name "*.c" |xargs sed -i -e "s#\r\n#\n#gc"
}

function emulator_env()
{
	export PATH=$(pwd)/out/host/linux-x86/bin:$PATH
	export ANDROID_PRODUCT_OUT=$(pwd)/out/target/product/generic
	export ANDROID_SWT=$(pwd)/out/host/linux-x86/framework
}

function lstrash()
{
		ls -l ~/.trash/ ;
}

function undel()
{
		mv ~/.trash/"$*" . ;
}

function d()
{
	if [ -d ~/Desktop ];then
		cd ~/Desktop/
	else
		cd ~/桌面/
	fi
}

function detachjlink()
{
	local jlinkuuid=$(VBoxManage list usbhost -l|grep J-Link -B 8|grep UUID|awk '{print $2}')
	VBoxManage controlvm win7 usbdetach ${jlinkuuid}
}

function dnw()
{
	local dnwpro=$(which dnw)
	if [ $? != 0 ];then
		echo "last command is okay! exit!!"
		return 1
	fi
	if [ $# -ge 1 ];then
		local START_TIME=`date +%s`
		local filename="$(echo ${1/11111/})"
		${dnwpro} "$filename"
		local END_TIME=`date +%s`
		local ELAPSED_TIME
		let "ELAPSED_TIME=$END_TIME-$START_TIME"
		echo
		echo "Total used time is $ELAPSED_TIME seconds"
		echo
	fi
	return 0
}

function dockerrma
{
	read -p " docker rm $(docker ps -a -q) y|n ?" c
	if [ "x${c}" == "xy" -o "x${c}" == "x" ];then
		docker rm $(docker ps -a -q)
	fi
}

function dud()
{
	local IFS=$'\n'
	: > ${HOME}/dev/dud.tmp.log
	for i in $(lsd);do
		du -sh "$i" >> ${HOME}/dev/dud.tmp.log
	done
	cat ${HOME}/dev/dud.tmp.log | sort -h
}

function diff()
{
	/usr/bin/diff -x '.svn' "$@"
}

function dl()
{
	if [ -d ~/Downloads/ ];then
		cd ~/Downloads/
	else
		cd ~/下载/
	fi
}

function ds()
{
	if [ -f ${HOME}/tmp/scratch ];then
		local vars=$(cat ${HOME}/tmp/scratch|head -n 1|tr -d "\r"|tr -d "\n")
		echo $vars
	fi
}

function dsh()
{
	du -sh
}

function dt()
{
	date +%Y%m%d
}

function dt-()
{
	date +%Y-%m-%d
}

function dtt()
{
	date +%Y%m%d%H%M%S
}

function e()
{
	echo "$@"
}

function ea()
{
	if [ $# -lt 1 ];then
		echo "export ARCH=arm"
		#export ARCH=mips
		export ARCH=arm
	else
		echo export ARCH=$1
		export ARCH=$1
	fi
}

function ep()
{
	if [ $# -ge 1 ];then
		echo 'Origin PATH:'
		echo "${PATH}"
		echo 'set: export PATH= ${PATH}'
		export PATH="$@":${PATH}:
	fi
	echo 'export PATH= ${PATH} :'
	echo "${PATH}"
}

function et()
{
	local f=${HOME}/tmp/tee.log
	echo ""
	cat ${f}
	echo ""
	read -p "exec ${f} y|n ?" c
	if [ "x${c}" == "xy" -o "x${c}" == "x" ];then
		source ${f}
	fi
}

function ey()
{
	local c
	if [ -f ${HOME}/dev/$(whoami)/yank.txt ];then
		echo "${HOME}/dev/$(whoami)/yank.txt :"
		cat ${HOME}/dev/$(whoami)/yank.txt
		read -p "exec y|n ?" c
		if [ "x${c}" == "xy" -o "x${c}" == "x" ];then
			source ${HOME}/dev/$(whoami)/yank.txt
			history -s "$(cat ${HOME}/dev/$(whoami)/yank.txt | head -n 1)"
		fi
	else
		echo "No ${HOME}/dev/$(whoami)/yank.txt"
	fi
}

function f()
{
	find . -iname "$*"
}

function fa()
{
	if [ -f ${HOME}/dev/$(whoami)/absfa ];
		then cat ${HOME}/dev/$(whoami)/absfa
	fi
}

function fb()
{
	if [ -f ${HOME}/dev/$(whoami)/absfb ];
		then cat ${HOME}/dev/$(whoami)/absfb
	fi
}

function fcheckpatch()
{
	checkpatch.pl --no-tree -f "$@"
}

function fo()
{
	local f
	for f in $(cat $1);do
		$2 $f
	done
}

function clformat()
{
	find . -regex '.*\.\(cpp\|hpp\|cu\|c\|h\)' -exec clang-format -i {} \;
}

function fm80()
{
	astyle --style=kr --max-code-length=80 "$@"
}

function g()
{
	grep "$@"
}

function ga()
{
	local f="$1"
	if [ $# -eq 1 ];then
		if [ ${1:0:2} == 'a/' ];then
			f=$(echo "${1:2}")
		else
			if [ ${1:0:2} == 'b/' ];then
				f=$(echo "${1:2}")
			fi
		fi
		if [ -e ${f} ];then
			git add ${f}
		fi
	else
		git add "$@"
	fi
}

function gaa()
{
	git add -A "$@"
}

function gac()
{
	git add -A "$@"
	read -p "Are you sure add all git modified y|n ?" c
	if [ "x${c}" == "xy" -o "x${c}" == "x" ];then
		local fn=~/tmp/gitcommit.msg.txt
		git add -A
		LC_ALL=C git status -u | grep -E "modified|new file:"|sed 's/^\s//' > ${fn}
		git commit -s -F ${fn}
	fi
}

function gacp()
{
	git add -A "$@"
	read -p "Are you sure add all modified and PUSH y|n ?" c
	if [ "x${c}" == "xy" -o "x${c}" == "x" ];then
		local fn=~/tmp/gitcommit.msg.txt
		git add -A
		LC_ALL=C git status -u | grep -E "modified|new file:"|sed 's/^\s//' > ${fn}
		git commit -s -F ${fn}
		git push
	fi
}

function gau()
{
	git add -u "$@"
}

function gb()
{
	git branch "$@"
}

function gba()
{
	if [ -d .repo/manifests/.git ];then
		git --git-dir=.repo/manifests/.git branch -a "$@"
	else
		git branch -a "$@"
	fi
}

function gbi()
{
	readEnsureKey "gitbook init . $@"
    [ $? == 0 ] || return
	gitbook init . "$@"
}

function gbs()
{
	readEnsureKey "gitbook serve $@"
    [ $? == 0 ] || return
	gitbook serve "$@"
}

function gc()
{
	local isRepo=0
	if [ -f .repo/manifests.git/config ];then
		let isRepo=1
		echo '.repo/manifests.git/config'
		cat .repo/manifests.git/config
	fi
	if [ -f .git/config ];then
		let isRepo=1
		echo config: .git/config
		cat .git/config
	fi
	if [ ${isRepo} == 0 ];then
		echo "Seems not in a git repository dir !"
	fi
}

function gci()
{
	git commit -s "$@"
}

function gcl()
{
	git clone "$@"
}

function gd()
{
	git diff "$@"
}

function gda()
{
	if [ $# -eq 0 ];then
		git diff HEAD^ HEAD
	else
		if [ $# -eq 1 ];then
			git diff $1^ $1
		else
			git diff "$@"
		fi
	fi
}

function gdp()
{
	git diff -p -U100000 --raw "$@"
}

function genmarkdownlink()
{
	for f in $(/bin/ls);do
		local fn=${f%%\.*}
		echo [${fn}]\(${f}\)
	done
}

function gi()
{
	grep -i "$@"
}

function ginit()
{
	read -p "init git repo dir y|n ?" c
	if [ "x${c}" == "xy" -o "x${c}" == "x" ];then
		git init .
		git add -A
		git commit -s -m "init."
	fi
}

function gk()
{
	if [ $# -ge 1 ];then
		gitk "$@" &
	else
		gitk . &
	fi
}

function gka()
{
	if [ $# -ge 1 ];then
		gitk --all "$@" &
	else
		gitk --all . &
	fi
}

function gkd()
{
	if [ $# -ge 1 ];then
		gitk "$@" &
	else
		gitk $(ds) &
	fi
}

function gkf()
{
	if [ $# -ge 1 ];then
		gitk "$@" &
	else
		gitk $(fa) &
	fi
}

function glag()
{
	git log --all --graph "$@"
}

function gt()
{
	if [ -f /tmp/file.tar ];then
		tar tf /tmp/file.tar
		read -p "Decompressed ?" choose
		tar xf /tmp/file.tar
	else
		echo "no /tmp/file.tar"
	fi
}

function gitcobranch()
{
		if [ $# -eq 1 ];then
				git checkout -b "$1" origin/"$1"
		fi
}

function git_diff()
{
	git diff --no-ext-diff -w "$@" | vim -R -
}

function gitignore.kernel()
{
	if [ -f .gitignore ];then
		echo "exist .gitignore! exit!"
	else
		if [ -f ${HOME}/local_git/tips/git/kernel.gitignore ];then
			echo cp ${HOME}/local_git/tips/git/kernel.gitignore ./.gitignore
			cp ${HOME}/local_git/tips/git/kernel.gitignore ./.gitignore
		fi
	fi
}

function gitloghead()
{
		local tmpfile="gitloghead.log"
		if [ $# -ge 1 ];then
				if [ -f $tmpfile ];then
						mv $tmpfile $tmpfile.old -f
				fi
				startaddress=$(echo ${1##git.log:})
				startaddress=$(echo ${startaddress%%:})
				local startaddress=$(($startaddress-200))
				if [ $startaddress -lt 0 ];then
						startaddress=0
				fi;
				if [ $# -ge 2 ];then
						local stopaddress=$2
				else
						local stopaddress=$(($startaddress+400))
				fi
				echo "$startaddress,${stopaddress}p"
				sed -n "$startaddress,${stopaddress}p" git.log > $tmpfile
				vi $tmpfile
		fi
}

function gitsvnco()
{
		if [ $# == 0 ]; then
				echo "Must deposit which svn dir you want to check out!!"
				exit 1;
		fi
		git svn init "$1" --no-metadata
		git svn fetch
}

function gitsvncl()
{
		if [ $# == 0 ]; then
				echo "Must deposit which svn dir you want to check out!!"
				exit 1;
		fi
		git svn clone "$1"
}

function gitsvnup()
{
		echo "git svn fetch"
		git svn fetch
		while [ $? != 0 ]; do
				echo "git svn fetch result:$?"
				sleep 0.5
				git svn fetch
		done
		echo "git svn fetch okay. result:$?"
		git rebase --onto git-svn --root
}

function gitdiffmodified()
{
	pid=$$
	git diff -U1000000 > /tmp/tmp.${pid}.patch
	patch2dir.sh /tmp/tmp.${pid}.patch
	bcompare . /tmp/a &
}

function gittar()
{
		# http://blog.csdn.net/free2o/archive/2009/03/11/3981786.aspx
	local name=$(pwd)
	name=${name##*/}

	if [ ! "$1" ]; then
		echo "[ERROR] what branch to export?"
		return 1
	fi

	local date=$(TZ=UTC date '+%Y%m%d.%H%M')
	local pkg="$name-$date"
	local dir=".."
	local tar="$dir/$pkg.tar.gz"

	git archive \
		--format=tar \
		--prefix="$pkg/" \
		"$@" |
	gzip --best > "$tar"

	echo $tar
}

function gbr()
{
	git br "$@"
}

function gl()
{
	git log "$@"
}

function glg()
{
	git log "$@" > git.log
}

function gp()
{
	local c
	read -p "git pull current dir y|n ?" c
	if [ "x${c}" == "xy" -o "x${c}" == "x" ];then
		git pull
	fi
}

function gpa()
{
	local cbr=$(git rev-parse --abbrev-ref HEAD)
	local c

	read -p "git pull all branches in current dir y|n ?" c
	if [ "x${c}" == "xy" -o "x${c}" == "x" ];then
		#git pull --all
		for br in `git branch -r|grep -v HEAD | sed "s/.*\///g"`;do
			echo ${br};
			git checkout ${br};
			git pull;
		done
		git checkout ${cbr}
	fi
}

function gpc()
{
	if [ -n $OLDPWD ];then
		local SAVE_OLDPWD="$OLDPWD"
	fi
	if [ -d ~/bashrc ];then
		pushd ~/bashrc
		git pull
		popd
	fi
	if [ -d ~/vimrc ];then
		#git --git-dir ~/vimrc pull
		pushd ~/vimrc
		git pull
		popd
	fi
	if [ -n $SAVE_OLDPWD ];then
		OLDPWD=$(echo $SAVE_OLDPWD)
	fi
}

function gpra()
{
	local c
	read -p "git pull all remote branches in current dir y|n ?" c
	if [ "x${c}" == "xy" -o "x${c}" == "x" ];then
		git pull --all
		git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
		git fetch --all
		git pull --all
	fi
}

function gps()
{
	if [ -d .git ];then
		local c
		read -p "git push y|n ?" c
		if [ "x${c}" == "xy" -o "x${c}" == "x" ];then
			git push "$@"
		fi
	fi
}

function gsu()
{
	LC_ALL=C git status -u "$@"
}

function gw()
{
	type gradlew
	if [ $? == 0 ];then
		export PATH="/Applications/Android Studio.app/Contents/plugins/android/lib/templates/gradle/wrapper":$PATH:
	fi
	gradlew "$@"
}

function h()
{
	history "$@"
}

function h1()
{
	head -n 1 "$@"
}

function h2()
{
	head -n 2 "$@"
}

function ha()
{
	local ignore_cmd_list=(c h history ha hd he hi la ls sb)
	n=0
	history 10 |sort -r > ${HOME}/dev/${MYUSERNAME}/hist10.txt
	while read line;
	do
		local cmd_line=$(echo "$line" |sed -e "s/\s*[0-9]*\s*\(.*\)/\1/")
		local is_ignore_cmd=0
		for cmd in ${ignore_cmd_list[@]};
		do
			if [ x"$cmd_line" == x"$cmd" ]; then
				is_ignore_cmd=1
			fi
		done
		if [ $is_ignore_cmd == 0 ];then
			echo "$cmd_line" > ${HOME}/dev/${MYUSERNAME}/hist_cmd.txt
			echo "$cmd_line"
			return 0
		fi
	done  < ${HOME}/dev/${MYUSERNAME}/hist10.txt
}

function hd()
{
	cat	 ${HOME}/dev/${MYUSERNAME}/hist_cmd.txt
}

function he()
{
	local cmd_line=$(tail -1 ${HOME}/dev/${MYUSERNAME}/hist_cmd.txt|tr -d "\r"|tr -d "\n")
	echo "$cmd_line"
	history -s "$cmd_line"
	#exec "$cmd_line"
	eval "$cmd_line"
}

function hex2bin()
{
	arm-none-eabi-objcopy -Obinary $1 $2
}

function hi()
{
	if [ $# -eq 0 ];then
		history | tail -n 40
	else
		history "$@"
	fi
}

function hn()
{
	history -n "$@"
}

function hp()
{
	local file_list=(~/person_tools/headneck.jpg ~/person_tools/programmer.png)
	local f;
	for f in ${file_list[@]}; do
		if [ -f "${f}" ];then
			if [ "x${OS}" == "xOSX" ];then
				open "${f}" &
			else
				eog -f "${f}" && disown &
			fi
		fi
	done
}

function ht()
{
	history | tail -n 10
}

function ic()
{
	ifconfig "$@"
}

function javadebug()
{
	 if [ $# -eq 1 ];then
		 java -agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=9999 -server -jar $1
	 else
		 if [ $# -eq 2 ];then
			 java -agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=$2 -server -jar $1
		 fi
	 fi
 }

function k()
{
	read -p "Are you sure want to kill all jobs? y|n" c
	if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
		while true;do
			local jc=$(jobs|wc -l)
			echo $jc
			if [[ ${jc} != 0 ]];then
				for i in $(jobs | awk '{print $1}' | sed -e 's#\[\(.*\)\].*#\1#'); do
					echo "kill -9 %$i"
					kill -9 %$i
				done
				sleep 0.5
			else
				break
			fi
		done
	fi
}

function ksvn()
{
		if [ $# -lt 1 ];then
				if [ -d .svn ];then
						#local svnurl=$(svn info | grep URL | awk '{print $2}')
						local svnurl=$(svn info | grep URL)
						svnurl=$(echo ${svnurl##URL: })
						kdesvn "$svnurl" &
				fi
		else
				kdesvn "$@" &
		fi
}

function la()
{
	ls -latr "$@"
}

function lac()
{
	 if [ $# -eq 0 ];then
				 echo "arch/arm/configs"
				 ls arch/arm/configs
	 else
	   ls $1
	 fi
	 return 0
}

function lf()
{
	/bin/ls -t|head -n 1
}

function lh()
{
	ls -latrh "$@"
}

function LL()
{
	ls -latr "$@"
}

function ll()
{
	ls -latr "$@"
}

function lr()
{
	ls -R "$@"
}

function lsd()
{
	#/bin/ls -la | grep -E "^d|^l" | awk '{print $NF}'
	#ls -l | awk '/^d/{print $NF}'
	local IFS=":"
	ls -d */
}

function lsdu()
{
	ls -d */ | xargs du -sh
}

function lz()
{
	ls -laSrh "$@"
}

function l4()
{
	ls -R|tail -n 46
}

function m()
{
	mount "$@"
	return 0
}

function mc()
{
	local cpu_nr=$(/bin/grep processor /proc/cpuinfo \
		| /usr/bin/awk '{field=$NF};END{print(field+1)*2}')

	if [ $# -eq 0 ];then
		make menuconfig -j$cpu_nr
	else
		make $1 -j$cpu_nr
	fi
	return 0
}

function mcd ()
{
  mkdir -p "$@" && eval cd "\"\$$#\"";
}

function mcdt()
{
	local dt=$(date +%Y%m%d)
	mkdir -p ${dt}
	cd ${dt}
}

function mct()
{
	mkdir -p tmp
	cd tmp
}

function md()
{
	mkdir -p "$@"
}

function mdt()
{
	mkdir $(date +%Y%m%d)
}

function meld()
{
	#https://www.alexkras.com/how-to-run-meld-on-mac-os-x-yosemite-without-homebrew-macports-or-think/
	#https://gist.github.com/polbins/42a39cb3234e3acfba79
	#http://brian.pontarelli.com/2013/10/25/using-idea-for-git-merging-and-diffing/
	if [ "x${OS}" == "xOSX" ];then
		open -W -a /Applications/Meld.app --args "$@"
	fi
}

function mj()
{
	local CPUS=$(/bin/grep processor /proc/cpuinfo \
		| /usr/bin/awk '{field=$NF};END{print(field+1)*2}')
    make -j${CPUS} "$@"
}

function dp2ssf()
{
	sshfs -C -o reconnect `whoami`@dp2:/home/karlzheng ${HOME}/dp2 "$@"
}

function mypath()
{
		local i=0
		while read line
		do
				echo $line
				eval "p$i=$line"
				#echo "${m[$i]}"
				((i++))
		done < ${HOME}/dev/${MYUSERNAME}/daily_path
}

function myvimpath()
{
	export PATH=~/software/bin/bin:${PATH}:
}

function n()
{
	if [ "x${OS}" == "xOSX" ];then
		if [ $# -eq 0 ];then
				open . &
		else
			if [ ! -e "$@" ];then
				touch "$@"
			fi
			open $@ &
		fi
	else
		if [ $# -eq 0 ];then
				nautilus . &
		else
				nautilus $1 &
		fi
		sleep 0.2
		type xdotool
		if [ $? == 0 ];then
			xdotool windowactivate $(xdotool search --class nautilus | tail -n 1)
		fi
	fi
	return 0
}

function nl()
{
	if [ "x${OS}" == "xOSX" ];then
		sudo lsof -P -n -iTCP -sTCP:LISTEN "$@"
	else
		sudo netstat -ntlp "$@"
	fi
}

function nq()
{
	read -p "Are you sure quit all nautilus? y|n" c
	if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
		nautilus -q
	fi
}

function ns()
{
	n SUMMARY.md
}

function of()
{
	open $(fa) "$@"
}

function openwrtssh()
{
	echo 'enablec06ebd87'|nc -u 192.168.232.1 51232
}

function pf()
{
	ps -ef "$@"
}

function privoxy_proxy()
{
	if [ OS=="OSX" ];then
		http_proxy="http://127.0.0.1:8118"
		export http_proxy
		https_proxy="http://127.0.0.1:8118"
		export https_proxy
	fi
}

function pu()
{
	if [ $# -ge 1 ];then
		pushd "$@"
	else
		pushd .
	fi
}

function py()
{
	python "$@"
}

function py3()
{
	python3 "$@"
}

function racp()
{
	rsync -avP "$@"
}

function rbrances()
{
	if [ -d .repo/manifests.git ];then
		git --git-dir .repo/manifests/.git/ branch -a
	fi
}

function rcp()
{
	rsync -rvlP "$@"
}

function release_memory()
{
	sudo su -c "echo 3 > /proc/sys/vm/drop_caches"
}

#function repo()
#{
	#if [ "x$0" != "x-bash" ];then
		#echo $(basename "$0") $LINENO
	#else
		#echo "in bash config $LINENO"
	#fi
	#echo "$@" > ${HOME}/dev/${MYUSERNAME}/repo_cmd_line
	#grep -qP "meizu" ${HOME}/dev/${MYUSERNAME}/repo_cmd_line
	#if [ $? == 0 ];then
		#mz_repo "$@"
	#else
		#grep -qP "alibaba|yunos-inc|kangliang.zkl" ${HOME}/dev/${MYUSERNAME}/repo_cmd_line
		#if [ $? == 0 ];then
			#ali_repo "$@"
		#else
			#google_repo "$@"
		#fi
	#fi
#}

function rurl()
{
	if [ -f .repo/manifests.git/config ];then
		cat .repo/manifests.git/config
	fi
}

function rm()
{
	# set field seperator for bash
	local IFS=$'\n'
	[ -d ${HOME}/.trash ] || mkdir ${HOME}/.trash
	while [ "x$1" != x ];do
		if [ -f "$1" -o -d "$1" ];then
			local bn=$(basename "$1")
			[ -e ${HOME}/.trash/${bn}.old ] && /bin/rm -rf ${HOME}/.trash/${bn}.old
			[ -e "${HOME}/.trash/${bn}" ] && /bin/mv -f ${HOME}/.trash/${bn} ${HOME}/.trash/${bn}.old
			/bin/mv $1 ~/.trash/
		fi
		shift
	done
}

function rm.modifiedfiles.space()
{
	for f in $(git diff --stat|grep '|' | awk '{print $1}');do
		[ -f ${f} ] && sed -i 's/[ \t]*$//g' ${f}
	done
}

function rm.tail.space()
{
	sed -i 's/[ \t]*$//g' "$@"
}

function rplstr()
{
	local a
	local b
	local len
	local f="${HOME}/tmp/tee.log"

	read -p "Are you sure want to replace strings designated in file ${f} y|n ?" c
	if [ "x${c}" != "xy" -a "x${c}" != "x" ];then
		echo "Cancel rplstr"
		return
	fi

	while read -ra sz; do
		a=${sz[0]}
		len=${#sz[@]}
		if [ ${len} == 2 ];then
			b=${sz[1]}
		else
			if [ ${len} == 1 ];then
				if [ "x${TO_CAPS}" == "x1" ];then
					b=$(echo ${a} | tr 'a-z' 'A-Z')
				else
					b=$(echo ${a} | tr 'A-Z' 'a-z')
				fi
			fi
		fi
		echo find . -regex '.*\.\(c\|h\|cpp\|cxx\)' '|' xargs sed -i "s/${a}/${b}/g"
		find . -regex '.*\.\(c\|h\|cpp\|cxx\)' | xargs sed -i "s/${a}/${b}/g"
	done < ${f}
}

function rs()
{
	if [ -d .repo ];then
		repo status "$@"
	fi
}

function rswp()
{
	read -p "Are you sure want to 'find . -name "*.swp"|xargs -I {} echo {} |xargs rm'" c
	if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
		find . -name "*.swp"|xargs -I {} echo {} |xargs rm
	fi
}

function runjupyter.sh()
{
	local bin_dir="/Users/karlzheng/Library/Python/2.7/bin"
	if [[ -d ${bin_dir} ]];then
		export PATH=${PATH}:${bin_dir}
		LANG=zn LANGUAGE=zn jupyter notebook
	fi
}


function s()
{
	LC_ALL=C ssh "$@"
}

function sa()
{
	LC_ALL=C ssh x1 "$@"
}

function sx()
{
	ssh -X "$@"
}

function sai()
{
	read -p "sudo apt-get install -y "$@" y|n" c
	if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
		sudo apt-get install -y "$@"
	fi
}

function sbl()
{
	#save bash log
	if [ -e ~/tmp/bash_history ];then
		/bin/cp ~/tmp/bash_history ~/tmp/bash_history.bak
	fi
	#history >> ~/tmp/bash_history
	history |sed -n -e 's#^\s[0-9]\+  ##p' >> ~/tmp/bash_history
	cat ~/.bash_history >> ~/tmp/bash_history
	sort ~/tmp/bash_history > /tmp/bash_history
	cat /tmp/bash_history | awk '!a[$0]++' > ~/tmp/bash_history
	/bin/rm /tmp/bash_history
}

function sdu ()
{
		#http://lilydjwg.is-programmer.com/posts/18368.html
		du -sk $@ | sort -n | awk '
		BEGIN {
				split("K,M,G,T", Units, ",");
				FS="\t";
				OFS="\t";
		}
		{
				u = 1;
				while ($1 >= 1024) {
						$1 = $1 / 1024;
						u += 1
				}
				$1 = sprintf("%.1f%s", $1, Units[u]);
				sub(/\.0/, "", $1);
				print $0;
		}'
}

function sf()
{
	export FILE_NAME_SAVE_FINE=${HOME}/dev/${MYUSERNAME}/absfa
	sf_implement "$@"
}

function sfa()
{
	export FILE_NAME_SAVE_FINE=${HOME}/dev/${MYUSERNAME}/absfa
	sf_implement "$@"
}

function sfb()
{
	export FILE_NAME_SAVE_FINE=${HOME}/dev/${MYUSERNAME}/absfb
	sf_implement "$@"
}

function sf_implement()
{
	local save_file=${FILE_NAME_SAVE_FINE}

	if [ $# -eq 1 ];then
		if [ -f $1 ];then
			echo ${1} | grep '^\s*/' 2>&1 > /dev/null
			if [ $? == 0 ];then
				echo "$1" > ${save_file}
			else
				echo "$(pwd)/$1" > ${save_file}
			fi
		else
			if [ -d "$1" ];then
				if [ -d "$(pwd)/$1" ];then
					echo "$(pwd)/$1" > ${save_file}
				else
					echo "$1" > ${save_file}
				fi
			fi
		fi
	else
		if [ $# -gt 1 ];then
			: > ${save_file}
			while [ "x$1" != x ];do
				echo "$(pwd)/$1" >> ${save_file}
				shift
			done
		else
			pwd > ${save_file}
		fi
	fi
}

function sfile ()
{
	if [ $# -eq 0 ];then
		local file_list=(
		.vimrc
		#.ackrc
		karlzheng_config/mybashrc.sh
		karlzheng_config/mypathfunctions.sh
		)
		local DEV_SERVER_MOUNT_DIR=${HOME}/dev
		for f in ${file_list[@]}; do
			rsync -avurP "${HOME}/${f}" "$DEV_SERVER_MOUNT_DIR/${f}" || return 1
			rsync -avurP "$DEV_SERVER_MOUNT_DIR/${f}" "${HOME}/${f}" || return 1
		done
		return 0
	else
		local from="$1"
		local to="$2"
		rsync -avurP "$from" "$to" || return 1
		rsync -avurP "$to"	 "$from" || return 1
	fi
}

function sl()
{
	#echo "$@" | sed -e 's# #\n#g'
	tr " " "\n"
}

function son()
{
	if [ "x${OS}" == "xOSX" ];then
		echo networksetup -setsocksfirewallproxystate Wi-Fi on
		networksetup -setsocksfirewallproxystate Wi-Fi on
	fi
}

function soff()
{
	if [ "x${OS}" == "xOSX" ];then
		echo networksetup -setsocksfirewallproxystate Wi-Fi off
		networksetup -setsocksfirewallproxystate Wi-Fi off
	fi
}

function sp.old()
{
		if [ ! -f ${HOME}/dev/${MYUSERNAME}/cur_pos ];
		then echo "1" > ${HOME}/dev/${MYUSERNAME}/cur_pos;
				local  cur_pos=1;
		else local cur_pos=$(cat ${HOME}/dev/${MYUSERNAME}/cur_pos);
				local total_count=$(cat ${HOME}/dev/${MYUSERNAME}/total_count);
				((cur_pos ++));
				if [ $cur_pos -gt $total_count ];
				then cur_pos=$(expr $cur_pos - $total_count);
				fi
				echo $cur_pos > ${HOME}/dev/${MYUSERNAME}/cur_pos;
		fi
		local enter_dir=$(sed -n "$cur_pos{p;q;}"  ${HOME}/dev/${MYUSERNAME}/daily_path)
		builtin cd "$enter_dir"
		ap
}


function sproxy()
{
	ssh -fNg -D 1080 west
}

function sudopath()
{
	echo "Are you really want exec: "
	echo "sudo env PATH=${HOME}/bashrc/script/:$PATH $@"
	read -p "y|n" c
	if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
		sudo env PATH=${HOME}/bashrc/script/:$PATH "$@"
	fi
}

function swapFileName()
{
  mv $1 tmp.$$
  mv $2 $1
  mv tmp.$$ $2
}

function sallmybashrc()
{
	a=("x1" "fw" "dp");for i in ${a[@]};do echo $i; rcp ~/bashrc/karlzheng_config/mybashrc.sh ${i}:~/bashrc/karlzheng_config/mybashrc.sh;done
}

function t()
{
	touch "$@"
}

function tfind()
{
		find . -exec grep -Hn "$@" {} +
}

function tftps()
{
	if [ -e "${HOME}/bashrc/pythonlib/python-tx-tftp/examples/server.py" ];then
		sudo python ${HOME}/bashrc/pythonlib/python-tx-tftp/examples/server.py
	fi
}

function tp()
{
	type "$@"
}

function ud()
{
	cat $1 $2 | sort | uniq -d
}

function unap()
{
	if [ -d ${HOME}/dev/${MYUSERNAME} -a -f ${HOME}/dev/${MYUSERNAME}/apwdpath ];then
		/bin/rm ${HOME}/dev/${MYUSERNAME}/apwdpath
	fi
}

function uzl()
{
	unzip -l "$@"
}

function uz()
{
	readEnsureKey "unzip -x $@"
    [ $? == 0 ] || return
	unzip -x "$@"
}

function v()
{
	if [ $# -eq 1 ];then
		if [ -f "$1" -o -d "$1" ];then
			vi "$1"
			return
		fi
	fi
	if [ $# -eq 3 ];then
		local a1=$1
		local a2=$2
		local a3=$3
		if [ -e ${a1} ] && [ ${a2} == "is" ] && [ -e ${a3} ];then
			vim ${a1} ${a3}
			return
		else
			if [ ! -e ${a1} ] && [ ${a2} == "is" ] && [ -e ${a3} ];then
				vim ${a3}
				return
			fi
		fi
	fi
	if [ $# -eq 4 ];then
		local a1=$1
		local a2=$2
		local a3=$3
		local a4=$(echo $4 | sed 's#^(\(.*\))#\1#')
		if [ ${a2} == "is" ] && [ ${a3} == "hashed" ] && [ -e ${a4} ];then
			vim ${a4}
			return
		fi
	fi
	local fn=$(echo "$@" | awk -F: '{print $1}')
	local ln=$(echo "$@" | awk -F: '{print $2}')
	if [ -f "$fn" -o -d "$fn" ];then
		vim -c ":e $fn" -c ":$ln"
		return;
	fi
	if [ $(echo "$fn" | grep "^a/") ];then
		fn=$(echo "$fn" | cut -b 3-)
	fi
	if [ $(echo "$fn" | grep "^b/") ];then
		fn=$(echo "$fn" | cut -b 3-)
	fi
	if [ -f "$fn" -o -d "$fn" ];then
		vim -c ":e $fn" -c ":$ln"
		return;
	else
		vim -c ":LUTags $fn"
	fi
}

function vb()
{
	local f=""
	local f1=~/bashrc/karlzheng_config/mybashrc.sh
	if [ -e ${f1} ];then
		f=${f1}
	fi
	local f1=~/.bashrc
	if [ -e ${f1} ];then
		f="${f} ${f1}"
	fi
	if [ "${f}" != "" ];then
		vi ${f}
	fi
}

function vc()
{
   if [ -d arch/arm/configs/ ];then
	   vi arch/arm/configs/
   fi
}

function vd()
{
	vimdiff "$@"
}

function vf()
{
	: > ${HOME}/dev/${MYUSERNAME}/absfa
	for f in $(find -iname "$@");do
		echo "$(pwd)/${f}" >> ${HOME}/dev/${MYUSERNAME}/absfa
	done
	vi -c EditAbsoluteFilePath
}

function vg()
{
	vi -c CG
}

function vi()
{
	if [ ${OS} == "OSX" ];then
		vim "$@"
	else
		/usr/bin/vim "$@"
	fi
}

function vl()
{
	if [ -f ~/tmp/bash_history ];then
		vi ~/tmp/bash_history
	fi
}

function v1()
{
	mkdir -p ~/tmp/log/
	local n=0
	while [ ${n} -lt 200 ];do
		if [ ! -e "${HOME}/tmp/log/del${n}.txt" ];then
			break
		fi
		((n++))
	done
	vi "${HOME}/tmp/log/del${n}.txt"
}

function vm()
{
	#http://ahei.info/bash.htm
	#http://blog.morebits.org/?p=103
	#vim <(man "$@")
	#local help_file="${HOME}/dev/$(whoami)/$@.$$.hlp.txt"
	local help_file="${HOME}/dev/$(whoami)/$1.$$.hlp.txt"
	if [ $# -ge 1 ];then
		#eval echo \${$#}
		#echo ${!#}
		local lastarg=${!#}
		if [ ${lastarg} == "--help" ];then
			#shift
			local allargs="$@"
			echo ${allargs}
			(${allargs} | fold -s -w 80) > ${help_file}
		else
			# https://blog.csdn.net/maijunjin/article/details/29379759
			type "$@" | grep -q builtin
			if [ $? == 0 ];then
				(help "$@" | col -b | fold -s -w 80) > ${help_file}
			else
				(man "$@" | col -b | fold -s -w 80) > ${help_file}
			fi
		fi
	fi
	if [ -f ${help_file} ];then
		vim ${help_file}
		/bin/rm ${help_file}
	fi
}

function vm.sh()
{
	m.sh "$@"
	vg
}

function vmdis()
{
		local tmpfile="/tmp/vmdis.c"

		if [ -f $tmpfile ];then
				mv $tmpfile $tmpfile.old -f
		fi
		if [ $# -ge 1 ];then
				local startaddress="0x"${1##0x}
				if [ $# -eq 2 ];then
						local stopaddress=$2
				else
						local stopaddress=$(printf "0x%x" $(($startaddress+0x500)))
				fi
				echo "arm-none-linux-gnueabi-objdump -S vmlinux --start-address=$startaddress --stop-address=$stopaddress > $tmpfile"
				echo "the destinated disassemble file is:$tmpfile"
				history -s "vmdis $@"
				history -s "$tmpfile"
				arm-none-linux-gnueabi-objdump -S vmlinux --start-address=$startaddress --stop-address=$stopaddress > $tmpfile
				#vi $tmpfile
		fi
}

function vp()
{
	local f=""
	local f1=${HOME}/pwd.mk
	if [ -e ${f1} ];then
		f="${f} ${f1}"
	fi
	local f1=${HOME}/bashrc/karlzheng_config/mypathfunctions.sh
	if [ -e ${f1} ];then
		f="${f} ${f1}"
	fi
	if [ "${f}" != "" ];then
		vi ${f}
	fi
}

function vt()
{
	local f=${HOME}/tmp/tee.log
	local tf=${HOME}/tmp/.tee.log.swp
	if [ -e ${tf} ];then
		read -p "exist ${tf}, do you want to delete it? y|n " c
		if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
			rm ${tf}
		fi
	fi
	if [ -e ${f} ];then
		vim ${f}
	fi
}

function vv()
{
	local fn=/tmp/$(basename $0).tmp
	: > ${fn}
	local lines
	for l in $(echo "$@");do
		echo "$l" >> ${fn}
	done
	if [ $(cat ${fn} | wc -l) == 1 ];then
		v $(cat ${fn})
	else
		v ${fn}
	fi
	#echo "$@" | dd bs=10 count=100 >> /vv
	#while read line
	#do
		#echo "$line" >> ${fn}
	#done
}

function ncdown()
{
	nmcli con down id "$@"
}

function ncup()
{
	nmcli con up id "$@"
}

function ve()
{
	if [ -f ${HOME}/shm/$(whoami)/edit.vim ];then
		vim -c SS
	fi
}

function vs()
{
	local fn="${HOME}/tmp/scratch"
	if [ -f ${fn} ];then
		vim ${fn}
	fi
}

function wblog()
{
	local fn="$(date +%Y-%m-%d)-$@.md"
	echo open -a /Applications/Typora.app/Contents/MacOS/Typora ${fn}
	local title=$(echo $@ |sed 's/-/ /g')
	touch "$(date +%Y-%m-%d)-$@.md"
	cat << EEOOFF > ${fn}
---
layout: post
categories: tech
title: ${title}
typora-root-url: ../
---
## ${title}
EEOOFF
	open -a /Applications/Typora.app/Contents/MacOS/Typora ${fn}
}

function w2proxy()
{
	local retry_cnt=0
	while true;do
		ssh -o ServerAliveInterval=30 -D 1080 w2 || true;
		sleep 0.5
		((retry_cnt++))
		if [ ${retry_cnt} -ge 8 ];then
			return
		fi
	done
}

function wh()
{
	which "$@"
}

function wi()
{
	whoami "$@"
}

function wl()
{
	wc -l $@
	return
	mkdir -p ~/tmp/log/
	local f=""
	if [ $# -ge 1 ];then
		f=$1
	else
		f=log.log
	fi
	if [ -e ${HOME}/tmp/log/${f} ];then
		/bin/mv ${HOME}/tmp/log/${f} ${HOME}/tmp/log/${f}.old
	fi
	vi ${HOME}/tmp/log/${f}
}

function wln()
{
	mkdir -p ~/tmp/log/
	local f=""
	local n=0
	while [ $n -lt 2000 ];do
		if [ ! -e "${HOME}/tmp/log/${n}.log" ];then
			break
		fi
		((n++))
	done
	f="${n}.log"
	vi ${HOME}/tmp/log/${f}
}

function www()
{
	#https://opensource.com/article/18/9/handy-bash-aliases
	ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"
	python -m SimpleHTTPServer $@
}

#alias mcd='pu; ${MYUSERNAME}path=$(tail -n 1 ${HOME}/dev/${MYUSERNAME}path); cd $${MYUSERNAME}path'
function archfunc.sh()
{
	local af="${HOME}/dev/${MYUSERNAME}/arch"
	if [ -f ${af} ];then
		export ARCH=$(cat ${af})
	else
		local af="${HOME}/person_tools/arch"
		if [ -f ${af} ];then
			export ARCH=$(cat ${af})
		fi
	fi
}

function my_bash_login_auto_exec_func()
{
	export DT=$(date +%Y%m%d)
	#archfunc.sh
	if [ -d ~/Desktop ];then
		export d=~/Desktop/
	else
		export d=~/桌面/
	fi
	if [ -d ~/Downloads ];then
		export dl=~/Downloads/
	else
		export dl=~/下载/
	fi
	if [ "x$(locale | grep zh_CN)" != "x" ];then
		export LANG="zh_CN.UTF-8"
		export LANGUAGE="zh_CN.UTF-8"
		export LC_ALL="zh_CN.UTF-8"
		#export LC_ALL=C
	fi
	local fn=/tmp/`whoami`.today
	[ -f ${fn} ] || echo `date +%Y%m%d` > ${fn}
	if [ "$(cat ${fn})" == "$(date +%Y%m%d)" ];then
		export isTodayFirstLogin=0
	else
		echo `date +%Y%m%d` > ${fn}
		export isTodayFirstLogin=1
	fi
	if [ "${isTodayFirstLogin}" == 1 ];then
		function ensure_file_dir()
		{
			[ -d ~/.trash ] || mkdir ~/.trash
			[ -d ~/dev1 ] || mkdir ~/dev1
			[ -d ~/dev2 ] || mkdir ~/dev2
			[ -d ~/tmp ] || mkdir ~/tmp
			[ -d ~/tmp/log ] || mkdir ~/tmp/log
			[ -d ~/tmp/t ] || mkdir ~/tmp/t
			[ -d ~/tmp/tmp ] || mkdir ~/tmp/tmp
			[ -d ~/tmp/tmp_work_file ] || mkdir ~/tmp/tmp_work_file
			[ -d /tmp/t ] || mkdir /tmp/t
			[ -d ${HOME}/dev/${MYUSERNAME}/ ] || mkdir -p ${HOME}/dev/${MYUSERNAME}/
		}
		ensure_file_dir
		unset ensure_file_dir
		touch ${HOME}/dev/${MYUSERNAME}/notfirstlogin
		echo "magiccube" > ${HOME}/dev/${MYUSERNAME}/androidProjectName
		sbl
	fi

	local path_list=(
	~/person_tools/
	~/person/scripts/
	~/bin
	~/bin/bin
	~/bashrc/script/
	~/software/bin
	~/software/arm-2009q3/bin/
	~/software/arm-eabi-4.6/bin
	~/software/android-sdk-linux_86/platform-tools
	~/software/android-sdk-linux_86/tools
	~/software/android-ndk-r8c
	~/software/apache-maven/bin
	~/bk/sw/adt/sdk/platform-tools
	~/bk/sw/gradle-1.6/bin
	~/bk/sw/adt/sdk/tools
	~/software/linaro-arm-linux-gnueabi-4.6.3/bin
	~/software/rbox_Linux_Upgrade_Tool_v1.16
	${JAVA_HOME}/bin
	/Users/karlzheng/Library/Android/sdk/platform-tools
	/usr/local/opt/coreutils/libexec/gnubin
	/usr/local/opt/findutils/libexec/gnubin
	);
	local mypath=""
	for p in ${path_list[@]};do
		if [ -d ${p} ];then
			mypath=$mypath:"$p"
		fi
	done
	export PATH="$mypath":$PATH
	local path_list=(
	${HOME}/bashrc/pythonlib
	);
	local mypath=""
	for p in ${path_list[@]};do
		if [ -d ${p} ];then
			mypath=$mypath:"$p"
		fi
	done
	export PYTHONPATH="$mypath":$PYTHONPATH
	append_daily_path
	unset append_daily_path

	if [ "$(pwd)" == "${HOME}" ];then
		ac
	fi
	if [ -d "/rambuild" ];then
		if [ ! -d "/rambuild/ramdisk" ];then
			mkdir "/rambuild/ramdisk"
		fi
		if [ ! -d "${HOME}/ramdisk" ];then
			ln -s "/rambuild/ramdisk" "${HOME}/ramdisk"
		fi
	fi

	if [ $MYUSERNAME != $MYNICKNAME ];then
		export PATH=$PATH:/home/$MYUSERNAME/software/arm-2010q1/bin:
		export USE_CACHE=1
		if [ -d $HOME/ramdisk/ccache ];then
			mkdir -p $HOME/ramdisk/ccache
			CCACHE_DIR=$HOME/ramdisk/ccache
		fi
		mkdir -p ${HOME}/ccache
		CCACHE_DIR=${HOME}/ccache
		#ccache -M 50G
	fi
	if [ -f .git/config ];then
		git config http.postBuffer 524288000
	fi

	#export JAVA_HOME=/usr/lib/jvm/java-1.5.0-sun
	#export JAVA_HOME=/usr/lib/jvm/java-6-openjdk/
	#export JAVA_HOME=/usr/lib/jvm/java-6-sun/
	#export ANDROID_JAVA_HOME=$JAVA_HOME

	#export JAVA_HOME=${HOME}/bk/sw/jdk1.6.0_45/
	if [ -d ${HOME}/bk/sw/android-ndk ];then
		export NDK_ROOT=${HOME}/bk/sw/android-ndk/
		export NDK=${HOME}/bk/sw/android-ndk/
	fi
	local androidsdkdir=${HOME}/Android/Sdk
	if [ -d ${androidsdkdir} ];then
		export ANDROID_SDK_ROOT=${androidsdkdir}/
	fi
	ajavapath
}

#bash command:
#for i in $(grep "CONFIG_EVT1" * --color -rHnI|grep -v ^tags|grep -v ^cscope | awk -F: '{print $1}');do	 sed -ie "s#CONFIG_EVT1#CONFIG_EXYNOS4412_EVT1#g" $i;done
#1727  git checkout --track origin/mars
#rsync -avurP ${HOME}/rjb/BSP/BSP_PRIVATE/ /media/sdb9/work/BSP_PRIVATE/

# TODO: all common vars move to mycommon.sh
if [ -f ~/bashrc/karlzheng_config/mycommon.sh ];then
   source ~/bashrc/karlzheng_config/mycommon.sh
fi
if [ -f ~/bashrc/karlzheng_config/adb.bash_complete.sh ];then
		source	~/bashrc/karlzheng_config/adb.bash_complete.sh
fi
if [ -f ~/bashrc/karlzheng_config/mypathfunctions.sh ];then
		source ~/bashrc/karlzheng_config/mypathfunctions.sh
fi
if [ -e ~/person_tools/func.sh ];then
	source ~/person_tools/func.sh
fi
if [ -f ~/bashrc/karlzheng_config/mycomplete.sh ];then
		source ~/bashrc/karlzheng_config/mycomplete.sh
fi
if [ -f ~/bashrc/bashcomplete/git-completion.bash ];then
		source ~/bashrc/bashcomplete/git-completion.bash
fi

my_bash_login_auto_exec_func

if [ -d ~/person_tools/ ];then
	which buildServerConnectAndMount >/dev/null 2>&1
	if [ $? == 0 ];then
		buildServerConnectAndMount
	fi
fi
