#!/bin/bash 

for fn in $(cat /tmp/ff); do
    #echo ${fn};
    findfn=$(find . -name "${fn}")
    if [ "x${findfn}" != "x" ];then
	echo "find ${fn} : ${findfn}"
	cp /tmp/fl/${fn} ${findfn}
    fi
done

#cr=$(pwd)
#for fn in $(cat /tmp/fg); do
    #ed=$(dirname ${fn});
    #cd ${ed}
    #git status -u
    #git add -A
    #git ci -m "update apk from open_apk.git"
    #git push yunos HEAD:tpv_yunos_1.0.0_dev
    #cd -
#done
