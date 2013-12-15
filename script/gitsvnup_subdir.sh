
d=$(ls --color=tty -a -d */)

for i in $d;
do
    cd "$i"
    if [ -d ".git" ];then
	local is_svn=$(cat .git/config | grep svn-remote | wc -l)
	if [ $is_svn == 0 ];then
	    git pull
	else
	    gitsvnup
	fi
    fi
    cd ..
done
