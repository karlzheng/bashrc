#!/bin/bash - 

echo "$(whoami) ALL=(ALL:ALL) NOPASSWD:ALL" > /tmp/tmp.txt
sudo bash -c "cat /tmp/tmp.txt >> /etc/sudoers"

sudo apt-get install ssh
