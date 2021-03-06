#!/bin/bash -

#GIT_STATUS_LOG_FILE=/dev/shm/gitstatus.log
#GIT_DIFF_FILES=/dev/shm/difffiles.log

GIT_STATUS_LOG_FILE=/tmp/gitstatus.log
GIT_DIFF_FILES=/tmp/difffiles.log

if [ $# -ge 1 ];then
	tmp_file_name="$1"
else
	date_str="$(date +%Y%m%d_%T|tr -d ':')"
	tmp_file_name=git_diff_$date_str".tar"
fi

git status -u > $GIT_STATUS_LOG_FILE

# remove the '#' char at line begin.
sed -i -e 's/^#\(.*\)/\1/' $GIT_STATUS_LOG_FILE

: > $GIT_DIFF_FILES

sed -ne "/\t/p" $GIT_STATUS_LOG_FILE | grep "both modified:" | awk '{print $3}' \
    | grep -Ev '^$' >> $GIT_DIFF_FILES
sed -ne "/\t/p" $GIT_STATUS_LOG_FILE | grep modified: | awk '{print $2}' \
    | grep -Ev '^$' >> $GIT_DIFF_FILES
sed -ne "/\t/p" $GIT_STATUS_LOG_FILE | grep "修改：" | awk '{print $2}' \
    | grep -Ev '^$' >> $GIT_DIFF_FILES
sed -ne "/\t/p" $GIT_STATUS_LOG_FILE | grep "new file:" | awk '{print $3}' \
    | grep -Ev '^$' >> $GIT_DIFF_FILES
sed -ne "/\t/p" $GIT_STATUS_LOG_FILE | grep -v "new file:" | grep -v modified: \
    | grep -v "deleted:" | awk '{print $1}' | grep -Ev '^$' >> $GIT_DIFF_FILES

echo -e "save uncommit files:\n"
cat $GIT_DIFF_FILES

if [ -f .config ];then
    tar rf $tmp_file_name .config
fi

while read l;
do
	if [ "x$l" != "x" ];then
		if [ -f "$l" -o -d "$l" ];then
			tar rf $tmp_file_name "$l"
		fi
	fi
done < $GIT_DIFF_FILES

#rm $GIT_DIFF_FILES
#rm $GIT_STATUS_LOG_FILE

echo -e "\nsave the modified files to tar file: "$tmp_file_name"\n"
