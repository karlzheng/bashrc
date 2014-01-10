sudo cp udev_rules.d/* /etc/udev/rules.d/

# samba
sudo smbpasswd -a $(whoami)

sudo mkdir -p /home/personal
sudo chmod 777 /home/personal
sudo chown $(whoami).$(whoami) /home/personal

sudo mkdir -p /home/share
sudo chmod 777 /home/share
sudo chown $(whoami).$(whoami) /home/share

sed -e "s#karlzheng#$(whoami)#g" samba/smb.conf > /tmp/tmp.conf

sudo bash -c "cat /tmp/tmp.conf >> /etc/samba/smb.conf"

rm /tmp/tmp.conf

sudo service smbd restart

cat /etc/group | grep -q vboxusers
if [ $? == 0 ];then
    sudo adduser $(whoami) vboxusers
fi
