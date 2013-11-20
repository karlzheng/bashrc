#!/bin/bash

CONF_SUB_DIR="bashrc/karlzheng_config"
CONF_DIR="${HOME}/${CONF_SUB_DIR}"

function cp_shell_script()
{ 
    mkdir -p "$CONF_DIR"
    local filelist=(
    adb.bash_complete.sh
    mypathfunctions.sh
    my_private_bashrc.sh
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
    echo "$CONF_SUB_DIR" "${HOME}/.bashrc"
    grep "$CONF_SUB_DIR" "${HOME}/.bashrc" | grep "mybashrc"
    if [ $? != 0 ];then
	cat bashrc_prefix.txt >> ${HOME}/.bashrc
	#cp_shell_script
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

function add_mytools()
{
    
    if [ ! -d ${HOME}/mytools -a -d mytools ];then
	cp mytools ${HOME}/mytools -a
    fi
}

add_dot_bashrc_call
#add_vim_config
#add_mytools
