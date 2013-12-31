http://wiki.ubuntu.com.cn/Samba

sudo apt-get install samba
sudo smbpasswd -a karlzheng
sudo mkdir /home/share
sudo chmod 777 /home/share

edit /etc/samba/smb.conf
  
    security = user
[Share]
    comment = Shared Folder with username and password
    path = /home/share
    public = yes
    writable = yes
    valid users = karlzheng
    create mask = 0700
    directory mask = 0700
    ;force user = nobody
    force user = karlzheng
    force group = karlzheng
    available = yes
    browseable = yes
    display charset = UTF-8
    unix charset = UTF-8
    dos charset = cp936
