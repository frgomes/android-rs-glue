#!/bin/bash -x

NDK_RELEASE=21d
SDK_TOOLS_RELEASE=4333796
RUST_VERSION=1.47.0
CARGO_APK_VERSION=$(cat cargo-apk/Cargo.toml | fgrep 'version =' | tr -d [:blank:] | tr -d '"' | cut -d= -f2)

docker build . --build-arg NDK_RELEASE=${NDK_RELEASE} \
               --build-arg SDK_TOOLS_RELEASE=${SDK_TOOLS_RELEASE} \
               --build-arg RUST_VERSION=${RUST_VERSION} \
               --tag notfl3/cargo-apk:${CARGO_APK_VERSION}
