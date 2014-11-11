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


function download_cfe()
{
	local fn=openwrt-bcm53xx-squashfs-bcm4708-netgear-r6250.trx
	local buildDirFn=build_dir/target-arm-openwrt-linux-uclibcgnueabi/${fn}
	local dlf=${fn}
	if [ ! -f {fn} ];then
		if [ -f ${buildDirFn} ];then
			dlf=${buildDirFn}
		else
			dlf=`find -name ${fn} | head -n 1`
		fi
	fi

	if [ "x${dlf}" == "x" ];then
		echo "Not found ${fn}"
		exit 1;
	fi
	echo "Are you really want to download file: ${dlf} ?"
	#-F "Upload=Upload" --user-agent "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:32.0) Gecko/20100101 Firefox/32.0"
	read -p "y|n" c
	if [ "x${c}" == "xy" -o "x${c}" == "xY" -o "x${c}" == "x" ];then
		local p=`cat <<-EOF
		-F "Upload=Upload"
		EOF`
		curl -F files=@${dlf} ${p} --referer 'http://192.168.1.1/' \
			http://192.168.1.1/f2.htm 
	else
		echo "Cancled download!!"
	fi
}

download_cfe
