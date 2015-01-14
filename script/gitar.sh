#!/bin/bash -

GIT_STATUS_LOG_FILE=/dev/shm/gitstatus.log
GIT_DIFF_FILES=/dev/shm/difffiles.log

GIT_STATUS_LOG_FILE=gitstatus.log
GIT_DIFF_FILES=difffiles.log

if [ $# -ge 1 ];then
	tmp_file_name="$1"
else
	date_str="$(date +%Y%m%d_%T|tr -d ':')"
	tmp_file_name=git_diff_$date_str".tar"
fi

git status > $GIT_STATUS_LOG_FILE

: >> $GIT_DIFF_FILES

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

tar rf $tmp_file_name $GIT_STATUS_LOG_FILE
tar rf $tmp_file_name $GIT_DIFF_FILES

while read l;
do
	if [ "x$l" != "x" ];then
		if [ -f "$l" -o -d "$l" ];then
			tar rf $tmp_file_name "$l"
		fi
	fi
done < $GIT_DIFF_FILES

echo -e "\nsave the modified files to tar file: "$tmp_file_name"\n"
