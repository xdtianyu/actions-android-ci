# Actions-Android-CI

Run Android build with GitHub Actions, checkout [xdtianyu/CallerInfo](https://github.com/xdtianyu/CallerInfo/blob/master/.github/workflows/android.yml) for more usage.

### Usage example 


```yaml
name: Android CI

on: [push]

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v1
    - name: checkout submodule
      run: git submodule sync --recursive && git submodule update --init --recursive
      
    - name: before build
      uses: xdtianyu/actions-android-ci@master
      with:
        args: '"
        . .travis/env.sh;
        touch local.properties
        "'

    - name: build
      uses: xdtianyu/actions-android-ci@master
      with: 
        args: '"
        . .travis/env.sh;
        . /opt/setup-android-sdk.sh;
        ./gradlew assembleDebug
        "'
```
