#!/usr/bin/env bash

set -x

# rm -rf cmdline-tools
rm -rf Android
rm -rf emulator
rm -rf .knownPackages
rm -rf licenses
rm -rf patcher
rm -rf platforms
rm -rf platform-tools
rm -rf system-images
rm -rf .temp

# android sdk home
export ANDROID_HOME=$HOME/Android
export ANDROID_SDK_ROOT=$HOME/Android
export ANDROID_USER_HOME=$HOME/.android

export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/bin

yes | sdkmanager --verbose --sdk_root=$ANDROID_HOME --licenses
echo y | sdkmanager --verbose --sdk_root=$ANDROID_HOME "platform-tools" "emulator"
echo y | sdkmanager --verbose --sdk_root=$ANDROID_HOME "system-images;android-25;default;x86"
sdkmanager --verbose --sdk_root=$ANDROID_HOME --list

mkdir platforms

avdmanager list avd
avdmanager -v delete avd -n test_nexus
echo no | avdmanager -v create avd -f -n test_nexus -k 'system-images;android-25;default;x86' 

./emulator -avd test_nexus -sysdir $ANDROID_HOME/system-images/android-25/default/x86/
