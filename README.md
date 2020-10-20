# Actions-Android-CI

Run Android build with GitHub Actions, checkout [xdtianyu/CallerInfo](https://github.com/xdtianyu/CallerInfo/blob/master/.github/workflows/android.yml) for more usage.

![](https://raw.githubusercontent.com/xdtianyu/actions-android-ci/master/art/screenshot.png)

### Usage example 

This example configure can build android app in ~2min with gradle and sdk cache.

```yaml
name: Android CI

on: [push]

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - name: Checkout
      uses: actions/checkout@v1

    - name: Checkout submodule
      run: git submodule sync --recursive && git submodule update --init --recursive

    - name: Before build
      uses: xdtianyu/actions-android-ci@master
      env:
        ENCRYPTED_KEY: ${{ secrets.ENCRYPTED_KEY }}
        ENCRYPTED_IV: ${{ secrets.ENCRYPTED_IV }}
      with:
        args: '"
        . ./env.sh;
        openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in secrets.tar.enc -out secrets.tar -d;
        tar xvf secrets.tar;
        touch local.properties
        "'

    - name: Cache gradle and sdk
      uses: actions/cache@v2
      env:
        cache-name: cache-gradle-and-sdk
      with:
        path: |
          ${{ github.workspace }}/.opt/cache/gradle/wrapper
          ${{ github.workspace }}/.opt/cache/gradle/caches
          ${{ github.workspace }}/.opt/sdk
        key: ${{ runner.os }}-build-${{ env.cache-name }}-${{ hashFiles('**/wrapper/gradle-wrapper.properties', '**/build.gradle') }}
        restore-keys: |
          ${{ runner.os }}-build-${{ env.cache-name }}-
          ${{ runner.os }}-build-
          ${{ runner.os }}-

    - name: Build
      uses: xdtianyu/actions-android-ci@master
      env:
        ENCRYPTED_KEY: ${{ secrets.ENCRYPTED_KEY }}
        ENCRYPTED_IV: ${{ secrets.ENCRYPTED_IV }}
        ALIAS: ${{ secrets.ALIAS }}
        ALIAS_PASSWORD: ${{ secrets.ALIAS_PASSWORD }}
        KEYSTORE_PASSWORD: ${{ secrets.KEYSTORE_PASSWORD }}
      with:
        args: '"
        umask 000;
        . ./env.sh;
        . /opt/setup-android-sdk.sh;
        ./gradlew assembleRelease
        "'

    - name: Upload artifacts
      uses: actions/upload-artifact@v2
      with:
        name: artifacts
        path: |
          app/**/apk/release/*
          app/**/mapping/release/mapping.txt

```
