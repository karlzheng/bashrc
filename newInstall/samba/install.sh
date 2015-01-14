#!/bin/bash -

if [ -z "${SMBPREDIR}" ];then
	echo "pls set SMBPREDIR var"
	exit;
fi

sudo smbpasswd -a $(whoami)

sudo mkdir -p ${SMBPREDIR}/personal
sudo chmod 777 ${SMBPREDIR}/personal
sudo chown $(whoami).$(whoami) ${SMBPREDIR}/personal

sudo mkdir -p ${SMBPREDIR}/share
sudo chmod 777 ${SMBPREDIR}/share
sudo chown $(whoami).$(whoami) ${SMBPREDIR}/share

sed -e "s#karlzheng#$(whoami)#g" smb.conf > /tmp/tmp.conf

sed -i -e "s#\${SMBPREDIR}#${SMBPREDIR}#g" /tmp/smb.conf

sudo bash -c "cp /etc/samba/smb.conf /etc/samba/smb.conf.org"

sudo bash -c "cat /tmp/tmp.conf >> /etc/samba/smb.conf"

rm /tmp/tmp.conf

sudo service smbd restart
