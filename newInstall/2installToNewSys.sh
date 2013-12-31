#!/bin/bash - 

if [ "x${NEWIP} == "x" ];then
    echo "pls export NEWIP env var"
else
    rsync -avP ~/.ssh $(whoami)@${NEWIP}:~/ 
    rsync -avP ~/bashrc $(whoami)@${NEWIP}:~/ 
    rsync -avP ~/vimrc $(whoami)@${NEWIP}:~/ 
fi
