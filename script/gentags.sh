#!/bin/sh

#echo "begin gtags"
#cp cscope.files gtags.files
#gtags -f gtags.files
#echo "end gtags"

echo "begin ctags"
echo "$0 : $(pwd) : parameters:$@"
if [ -n "$1" ]; then
    #ctags -R $1
	ctags -R --links=no --fields=+lS $1
	#echo "skip ctags"
else
    #ctags -R --c++-kinds=+p --c-kinds=+p --fields=+iaS --extra=+q
	ctags -R --links=no --c++-kinds=+p --c-kinds=+p --fields=+ialS --extra=+q
	#echo "skip ctags"
fi
echo "end ctags"

