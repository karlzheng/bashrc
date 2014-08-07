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

if [ "${SHELL}" != "/bin/bash" ];then
		#echo "the SHELL is not bash! exit!!"
		echo 'use "chsh -s /bin/bash" to change ${SHELL}'
		#chsh -s /bin/bash
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

stty -ixon

export GTAGSFORCECPP=
export LC_MESSAGES="C"

export MYNICKNAME="karlzheng"
export MYUSERNAME=$(whoami)

#export ANDROID_LOG_TAGS='Sensors:V *:S'
export ARCH=arm
#http://huangyun.wikispaces.com/%E7%BB%99man+pages%E5%8A%A0%E4%B8%8A%E5%BD%A9%E8%89%B2%E6%98%BE%E7%A4%BA
export BROWSER="$PAGER"
#export CROSS_COMPILE=arm-none-linux-gnueabi-
export CROSS_COMPILE=arm-linux-gnueabi-
export D=~/桌面/
export EDITOR=vim
export GRADLE_HOME=${HOME}/bk/sw/gradle-1.6
#命令文件最大行数
export HISTSIZE=5000000
#最大命令历史记录数
export HISTCONTROL="erasedups:ignoreboth"
export HISTFILESIZE=5000000
export HISTIGNORE="c:h:history:ha:hd:he:hi:la:ls:sb"
#export JAVA_HOME=${HOME}/bk/sw/jdk1.7.0_25/
export JAVA_HOME=${HOME}/bk/sw/jdk1.6.0_45/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./:
export LESS_TERMCAP_mb=$'\E[01;34m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;33m'
export PAGER="`which less` -s"
#export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
#export PROMPT_COMMAND="history -a;history -n;$PROMPT_COMMAND"
#export PROMPT_COMMAND="history -a"
export PS4='+[$LINENO]'
export SVN_EDITOR=/usr/bin/vim

export d=~/桌面/
export desktop=~/桌面/
export dl=~/下载/
export imgout=out/target/product/

#add other info here just for android
#export ANDROID_PRODUCT_OUT=out/target/product/
#export ANDROID_SWT=/home/${MYUSERNAME}/svn/app_group_android/Eclair/out/host/linux-x86/framework
#export ANDROID_SWT=/media/cdriver/work/software/android-sdk-linux_86/tools/lib/x86/
#export TARGET_BUILD_TYPE=debug

bind -m emacs '"\en": history-search-forward'
bind -m emacs '"\ep": history-search-backward'
bind -m emacs '"\ew": backward-kill-word'

bind -m emacs '"\C-o": menu-complete'

bind -m emacs '"\C-ga": "grep \"\" * --color -rHniI|grep -v ^tags|grep -v ^cscopef"'
#bind -m emacs '"\C-gc": "grep \"\" * --color -rHnIf"'
bind -m emacs '"\C-gc": "$(!!)"'
bind -m emacs '"\C-gf": "$(fp)"'
bind -m emacs '"\C-gh": "--help"'
bind -m emacs '"\C-gm": "grep mei Makefile"'
bind -m emacs '"\C-gt": " | tee ~/tmp/tee.log"'
bind -m emacs '"\C-gv": "--version"'
bind -m emacs '"\C-gz": " arch/arm/boot/zImage"'

bind -m emacs '"\C-g\C-a": "mgrep.sh "'
bind -m emacs '"\C-g\C-b": "grep \"\" * --color -rHnIC2f"'
bind -m emacs '"\C-g\C-f": "bcompare \"$(fp)\" . &"'
bind -m emacs '"\C-g\C-h": "--hard"'
bind -m emacs '"\C-g\C-n": "find -name "'
bind -m emacs '"\C-g\C-[": " $()OD"'
#bind -m emacs '"\C-]": character-search-backward'
#bind -m emacs '"\e\C-]": character-search'

unalias ls
#alias adb_="sudo adb kill-server && sudo adb start-server"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias CD='cd'
alias cdance_rsync="rsync -avurP /home/karlzheng/rjb/BSP/BSP_PRIVATE/ /media/sdb9/work/BSP_PRIVATE/"
alias cdg='cd /media/work/kernel/meizu/git/mx/linux-2.6.35-mx-rtm'
alias ck="cd /media/cdriver/work/kernel/meizu/"
alias co="cd -"
alias copy_to_m8="rsync -av /media/x/english/voa/ /media/Meizu\ M8/Music/voa/"
alias cp='cp -i '
alias cw="cd /media/work/"
alias git_vim_diff="git diff --no-ext-diff -w |vim -R -"
#alias grep='grep --exclude-dir=.svn --exclude="*.o" --exclude="*.o.cmd" '
alias j='jobs '
alias killgtags="ps |grep global|awk '{print \$1}'|xargs kill -9;ps |grep gtags|awk '{print \$1}'|xargs kill -9"
alias LA='ls -latr'
alias la='ls -latr'
alias ll='ls -l '
alias l='ls -CF '
alias lm='ls arch/arm/configs/m*'
alias lr='ls -latr'
alias LS='ls'
alias ls='ls --color=tty -a '
alias lS='ls -laSr '
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
alias pp="cat -n /dev/shm/${MYUSERNAME}/daily_path"
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

function adblistpackages()
{
	adb shell pm list packages -f "$@"
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
		[ -f /dev/shm/${MYUSERNAME}/daily_path ] || touch /dev/shm/${MYUSERNAME}/daily_path
		for p in ${path_list[@]}; do
			if [ -d ${p} ];then
				grep -q "^$p$"	/dev/shm/${MYUSERNAME}/daily_path
				if [ $? != 0 ]; then
					echo "$p" >> /dev/shm/${MYUSERNAME}/daily_path;
				fi
			fi
		done
		wc -l /dev/shm/${MYUSERNAME}/daily_path |awk '{print $1}' > /dev/shm/${MYUSERNAME}/total_count
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

function ctrash()
{
		/bin/rm -rf ~/.trash;
		mkdir ~/.trash;
		sync;
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

function bcp()
{
	/bin/cp "$@"
}

function d()
{
	if [ -d ~/Desktop ];then
		cd ~/Desktop/
	else
		cd ~/桌面/
	fi
}

function dfd()
{
	local IFS=$'\n'
	: > /dev/shm/dfd.tmp.log
	for i in $(lsd);do
		du -sh "$i" >> /dev/shm/dfd.tmp.log
	done
	cat /dev/shm/dfd.tmp.log | sort -h
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
	dirs "$@"
}

function dsh()
{
	du -sh
}

function dt()
{
	date +%Y%m%d
}

function ey()
{
	local c
	if [ -f /dev/shm/$(whoami)/yank.txt ];then
		echo "/dev/shm/$(whoami)/yank.txt :"
		cat /dev/shm/$(whoami)/yank.txt
		read -p "exec y|n ?" c
		if [ "x${c}" == "xy" -o "x${c}" == "x" ];then
			source /dev/shm/$(whoami)/yank.txt
			history -s "$(cat /dev/shm/$(whoami)/yank.txt | head -n 1)"
		fi
	else
		echo "No /dev/shm/$(whoami)/yank.txt"
	fi
}

function f()
{
	find -iname "$@"
}

function fp()
{
	if [ -f /dev/shm/$(whoami)/absfn ];
		then cat /dev/shm/$(whoami)/absfn
	fi
}

function g()
{
	grep "$@"
}

function ga()
{
	git add "$@"
}

function gaa()
{
	git add -A
}

function gba()
{
	git branch -a
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
	if [ -d .git ];then
		read -p "git pull current dir y|n ?" c
		if [ "x${c}" == "xy" -o "x${c}" == "x" ];then
			git pull
		fi
	else
		echo "Not a git repository!"
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
	git status -u "$@"
}

function ha()
{
	local ignore_cmd_list=(c h history ha hd he hi la ls sb)
	n=0
	history 10 |sort -r > /dev/shm/${MYUSERNAME}/hist10.txt
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
			echo "$cmd_line" > /dev/shm/${MYUSERNAME}/hist_cmd.txt
			echo "$cmd_line"
			return 0
		fi
	done  < /dev/shm/${MYUSERNAME}/hist10.txt
}

function hd()
{
	cat	 /dev/shm/${MYUSERNAME}/hist_cmd.txt
}

function he()
{
	local cmd_line=$(tail -1 /dev/shm/${MYUSERNAME}/hist_cmd.txt|tr -d "\r"|tr -d "\n")
	echo "$cmd_line"
	history -s "$cmd_line"
	#exec "$cmd_line"
	eval "$cmd_line"
}

function h()
{
	if [ $# -eq 0 ];then
		history | tail -n 40
	else
		history "$@"
	fi
}

function hi()
{
	history
}

function hn()
{
	history -n
}

function hp()
{
	if [ -f ~/person_tools/headneck.jpg ];then
		eog -f ~/person_tools/headneck.jpg && disown &
	fi
}

function ht()
{
	history | tail -n 10
}

function k()
{
	 for i in $(jobs | awk '{print $1}' | sed -e 's#\[\(.*\)\].*#\1#'); do
		echo "kill -9 %$i"
		#sudo kill -9 %$i
		kill -9 %$i
	 done
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

function lsd()
{
	#/bin/ls -la | grep -E "^d|^l" | awk '{print $NF}'
	#ls -l | awk '/^d/{print $NF}'
	local IFS=":"
	ls -d */
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

function mcddt()
{
	local dt=$(date +%Y%m%d)
	mkdir ${dt}
	cd ${dt}
}

function md()
{
	mkdir -p "$@"
}

function mddt()
{
	mkdir $(date +%Y%m%d)
}

function mj()
{
	local CPUS=$(/bin/grep processor /proc/cpuinfo \
		| /usr/bin/awk '{field=$NF};END{print(field+1)*2}')
    make -j${CPUS} "$@"
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
		done < /dev/shm/${MYUSERNAME}/daily_path
}

function myvimpath()
{
	export PATH=~/software/bin/bin:${PATH}:
}

function n()
{
		if [ $# -eq 0 ];then
				nautilus .
		else
				nautilus $1
		fi
		type xdotool
		if [ $? == 0 ];then
			xdotool windowactivate $(xdotool search --class nautilus | tail -n 1)
		fi
		return 0
}

function nq()
{
	read -p "Are you sure quit all nautilus? y|n" c
	if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
		nautilus -q
	fi
}

function p()
{
	pushd +1
}

function pu()
{
	if [ $# -ge 1 ];then
		pushd "$@"
	else
		pushd .
	fi
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
	rsync -rvP "$@"
}

function repo()
{
	if [ "x$0" != "x-bash" ];then
		echo $(basename "$0") $LINENO
	else
		echo "in bash config $LINENO"
	fi
	echo "$@" > /dev/shm/${MYUSERNAME}/repo_cmd_line
	grep -qP "alibaba|yunos-inc|kangliang.zkl" /dev/shm/${MYUSERNAME}/repo_cmd_line
	if [ $? == 0 ];then
		ali_repo "$@"
	else
		google_repo "$@"
	fi
}

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
	if [ ! -d ~/.trash ]; then
		mkdir ~/.trash;
	fi;
	while [ "x$1" != x ];do
		if [ -f "$1" -o -d "$1" ];then
			local bn=$(basename "$1")
			if [ -f "${HOME}/.trash/${bn}" ];then
				/bin/mv -f ${HOME}/.trash/${bn} ${HOME}/.trash/${bn}.old
			fi
			if [ -d "${HOME}/.trash/${bn}" ];then
				#ensure no / at the end of path
				#local d=${1%/}
				if [ -d ${HOME}/.trash/${bn}.old ];then
					/bin/rm ${HOME}/.trash/${bn}.old -rf
				fi
				/bin/mv ${HOME}/.trash/${bn} ${HOME}/.trash/${bn}.old
			fi
			/bin/mv $1 ~/.trash/
		fi
		shift
	done
}

function rs()
{
	if [ -d .repo ];then
		repo status "$@"
	fi
}

function sai()
{
	sudo apt-get install "$@"
}

function sbl()
{
	#save bash log
	if [ -e ~/tmp/bash_history ];then
		/bin/cp ~/tmp/bash_history ~/tmp/bash_history.bak
	fi
	cat ~/.bash_history >> ~/tmp/bash_history
	sort ~/tmp/bash_history > /tmp/bash_history
	cat /tmp/bash_history | awk '!a[$0]++' > ~/tmp/bash_history
	rm /tmp/bash_history
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
	if [ $# -ge 1 ];then
		if [ -f $1 ];then
			echo ${1} | grep '^\s*/' 2>&1 > /dev/null
			if [ $? == 0 ];then
				echo "$1" > /dev/shm/${MYUSERNAME}/absfn
			else
				echo "$(pwd)/$1" > /dev/shm/${MYUSERNAME}/absfn
			fi
		fi
	else
		pwd > /dev/shm/${MYUSERNAME}/absfn
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

function sp()
{
		if [ ! -f /dev/shm/${MYUSERNAME}/cur_pos ];
		then echo "1" > /dev/shm/${MYUSERNAME}/cur_pos;
				local  cur_pos=1;
		else local cur_pos=$(cat /dev/shm/${MYUSERNAME}/cur_pos);
				local total_count=$(cat /dev/shm/${MYUSERNAME}/total_count);
				((cur_pos ++));
				if [ $cur_pos -gt $total_count ];
				then cur_pos=$(expr $cur_pos - $total_count);
				fi
				echo $cur_pos > /dev/shm/${MYUSERNAME}/cur_pos;
		fi
		local enter_dir=$(sed -n "$cur_pos{p;q;}"  /dev/shm/${MYUSERNAME}/daily_path)
		builtin cd "$enter_dir"
		ap
}

function sproxy()
{
	ssh -fNg -D 7001 sztv
}

function swap()
{
  mv $1 tmp.$$
  mv $2 $1
  mv tmp.$$ $2
}


function t()
{
	touch "$@"
}

function tp()
{
	type "$@"
}

function tfind()
{
		find . -exec grep -Hn "$@" {} +
}

function unap()
{
		if [ -d /dev/shm/${MYUSERNAME} -a \
				-f /dev/shm/${MYUSERNAME}/apwdpath ];then
				rm /dev/shm/${MYUSERNAME}/apwdpath
		fi
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
	if [ $# -ge 1 ];then
		if [ -f $1 ];then
			echo "$(pwd)/$1" > /dev/shm/$(whoami)/vimEditFn
		fi
	else
		pwd > /dev/shm/$(whoami)/vimEditFn
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
	#local help_file="/dev/shm/$(whoami)/$@.$$.hlp.txt"
	local help_file="/dev/shm/$(whoami)/$1.$$.hlp.txt"
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
			type "$@" | grep -q builtin
			if [ $? == 0 ];then
				(help "$@" | fold -s -w 80) > ${help_file}
			else
				(man "$@" | fold -s -w 80) > ${help_file}
			fi
		fi
	fi
	if [ -f ${help_file} ];then
		vim ${help_file}
		/bin/rm ${help_file}
	fi
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
	local f1=${HOME}/bashrc/karlzheng_config/mypathfunctions.sh
	if [ -e ${f1} ];then
		f=${f1}
	fi
	local f1=${HOME}/pwd.mk
	if [ -e ${f1} ];then
		f="${f} ${f1}"
	fi
	if [ "${f}" != "" ];then
		vi ${f}
	fi
}

function wi()
{
	whoami "$@"
}

function wl()
{
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

#alias mcd='pu; ${MYUSERNAME}path=$(tail -n 1 /dev/shm/${MYUSERNAME}path); cd $${MYUSERNAME}path'
function _mcd_complete() {
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
							COMPREPLY=($( compgen -W 'kernel bootloader \
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

function _ksvn_complete()
{
		local my_complete_word=(
				'svn://172.16.9.63/svn_src'
				'https://172.16.1.21/svn/IceCreamSandwich'
		)
		COMPREPLY=($(compgen -W '${my_complete_word[@]}' -- $cur))
		return 0
}
#complete -W 'svn://172.16.11.122/svn_src' 'https://172.16.1.21/svn/IceCreamSandwich' ksvn

if [ $MYUSERNAME == $MYNICKNAME ];then
		complete -o default -F _longopt vi
fi
complete -c tp
complete -c vm
complete -F _bypy_completion bypy.py
complete -F	_dnw_complete dnw
complete -F	_ksvn_complete ksvn
complete -F	_fastboot_completion fastboot
complete -F	_mj_complete mj
complete -F	_mc_complete mc
complete -W 'arch/arm/configs' lac
complete -W 'xconfig clean distclean' make
complete -W 'xconfig clean distclean zImage' mj

function my_bash_login_auto_exec_func()
{
		export DT=$(date +%Y%m%d)
		if [ $(locale -a | grep zh_CN) ];then
			export LANG="zh_CN.UTF-8"
			export LANGUAGE="zh_CN.UTF-8"
		fi
		if [ -f /dev/shm/${MYUSERNAME}/notfirstlogin ];then
			export isfirstlogin=0
		else
			export isfirstlogin=1
		fi

		if [ "${isfirstlogin}" == 1 ];then
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
				[ -d /dev/shm/${MYUSERNAME}/ ] || mkdir -p /dev/shm/${MYUSERNAME}/
			}
			ensure_file_dir
			unset ensure_file_dir
			touch /dev/shm/${MYUSERNAME}/notfirstlogin
			echo "magiccube" > /dev/shm/${MYUSERNAME}/androidProjectName
			sbl
		fi

		local path_list=(
				~/person_tools/
				~/bashrc/script/
				~/software/bin
				~/software/arm-2009q3/bin/
				~/software/arm-eabi-4.6/bin
				~/software/android-sdk-linux_86/platform-tools
				~/software/android-sdk-linux_86/tools
				~/software/android-ndk-r8c
				~/bk/sw/adt/sdk/platform-tools
				~/bk/sw/gradle-1.6/bin
				~/bk/sw/adt/sdk/tools
				~/bin
				~/bin/bin
				~/software/linaro-arm-linux-gnueabi-4.6.3/bin
				~/software/rbox_Linux_Upgrade_Tool_v1.16
		${JAVA_HOME}/bin
		);
		local mypath=""
		for p in ${path_list[@]};do
				mypath=$mypath:"$p"
		done
		export PATH="$mypath":$PATH
		local path_list=(
		${HOME}/bashrc/pythonlib
		);
		local mypath=""
		for p in ${path_list[@]};do
				mypath=$mypath:"$p"
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
		if [ -d ${HOME}/bk/sw/android-ndk-r9c ];then
			export NDK_ROOT=${HOME}/bk/sw/android-ndk-r9c/
		fi
		if [ -d ${HOME}/bk/sw/adt/sdk ];then
			export ANDROID_SDK_ROOT=${HOME}/bk/sw/adt/sdk/
		fi

}

#bash command:
#for i in $(grep "CONFIG_EVT1" * --color -rHnI|grep -v ^tags|grep -v ^cscope | awk -F: '{print $1}');do	 sed -ie "s#CONFIG_EVT1#CONFIG_EXYNOS4412_EVT1#g" $i;done
#1727  git checkout --track origin/mars
#rsync -avurP /home/karlzheng/rjb/BSP/BSP_PRIVATE/ /media/sdb9/work/BSP_PRIVATE/

if [ -f ~/bashrc/karlzheng_config/adb.bash_complete.sh ];then
		source	~/bashrc/karlzheng_config/adb.bash_complete.sh
fi
if [ -f ~/bashrc/karlzheng_config/mypathfunctions.sh ];then
		source ~/bashrc/karlzheng_config/mypathfunctions.sh
fi
if [ -e ~/person_tools/func.sh ];then
	source ~/person_tools/func.sh
fi

my_bash_login_auto_exec_func

if [ -d ~/person_tools/ ];then
	buildServerConnectAndMount
fi
