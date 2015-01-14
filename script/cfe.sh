#!/bin/bash -
#===============================================================================
#
#          FILE:  cfe.sh
#
#         USAGE:  ./cfe.sh
#
#   DESCRIPTION:
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Karl Zheng (), ZhengKarl#gmail.com
#       COMPANY: Meizu
#       CREATED: 2014年11月03日 10时27分13秒 CST
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

function flash_trx_img()
{
	local dlf=""
	function find_img_file()
	{
		local fn=openwrt-bcm53xx-squashfs-bcm4708-netgear-r6250.trx
		local buildDirFn=build_dir/target-arm-openwrt-linux-uclibcgnueabi/linux-bcm53xx/${fn}
		dlf=${fn}
		if [ ! -f {fn} ];then
			if [ -f ${buildDirFn} ];then
				dlf=${buildDirFn}
			else
				dlf=`find -name ${fn} | head -n 1`
			fi
		fi
	}

	function downloadfw_by_cfe()
	{
		local p=`cat <<-EOF
		-F "Upload=Upload"
		EOF`
		curl -F files=@${dlf} ${p} --referer 'http://192.168.1.1/' \
			http://192.168.1.1/f2.htm
	}

	function downloadfw_by_openwrt()
	{
		local sf="/tmp/luci_session.file"
		curl "http://192.168.1.1/cgi-bin/luci/bs/token" 2>/dev/null > ${sf}
		local token=$(cat ${sf} | json_xs -t yaml |grep token |awk '{print $2}')
		local sysauth=$(cat ${sf} | json_xs -t yaml |grep sysauth |awk '{print $2}')
		echo curl -b "sysauth=${sysauth}; sysauth=" -F f=@${dlf} "http://192.168.1.1/cgi-bin/luci/;stok=${token}/api/localupgrade"
		curl -b "sysauth=${sysauth}; sysauth=" -F f=@${dlf} "http://192.168.1.1/cgi-bin/luci/;stok=${token}/api/localupgrade"
	}

	find_img_file

	if [ "x${dlf}" == "x" ];then
		echo "Not found firmware image in cur dir."
		exit 1;
	fi

	echo "Are you really want to download file: ${dlf} ?"
	read -p "y|n" c
	if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
		wget "http://192.168.1.1/cgi-bin/luci/bs/token" -O /dev/null
		if [ $? == 0 ];then
			downloadfw_by_openwrt
		else
			downloadfw_by_cfe
		fi
	else
		echo "Cancled download!!"
	fi
}

flash_trx_img
