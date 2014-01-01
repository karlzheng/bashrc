#!/bin/bash - 

echo "user_allow_other" > /tmp/tmp.txt
echo "allow_other" >> /tmp/tmp.txt
sudo bash -c "cat /tmp/tmp.txt >> /etc/fuse.conf 
sudo chmod a+r /etc/fuse.conf 
