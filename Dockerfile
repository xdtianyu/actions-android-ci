FROM xdtianyu/docker:openjdk8

LABEL "com.github.actions.name"="Android build action"
LABEL "com.github.actions.description"="GitHub Actions for Android build"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="green"

LABEL "repository"="https://github.com/xdtianyu/actions-android-ci"
LABEL "homepage"="https://github.com/xdtianyu/actions-android-ci"
LABEL "maintainer"="xdtianyu"

ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/sdk/emulator/:/opt/sdk/tools/bin:/opt/sdk/tools:/opt/sdk/platform-tools:/opt/ndk:/opt/sdk/cmake/3.10.2.4988404/bin" \
    ANDROID_HOME="/opt/sdk" \
    ANDROID_SDK="/opt/sdk" \
    ANDROID_NDK="/opt/ndk" \
    ANDROID_NDK_HOME="/opt/ndk" \
    GRADLE_USER_HOME="/opt/cache/gradle"

COPY entrypoint.sh /

USER root

ENTRYPOINT [ "/entrypoint.sh" ]
