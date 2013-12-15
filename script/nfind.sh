#!/bin/sh

#touch -t 01220800 stamp.tmp && find -newer stamp.tmp -name "*.c" -o  -newer stamp.tmp -name "*.cpp" -o  -newer stamp.tmp -name "*.java" && /bin/rm stamp.tmp |grep -v "/out/target"
touch -t 03030800 stamp.tmp && find -newer stamp.tmp -name "*.h" -o -newer stamp.tmp -name "*.c" -o  -newer stamp.tmp -name "*.cpp" -o  -newer stamp.tmp -name "*.java" && /bin/rm stamp.tmp |grep -v "/out/target"
