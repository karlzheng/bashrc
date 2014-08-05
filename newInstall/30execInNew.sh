#!/bin/bash -

#echo "user_allow_other" > /tmp/tmp.txt
#echo "allow_other" >> /tmp/tmp.txt
#sudo bash -c "cat /tmp/tmp.txt >> /etc/fuse.conf
#sudo chmod a+r /etc/fuse.conf

cd /tmp
dpkg -l | grep ^ii |awk '{print $2}' > org.list

#python -c "open('toInst.list', 'w').writelines(set(open('inst.list').\
#readlines())-set(open('org.list')))"
python - << EEOOFF
#!/usr/bin/env python
#encoding:utf8
import sys
def main(argv):
	fd=open('toInst.list', 'w')
	fd.writelines(set(open('inst.list').readlines())-set(open('org.list')))
	fd.close()
if __name__ == '__main__':
	main(sys.argv)
EEOOFF

for l in `cat toInst.list`;do
    l=$(echo ${l} | tr -d '\r'|tr -d '\n')
    echo "sudo apt-get install -y ${l}"
    sudo apt-get install -y ${l}
done

#rm /tmp/org.list
#rm /tmp/toInst.list

cd -
