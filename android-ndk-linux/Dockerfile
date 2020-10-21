FROM debian:10.6-slim

# install minimalist set of X11 client applications
RUN apt update && apt install -qy x11-apps && rm -rf /var/lib/apt/lists/*

# Install openjdk-8-jre
COPY jdk8u265-b01-jre /opt/jdk8u265-b01-jre/
ENV JAVA_HOME=/opt/jdk8u265-b01-jre
ENV PATH="${PATH}:/opt/jdk8u265-b01-jre/bin"
 
 ##
## Receive configurations from build process
##
ARG NDK_RELEASE=21d
ARG SDK_TOOLS_RELEASE=4333796
ARG SDK_PLATFORMS="30.0.2"
ARG SDK_PACKAGES="cmdline-tools 3.0:cmake;3.10.2.4988404 emulator platform-tools add-ons;addon-google_apis-google-24"


# Install Android SDK
ENV ANDROID_HOME=/opt/android-sdk-linux-${SDK_TOOLS_RELEASE}
COPY android-sdk-linux-${SDK_TOOLS_RELEASE} ${ANDROID_HOME}/
ENV PATH="${PATH}:/opt/android-sdk-linux-${SDK_TOOLS_RELEASE}/tools/bin"

RUN chown -R root:root /opt

# Configure Android SDK
RUN sdkmanager --list && \
    for pkg in ${SDK_PACKAGES} ;do \
      yes | sdkmanager "${pkg}" | grep -v = || true ; \
    done && \
    for api in ${SDK_PLATFORMS} ;do \
      major=$(echo ${api} | cut -d. -f1) ; \
      yes | sdkmanager "build-tools;${api}" | grep -v = || true ; \
      yes | sdkmanager "platforms;android-${major}" | grep -v = || true ; \
    done && \
    sdkmanager --update | grep -v = || true

# Install Android NDK
COPY android-ndk-r${NDK_RELEASE} ${NDK_HOME}/
ENV NDK_HOME=/usr/local/android-ndk-r${NDK_RELEASE}

 ##
## Receive configurations from build process
##
## List of devices to be installed, separated by commas
ARG SDK_DEVICES="Nexus 6P,Pixel XL"

## RUN HWPLATFORM=$(uname -m | tr [:upper:] [:lower:]) ; \
##     echo ${SDK_DEVICES} | tr ',' '\n' | while read device ;do \
##       for api in ${SDK_PLATFORMS} ;do \
##         major=$(echo ${api} | cut -d. -f1) ; \
##         avdmanager create avd \
##           --name "${device} / ${major}" \
##           --device "${device}" \
##           --force \
##           --abi google_apis/${HWPLATFORM} \
##           --package \'system-images;android-${major};google_apis;${HWPLATFORM}\' ; \
##       done
##     done
