#!/bin/bash

#http://forum.ubuntu.org.cn/viewtopic.php?t=445579
#https://github.com/yajin/360-wifi-linux

if [ $# -eq 0 ];then
	WLANID=wlan0
else
	WLANID=$1
fi
echo $WLANID

iw list | grep -q '* AP'
[ $? -ne 0 ] && echo "No device support AP mode." && exit

rfkill list | grep Wireless -A 3 | grep -q yes
[ $? -eq 0 ] && echo "exec rfkill unblock wifi" && rfkill unblock wifi

sudo ifconfig ${WLANID} 192.168.178.1 netmask 255.255.255.0
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -j MASQUERADE
sudo pkill -9 dhcpd

if [ ! -f /etc/apparmor.d/disable/usr.sbin.dhcpd ]; then
sudo ln -s /etc/apparmor.d/usr.sbin.dhcpd /etc/apparmor.d/disable/
sudo /etc/init.d/apparmor restart
fi

cat > /dev/shm/dhcpd.conf << EOF
default-lease-time 600;
max-lease-time 7200;
subnet 192.168.178.0 netmask 255.255.255.0
{
    range 192.168.178.2 192.168.178.250;
    option domain-name-servers 8.8.8.8;
    option routers 192.168.178.1;
}
EOF
sudo dhcpd ${WLANID} -cf /dev/shm/dhcpd.conf -pf /var/run/dhcp-server/dhcpd.pid

cat > /dev/shm/hostapd.conf << EOF
interface=${WLANID}
driver=nl80211
#ssid=`hostname`-hostapd
ssid=mypc-hostapd
#ssid=pc-hostapd
hw_mode=g
#channel=11
channel=7
auth_algs=1
ignore_broadcast_ssid=0
#ignore_broadcast_ssid=1
#wpa=1 for request password
#wpa=1
wpa=0
wpa_passphrase=98765432
#wpa_passphrase=23456789
wpa_key_mgmt=WPA-PSK
wpa_pairwise=CCMP TKIP
rsn_pairwise=CCMP TKIP
EOF

sudo hostapd -dd /dev/shm/hostapd.conf > /tmp/hostapd.log
