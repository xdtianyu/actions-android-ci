FROM openjdk:8-jdk

MAINTAINER ty "xdtianyu@gmail.com"

LABEL "com.github.actions.name"="Android build action"
LABEL "com.github.actions.description"="GitHub Actions for Android build"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="green"

LABEL "repository"="https://github.com/xdtianyu/actions-android-ci"
LABEL "homepage"="https://github.com/xdtianyu/actions-android-ci"
LABEL "maintainer"="xdtianyu"

ENV ANDROID_HOME=/opt/sdk \
    ANDROID_SDK=/opt/sdk \
    ANDROID_NDK=/opt/ndk \
    ANDROID_NDK_HOME=/opt/ndk \
    GRADLE_USER_HOME=/opt/cache/gradle

ADD setup-android-sdk.sh /opt/setup-android-sdk.sh
ADD setup-android-ndk.sh /opt/setup-android-ndk.sh

COPY entrypoint.sh /

USER root

ENTRYPOINT [ "/entrypoint.sh" ]