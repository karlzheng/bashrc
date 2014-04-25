# samba
sudo smbpasswd -a $(whoami)

sudo mkdir -p /4t/samba/personal
sudo chmod 777 /4t/samba/personal
sudo chown $(whoami).$(whoami) /4t/samba/personal

sudo mkdir -p /4t/samba/share
sudo chmod 777 /4t/samba/share
sudo chown $(whoami).$(whoami) /4t/samba/share

sed -e "s#karlzheng#$(whoami)#g" smb.conf > /tmp/tmp.conf

sudo bash -c "cp /etc/samba/smb.conf /etc/samba/smb.conf.org"

sudo bash -c "cat /tmp/tmp.conf >> /etc/samba/smb.conf"

rm /tmp/tmp.conf

sudo service smbd restart
