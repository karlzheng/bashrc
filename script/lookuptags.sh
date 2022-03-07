#!/bin/bash

# generate tag file for lookupfile plugin
echo "$0 : $(pwd) : parameters:$@"

#cat << EEOOFF > /dev/null
LC_ALL='C'
echo -e '!_TAG_FILE_SORTED\t2\t/2=foldcase/' > filenametags
if [ "x${OS}" = "xOSX" ];then
	if [ -n "$1" ]; then
		find $1 -type d -name '.git' -prune -o -type d -name '.repo' -prune -o ! \
			-regex '.*\.\(class\|zip\|tar\|cmd\|png\|gif\|swp\|o\|tmp\|svn-base\|crf\|d\|\
			svn-work\)' -type f -print | sort -f >> filenametags
	else
		find . -type d -name '.git' -prune -o -type d -name '.repo' -prune -o ! \
			-regex '.*\.\(class\|zip\|tar\|cmd\|png\|gif\|swp\|o\|tmp\|svn-base\|crf\|d\|\
			svn-work\)' -type f -print | sort -f >> filenametags
	fi
else
	if [ -n "$1" ]; then
		find $1 -type d -name '.git' -prune -o -type d -name '.repo' -prune -o ! \
			-regex '.*\.\(class\|zip\|tar\|cmd\|png\|gif\|swp\|o\|tmp\|svn-base\|crf\|d\|\
			svn-work\)' -type f -printf "%f\t%p\t1\n" | sort -f >> filenametags
	else
		find . -type d -name '.git' -prune -o -type d -name '.repo' -prune -o ! \
			-regex '.*\.\(class\|zip\|tar\|cmd\|png\|gif\|swp\|o\|tmp\|svn-base\|crf\|d\|\
			svn-work\)' -type f -printf "%f\t%p\t1\n" | sort -f >> filenametags
	fi
fi
#EEOOFF

#echo -e '!_TAG_FILE_SORTED\t2\t/2=foldcase/' > fullfilenametags

if [ "x${OS}" = "xOSX" ];then
	if [ -n "$1" ]; then
		find $1 -type d -name '.git' -prune -o -type d -name '.repo' -prune -o ! \
			-regex '.*\.\(class\|zip\|tar\|cmd\|png\|gif\|swp\|o\|tmp\|svn-base\|crf\|d\|\
			svn-work\)' -type f -printf "%p\t%p\t1\n" | sort -f >> fullfilenametags
	else
		find $(pwd -P)  -type d -name '.git' -prune -o -type d -name '.repo' -prune \
		    -type d -name 'out' -prune -o ! \
		    -regex '.*\.\(class\|zip\|tar\|cmd\|png\|gif\|swp\|o\|tmp\|svn-base\
		    \|.DS_Store\
		    \|crf\|d\|svn-work\)' -type f | sort -f >> fullfilenametags
	fi
else
	if [ -n "$1" ]; then
		find $1 -type d -name '.git' -prune -o -type d -name '.repo' -prune -o ! \
			-regex '.*\.\(class\|zip\|tar\|cmd\|png\|gif\|swp\|o\|tmp\|svn-base\|crf\|d\|\
			svn-work\)' -type f -printf "%p\t%p\t1\n" | sort -f >> fullfilenametags
	else
		find . -type d -name '.git' -prune -o -type d -name '.repo' -prune -o ! \
			-regex '.*\.\(class\|zip\|tar\|cmd\|png\|gif\|swp\|o\|tmp\|svn-base\|crf\|d\|\
			svn-work\)' -type f -printf "%p\t%p\t1\n" | sort -f >> fullfilenametags
	fi
fi

