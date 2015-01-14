#!/bin/bash -

echo "$(whoami) ALL=(ALL:ALL) NOPASSWD:ALL" > /tmp/tmp.txt
sudo bash -c "cat /tmp/tmp.txt >> /etc/sudoers"

sudo apt-get install ssh -y

## for Thinkpad CapsLock key indicator.
#sudo add-apt-repository ppa:tsbarnes/indicator-keylock
#sudo apt-get update
#sudo apt-get install indicator-keylock -y
#setsid indicator-keylock
