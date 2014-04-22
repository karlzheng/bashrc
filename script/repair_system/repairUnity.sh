#!/bin/bash -
#http://forum.ubuntu.org.cn/viewtopic.php?f=49&t=442581
sudo apt-get install dconf-tools
dconf reset -f /org/compiz/
setsid unity
