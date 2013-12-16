#!/bin/bash
#https://github.com/yajin/360-wifi-linux

export LANG='en_US.UTF-8'

WIFI_HOME=/dev/shm/hostapd

in_interface=wlan0
out_interface=eth0
key=98765432

rfkill list | grep Wireless -A 3 | grep -q yes
[ $? -eq 0 ] && echo "exec rfkill unblock wifi" && rfkill unblock wifi

if [ -f /dev/shm/dhcpd.$in_interface.conf ]; then
    sudo rm /dev/shm/dhcpd.$in_interface.conf
fi

ip_prefix=`ifconfig ${out_interface} | grep "inet addr" | awk -F: '{print $2}' | awk -F. '{print $1}'`
case ${ip_prefix} in
    "10")
        ip_prefix="172.16"
        ;;
    "172")
        ip_prefix="192.168"
        ;;
    "192")
        ip_prefix="10.0"
        ;;
    "")
        echo '!are you sure you have connected to internet'
        ;;
    *)
        ip_prefix="10.0"
        ;;
esac
subnet="${ip_prefix}.9"
echo "default-lease-time 600;
max-lease-time 7200;
log-facility local7;
subnet ${subnet}.0 netmask 255.255.255.0 {
    range ${subnet}.100 ${subnet}.200;
    option domain-name-servers 8.8.8.8;
    option routers ${subnet}.1;
    default-lease-time 600;
    max-lease-time 7200;
}" | sudo tee  /dev/shm/dhcpd.$in_interface.conf > /dev/null
sudo ifconfig $in_interface ${subnet}.1 up
sudo dhcpd -q -cf /dev/shm/dhcpd.$in_interface.conf -pf /var/run/dhcp-server/dhcpd.pid  $in_interface

forward=$(cat  /proc/sys/net/ipv4/ip_forward)
if [ $forward -eq "0" ]; then
    echo 1  | sudo tee  /proc/sys/net/ipv4/ip_forward
fi
sudo iptables -F
sudo iptables -t nat -F
sudo iptables -t nat -A POSTROUTING -s ${subnet}.0/24 -o $out_interface -j MASQUERADE
sudo iptables -A FORWARD -s ${subnet}.0/24 -o $out_interface -j ACCEPT
sudo iptables -A FORWARD -d ${subnet}.0/24 -m conntrack --ctstate ESTABLISHED,RELATED -i $out_interface -j ACCEPT

echo "[*] Setting hostapd ... "

ssid=`hostname`-hostapd
echo "****  SSID : $ssid, key: $key. Enjoy! ****"
function clean_up {
    echo "[*] Cleaning up ..."
    if [ -f /var/run/dhcp-server/dhcpd.pid ]; then
        dhcpd_pid=$(cat /var/run/dhcp-server/dhcpd.pid)
        sudo kill -9 $dhcpd_pid > /dev/null
    fi
}

trap 'clean_up;echo "Goodbye"' SIGINT SIGTERM SIGQUIT SIGKILL

if [ ! -d $WIFI_HOME ]; then
    mkdir $WIFI_HOME
fi

if [ -f $WIFI_HOME/.hostapd.$in_interface.conf ]; then
    rm $WIFI_HOME/.hostapd.$in_interface.conf
fi

echo "interface=$in_interface
driver=nl80211
ssid=$ssid
hw_mode=g
channel=1
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=3
wpa_passphrase=$key
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP" | tee  $WIFI_HOME/.hostapd.$in_interface.conf > /dev/null

# sudo hostapd $WIFI_HOME/.hostapd.$in_interface.conf  -P $WIFI_HOME/.hostapd.$in_interface.pid -B
sudo hostapd $WIFI_HOME/.hostapd.$in_interface.conf > /dev/null
