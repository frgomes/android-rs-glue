#!/bin/bash -x

###################################################
## DO NOT CHANGE ANY DEFAULT VALUES IN THIS FILE. #
## Define environment variables like this:        #
##   $ source ./versions.sh                       #
###################################################
DOCKERHUB_LOGIN=${DOCKERHUB_LOGIN:-notfl3}
NDK_RELEASE=${NDK_RELEASE:-21d}
SDK_TOOLS_RELEASE=${SDK_TOOLS_RELEASE:-4333796}
RUST_VERSION=${RUST_VERSION:-1.47.0}

CARGO_APK_VERSION=$(cat cargo-apk/Cargo.toml | fgrep 'version =' | tr -d [:blank:] | tr -d '"' | cut -d= -f2)

docker build . --build-arg NDK_RELEASE=${NDK_RELEASE} \
               --build-arg SDK_TOOLS_RELEASE=${SDK_TOOLS_RELEASE} \
               --build-arg RUST_VERSION=${RUST_VERSION} \
               --tag ${DOCKERHUB_LOGIN}/cargo-apk:${CARGO_APK_VERSION} \
               --tag ${DOCKERHUB_LOGIN}/cargo-apk:latest
