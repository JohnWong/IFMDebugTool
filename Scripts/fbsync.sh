#!/bin/sh

#echo $1
# PWD是被修改文件的所在目录
PWD=`pwd`
echo $PWD

#cd ~
OUTFILE=`ps -ax | grep "Library/Developer" | grep -iE 'iOSFileManager' | awk '{ print $NF }'`
while read execfile; do 
	#SIM_DIR="$(dirname "$(dirname "$execfile")")"
	APP_DIR="$(dirname "$execfile")"
done<<EOF
$OUTFILE
EOF

#echo $APP_DIR
cp -f "$PWD/$1" "$APP_DIR/Web/"

echo "cp -f $PWD/$1 $APP_DIR/Web/">~/Desktop/1.txt
