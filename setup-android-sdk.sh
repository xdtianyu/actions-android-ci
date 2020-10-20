#!/bin/bash

echo $GITHUB_WORKSPACE

SDK=/opt/sdk
NDK=/opt/ndk
GRADLE=/opt/cache/gradle

if [ ! -z "$GITHUB_WORKSPACE" ]; then
    SDK="$GITHUB_WORKSPACE/.opt/sdk"
    NDK="$GITHUB_WORKSPACE/.opt/ndk"
    GRADLE="$GITHUB_WORKSPACE/.opt/cache/gradle"
fi

if [ ! -d "$SDK" ] || [ -z "$(ls -A $SDK)" ];then
    mkdir -p $SDK && cd $SDK
    wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
    unzip -qq sdk-tools-linux-4333796.zip
    rm sdk-tools-linux-4333796.zip
    sync
    mkdir licenses
    echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > licenses/android-sdk-license
    echo "d56f5187479451eabf01fb78af6dfcb131a6481e" >> licenses/android-sdk-license
    echo "24333f8a63b6825ea9c5514f83c2829b004d1fee" >> licenses/android-sdk-license
    echo "84831b9409646a918e30573bab4c9c91346d8abd" > licenses/android-sdk-preview-license

    cd -

fi

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$SDK/emulator/:$SDK/tools/bin:$SDK/tools:$SDK/platform-tools:$NDK:$SDK/cmake/3.10.2.4988404/bin
export ANDROID_HOME=$SDK
export ANDROID_SDK=$SDK
export ANDROID_SDK_ROOT=$SDK
export GRADLE_USER_HOME=$GRADLE
