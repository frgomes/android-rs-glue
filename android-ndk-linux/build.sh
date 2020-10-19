#!/bin/bash

NDK_RELEASE=21d
SDK_TOOLS_RELEASE=4333796

function download_jdk8 {
    if [ ! -d jdk8u265-b01-jre ] ;then
        [[ ! -f OpenJDK8U-jre_x64_linux_hotspot_8u265b01.tar.gz ]] && \
            wget -q https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u265-b01/OpenJDK8U-jre_x64_linux_hotspot_8u265b01.tar.gz
        tar xpzf OpenJDK8U-jre_x64_linux_hotspot_8u265b01.tar.gz
    fi
}
    
function download_sdk_tools {
    if [ ! -d android-sdk-linux-${SDK_TOOLS_RELEASE}/tools ] ;then
        mkdir -p android-sdk-linux-${SDK_TOOLS_RELEASE}
        [[ ! -f sdk-tools-linux-${SDK_TOOLS_RELEASE}.zip ]] && \
            wget -q https://dl.google.com/android/repository/sdk-tools-linux-${SDK_TOOLS_RELEASE}.zip
        pushd android-sdk-linux-${SDK_TOOLS_RELEASE}
        unzip ../sdk-tools-linux-${SDK_TOOLS_RELEASE}.zip
        popd
    fi
}

function download_ndk {
    if [ ! -d android-ndk-r${NDK_RELEASE} ] ;then
        [[ ! -f android-ndk-r${NDK_RELEASE}-linux-x86_64.zip ]] && \
            wget -q http://dl.google.com/android/repository/android-ndk-r${NDK_RELEASE}-linux-x86_64.zip
        unzip android-ndk-r${NDK_RELEASE}-linux-x86_64.zip
    fi
}


download_jdk8 && download_sdk_tools && download_ndk && \
    docker build . --build-arg NDK_RELEASE=${NDK_RELEASE} \
                   --build-arg SDK_TOOLS_RELEASE=${SDK_TOOLS_RELEASE} \
                   --tag notfl3/android-ndk-linux:${NDK_RELEASE}.${SDK_TOOLS_RELEASE}
