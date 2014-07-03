#!/bin/sh

if [ "$1" = "--help" ]; then
echo "gdb script run on pc"
echo "start gdbserver on device or emulator first"
echo "	gdbserver :2000 --attach pid"
echo "or"
echo "	gdbserver :2000 cmd"
echo ""
echo "change file to app_process in .gdbinit when debug application"
exit
fi

ADB=adb
BASE=$(pwd)

if [ -z "$TARGET_PRODUCT" ]; then
	PRODUCT=$(basename $(dirname `ls -d ${BASE}/out/target/product/*/system`))
else
	PRODUCT=`echo $TARGET_PRODUCT | sed -e "s/_/ /g" | awk '{print $2}'`
fi

if [ -z "${GDB}" ];then
	GCC_4_4_0="$BASE/prebuilt/linux-x86/toolchain/arm-eabi-4.4.0"
	GCC_4_4_3="$BASE/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3"
	GCC_4_4_x="$BASE/prebuilt/linux-x86/toolchain/arm-linux-androideabi-4.4.x"
	GCC_4_6="$BASE/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.6"
	if [ -e "$GCC_4_6/bin/arm-linux-androideabi-gdb" ]; then
		GDB="$GCC_4_6/bin/arm-linux-androideabi-gdb"
	elif [ -e "$GCC_4_4_x/bin/arm-linux-androideabi-gdb" ]; then
		GDB="$GCC_4_4_x/bin/arm-linux-androideabi-gdb"
	elif [ -e "$GCC_4_4_3/bin/arm-eabi-gdb" ]; then
		GDB="$GCC_4_4_3/bin/arm-eabi-gdb"
	else
		GDB="$GCC_4_4_0/bin/arm-eabi-gdb"
	fi
fi

#SYMBOL_DIR="$BASE/out/target/product/$PRODUCT/symbols"
SYMBOL_DIR="out/target/product/$PRODUCT/symbols"

if [ -z "$APPNAME" ]; then
	APPNAME="$SYMBOL_DIR/system/bin/app_process"
else
	APPNAME="$SYMBOL_DIR/system/bin/${APPNAME}"
fi

if [ -e ".gdbinit" ]; then
	echo ".gdbinit found"
else
	echo ".gdbinit missing"
	echo "file  $APPNAME" > .gdbinit
	echo "set solib-absolute-prefix $SYMBOL_DIR" >> .gdbinit
	echo "set solib-search-path $SYMBOL_DIR/system/lib" >> .gdbinit
	echo "target remote :2000"		>> .gdbinit
	echo "shared"				>> .gdbinit
	echo ".gdbinit created, run this gdb script again"
	exit
fi

echo "use gdb $GDB"
echo "========================================="

echo "adb forward tcp:2000 tcp:2000"
adb forward tcp:2000 tcp:2000
echo "$GDB"
$GDB
