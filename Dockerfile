ARG NDK_RELEASE=21d
ARG SDK_TOOLS_RELEASE=4333796
FROM notfl3/android-ndk-linux:${NDK_RELEASE}.${SDK_TOOLS_RELEASE}

RUN apt update
RUN apt install -yq curl

ARG RUST_VERSION=1.47.0
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain ${RUST_VERSION}
ENV PATH="/root/.cargo/bin:$PATH"

RUN rustup target add armv7-linux-androideabi
RUN rustup target add aarch64-linux-android
RUN rustup target add i686-linux-android
RUN rustup target add x86_64-linux-android

# Copy contents to container. Should only use this on a clean directory
COPY cargo-apk /root/cargo-apk/

# Install binary
RUN apt install -yq build-essential cmake libssl-dev pkg-config
RUN cargo install --path /root/cargo-apk

# Remove source and build files
RUN rm -rf /root/cargo-apk

# Make directory for user code
RUN mkdir /root/src
WORKDIR /root/src
