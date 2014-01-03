#!/bin/bash - 

#echo "user_allow_other" > /tmp/tmp.txt
#echo "allow_other" >> /tmp/tmp.txt
#sudo bash -c "cat /tmp/tmp.txt >> /etc/fuse.conf 
#sudo chmod a+r /etc/fuse.conf 

cd ~
dpkg -l | grep ^ii |awk '{print $2}' > ~/org.list

python -c "open('toInst.list', 'w').writelines(set(open('inst.list').\
readlines())-set(open('org.list')))"

while read l;do
    l=$(echo $l | tr -d '\r'|tr -d '\n')
    echo "sudo apt-get install ${l} -y"
    sudo apt-get install ${l} -y
done < toInst.list

rm ~/org.list
rm ~/toInst.list

cd -

