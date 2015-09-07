#!/bin/sh

# xcode script
# "${SRCROOT}/Scripts/fbwatch.sh"

PWD=`pwd`

if [[ -f /usr/local/bin/watchman ]]; then 

#if hash /usr/local/bin/watchman > /dev/null; then
    /usr/local/bin/watchman trigger-del ${PWD}/iOSFileManager/Web/ bundle
    /usr/local/bin/watchman watch ${PWD}/iOSFileManager/Web/
    /usr/local/bin/watchman -- trigger ${PWD}/iOSFileManager/Web/ bundle '*' -- ${PWD}/Scripts/fbsync.sh
else
    echo "error: please install 'watchman' first: brew install watchman"
fi

