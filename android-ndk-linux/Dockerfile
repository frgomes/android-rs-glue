FROM debian:10.6-slim

ARG NDK_RELEASE=21d
ARG SDK_TOOLS_RELEASE=4333796

# Install openjdk-8-jre
COPY jdk8u265-b01-jre /opt/jdk8u265-b01-jre/
ENV JAVA_HOME=/opt/jdk8u265-b01-jre
ENV PATH="/opt/jdk8u265-b01-jre/bin:${PATH}"
 
# Install Android SDK
ENV ANDROID_HOME=/opt/android-sdk-linux-${SDK_TOOLS_RELEASE}
COPY android-sdk-linux-${SDK_TOOLS_RELEASE} ${ANDROID_HOME}/
RUN chown -R root:root /opt
RUN yes | ${ANDROID_HOME}/tools/bin/sdkmanager "platform-tools" | grep -v = || true
RUN yes | ${ANDROID_HOME}/tools/bin/sdkmanager "platforms;android-29" | grep -v = || true
RUN yes | ${ANDROID_HOME}/tools/bin/sdkmanager "build-tools;29.0.0"  | grep -v = || true
RUN ${ANDROID_HOME}/tools/bin/sdkmanager --update | grep -v = || true
 
# Install Android NDK
ENV NDK_HOME=/usr/local/android-ndk-r${NDK_RELEASE}
COPY android-ndk-r${NDK_RELEASE} ${NDK_HOME}/
