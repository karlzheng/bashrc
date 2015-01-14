#! /bin/sh

# This demo script will find the modified files in your project,
# and generate a ctags file and cscope database for these files.
# This script is NOT tested yet!
# by Easwy Yang, 2009/03/29

PRJ_DIR="$(pwd)"
echo "PRJ_DIR:$PRJ_DIR"
PRJ_TAG_FILE=${PRJ_DIR}/tags
PRJ_MOD_TAG_FILE=${PRJ_DIR}/newtags
PRJ_MOD_CSCOPE_FILE=${PRJ_DIR}/newcscope.out
MOD_FILES=${PRJ_DIR}/modify.files

FIND=/usr/bin/find
CTAGS=/usr/bin/ctags
CSCOPE=/usr/bin/cscope

#if [ -f ${MOD_FILES} ];then
	#${FIND} ${PRJ_DIR} -type f -newer ${PRJ_TAG_FILE} > ${MOD_FILES}
	#${FIND} . -type f -newer ${PRJ_TAG_FILE} > ${MOD_FILES}
	touch ${MOD_FILES}
    find . -regex '.*\.\(c\|cpp\|h\|hpp\|java\)' -type f -newer tags > ${MOD_FILES}
    cat ${MOD_FILES} | sort -f | uniq > ${MOD_FILES}.$$
    mv ${MOD_FILES}.$$ ${MOD_FILES}
	#echo "$1" >> ${MOD_FILES} && mv ${MOD_FILES} ${MOD_FILES}".tmp" && sort ${MOD_FILES}".tmp" | uniq > "${MOD_FILES}" && rm ${MOD_FILES}".tmp"

	# find modified files
	# you can modify this command to exclude the object files, etc.
	#${FIND} ${PRJ_DIR} -type f -newer ${PRJ_TAG_FILE} > ${MOD_FILES}

	# generate tag file
	${CTAGS} -f${PRJ_MOD_TAG_FILE} -L${MOD_FILES}
	${CSCOPE} -bq -f${PRJ_MOD_CSCOPE_FILE} -i${MOD_FILES}
#fi
