#!/bin/bash

VERSION=r17b

echo $GITHUB_WORKSPACE

SDK=/opt/sdk
NDK=/opt/ndk

if [ ! -z "$GITHUB_WORKSPACE" ]; then
    SDK="$GITHUB_WORKSPACE/.opt/sdk"
    NDK="$GITHUB_WORKSPACE/.opt/ndk"
fi


if [ ! -d "$NDK" ] || [ -z "$(ls -A $NDK)" ];then
    mkdir -p $NDK && cd $NDK
    wget "https://dl.google.com/android/repository/android-ndk-$VERSION-linux-x86_64.zip"
    unzip -qq "android-ndk-$VERSION-linux-x86_64.zip"
    mv "android-ndk-$VERSION/"* .
    rm "android-ndk-$VERSION-linux-x86_64.zip"
    rm -r "android-ndk-$VERSION/"
    cd -
fi

export ANDROID_NDK=$NDK
export ANDROID_NDK_HOME=$NDK
