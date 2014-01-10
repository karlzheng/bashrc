sudo cp udev_rules.d/* /etc/udev/rules.d/

# samba
sudo smbpasswd -a $(whoami)

sudo mkdir -p /home/personal
sudo chmod 777 /home/personal
sudo chown $(whoami).$(whoami) /home/personal

sudo mkdir -p /home/share
sudo chmod 777 /home/share
sudo chown $(whoami).$(whoami) /home/share

cat << EEOOFF > /tmp/tmp.conf
    security = user
[personal]
    comment = personalFolder
    path = /home/personal
    public = yes
    writable = yes
    create mask = 0700
    directory mask = 0700
    ;force user = nobody
    available = yes
    browseable = yes
    display charset = UTF-8
    unix charset = UTF-8
    dos charset = cp936
EEOOFF
echo "    valid users = $(whoami)" >> /tmp/tmp.conf
echo "    force user = $(whoami)" >> /tmp/tmp.conf
echo "    force group = $(whoami)" >> /tmp/tmp.conf

cat << EEOOFF >> /tmp/tmp.conf
[share]
    comment = publicShare
    path = /home/share
    read only = no
    public = yes
    guest ok = yes
EEOOFF
echo "    force user = $(whoami)" >> /tmp/tmp.conf
echo "    force group = $(whoami)" >> /tmp/tmp.conf

sudo bash -c "cat /tmp/tmp.conf >> /etc/samba/smb.conf"

rm /tmp/tmp.conf

sudo service smbd restart

cat /etc/group | grep -q vboxusers
if [ $? == 0 ];then
    sudo adduser $(whoami) vboxusers
fi
