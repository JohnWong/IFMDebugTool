#!/bin/sh

#echo $1
# PWD是被修改文件的所在目录
PWD=`pwd`
echo $PWD

OUTFILE=`ps -ax | grep "Library/Developer/CoreSimulator/Devices" | grep -iE 'iOSFileManager' | awk '{ print $NF }'`
while read execfile; do 
	#SIM_DIR="$(dirname "$(dirname "$execfile")")"
	APP_DIR="$(dirname "$execfile")"
done<<EOF
$OUTFILE
EOF

#echo $APP_DIR
cp -rf "$PWD/$1" "$APP_DIR/Web"

