#!/bin/sh --
# generate tag file for lookupfile plugin
#echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > filenametags
#find /root/source/android2.0/eclair -not -regex '.*\.\(png\|o\|gif\)' -type f -printf "%f\t%p\t1\n" | \
#    sort -f >> filenametags 
#
#!/bin/sh
# generate tag file for lookupfile plugin
#echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > filenametags
#echo -e '!_TAG_FILE_SORTED\t2\t/2=foldcase/' > filenametags

echo "$0 : $(pwd) : parameters:$@"
#cat << EEOOFF > /dev/null
echo -e '!_TAG_FILE_SORTED\t2\t/2=foldcase/' > filenametags
if [ -n "$1" ]; then
    find $1 ! -regex '.*\.\(class\|zip\|tar\|cmd\|png\|gif\|swp\|o\|tmp\|svn-base\|svn-work\)' -type f -printf "%f\t%p\t1\n" | \
        sort -f >> filenametags 
else
    find . ! -regex '.*\.\(class\|zip\|tar\|cmd\|png\|gif\|swp\|o\|tmp\|svn-base\|svn-work\)' -type f -printf "%f\t%p\t1\n" | \
        sort -f >> filenametags 
fi
#EEOOFF

echo -e '!_TAG_FILE_SORTED\t2\t/2=foldcase/' > fullfilenametags
if [ -n "$1" ]; then
    find $1 ! -regex '.*\.\(class\|zip\|tar\|cmd\|png\|gif\|swp\|o\|tmp\|svn-base\|svn-work\)' -type f -printf "%p\t%p\t1\n" | \
        sort -f >> fullfilenametags 
else
find . ! -regex '.*\.\(class\|zip\|tar\|cmd\|png\|gif\|swp\|o\|tmp\|svn-base\|svn-work\)' -type f -printf "%p\t%p\t1\n" | \
        sort -f >> fullfilenametags 
fi
