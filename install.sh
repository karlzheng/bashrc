#!/bin/bash

CONF_SUB_DIR="bashrc/karlzheng_config"
CONF_DIR="${HOME}/${CONF_SUB_DIR}"

function cp_shell_script()
{
    mkdir -p "$CONF_DIR"
    local filelist=(
    adb.bash_complete.sh
    mypathfunctions.sh
    my_ssh_bashrc.sh
    install.sh
    )
    for i in ${filelist[@]}; do
	if [ ! -f "$CONF_DIR/$i" -a -f "./$i" ];then
	    echo cp "./$i" "$CONF_DIR/"
	    cp "./$i" "$CONF_DIR"
	else
	    echo "exist $CONF_DIR/$i"
	fi
    done
}

function add_dot_bashrc_call()
{
	local f="${HOME}/.bashrc"
	if [ -e ${f} ];then
		grep "$CONF_SUB_DIR" "${HOME}/.bashrc" | grep "mybashrc"
		if [ $? != 0 ];then
			cat karlzheng_config/bashrc_prefix.txt >> ${HOME}/.bashrc
			#cp_shell_script
		fi
	else
		echo "There is no file ${f}"
		echo "cat karlzheng_config/bashrc_prefix.txt >> ${HOME}/.bashrc"
		cat karlzheng_config/bashrc_prefix.txt >> ${HOME}/.bashrc
	fi
}

function add_vim_config()
{
    if [ ! -f ${HOME}/.vimrc -a -f .vimrc ];then
	cp .vimrc ${HOME}/.vimrc
    fi

    if [ ! -d ${HOME}/.vim -a -d .vim ];then
	cp .vim ${HOME}/.vim -a
    fi
}

add_dot_bashrc_call

#sudo apt-get update
#sudo apt-get install vim-gnome

#add_vim_config
