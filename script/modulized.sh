#!/bin/bash - 

function rootfiles_process()
{
	local projectname=bes1400
	if [ $# -ge 1 ];then
		projectname=$1
	fi
	echo $projectname
	return
	local tmp_dir="/tmp/tmp_dir"
	local cur_dir=$(pwd)

	#1. get cur branch;
	local cbr=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)

	#2. mkdir rootfiles
	#list root files and move to rootfiles dir;
	mkdir -p rootfiles
	local rfs=$(find . -maxdepth 1 -type f)
	for f in ${rfs}; do
		echo ${f};
		/bin/cp ${f} rootfiles
	done

	#3. cd rootfiles, init git dir and push;
	cd rootfiles
	git init .
	git add -A -f
	git commit -m "add ${cbr} branch"
	git push --set-upstream https://git.anker-in.com/hp/${projectname}m/rootfiles.git master:${cbr}
	cd ..
	/bin/rm  -rf rootfiles

	#4. get dirs => git subtree and push
	local d
	local dirs=$(ls -G -a -d */ |grep -v git)
	for d in ${dirs}; do 
		d=${d%%/}
		git subtree split -P $d -b ${d}_${cbr};

		mkdir -p ${tmp_dir};
		cd ${tmp_dir};
		git init .
		git pull ${cur_dir} ${d}_${cbr};
		git push --set-upstream https://git.anker-in.com/hp/${projectname}m/$d.git master:${cbr}
		cd ${cur_dir}
		/bin/rm -rf ${tmp_dir}
		git branch -D ${d}_${cbr};
	done

	#5. gen manifests git and push

cat>default.xml<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
	<remote  name="${projectname}m" fetch="https://git.anker-in.com/hp/${projectname}m/" review="https://android-review.googlesource.com/" />
	<default remote="${projectname}m" revision="${cbr}" />
	<project name="apps" path="apps" > </project>
	<project name="config" path="config" > </project>
	<project name="include" path="include" > </project>
	<project name="platform" path="platform" > </project>
	<project name="rtos" path="rtos" > </project>
	<project name="scripts" path="scripts" > </project>
	<project name="services" path="services" > </project>
	<project name="tests" path="tests" > </project>
	<project name="utils" path="utils" > </project>
	<project name="rootfiles" path="rootfiles" > 
EOF

	for f in ${rfs}; do
		echo ${f};
		echo -e "\t\t"'<copyfile dest="'${f}'" src="'${f}'"/>' >> default.xml
	done

cat>>default.xml<<EOF
	</project>
</manifest>
EOF

	mkdir -p ${tmp_dir};
	/bin/mv default.xml ${tmp_dir};
	echo cd ${tmp_dir};
	cd ${tmp_dir};
	git init .
	git add -A -f
	git commit -m "add ${cbr} branch"
	git push --set-upstream https://git.anker-in.com/hp/${projectname}m/manifests.git master:${cbr}
	echo cd ${cur_dir}
	cd ${cur_dir}
	/bin/rm -rf ${tmp_dir}
}

projectname=bes1400

if [ $# -ge 1 ];then
	projectname=$1
fi

rootfiles_process ${projectname}

