#!/usr/bin/env bash

set -ex

mkdir -p /android
rm -rf /android/*

cd /android
  wget -O tools.zip http://192.168.10.61:8181/commandlinetools-linux-8512546_latest.zip
  unzip tools.zip && rm tools.zip
  chmod a+x -R cmdline-tools
cd -

mkdir -p /android/SDK_ROOT
cd /android/cmdline-tools/bin
  echo y | ./sdkmanager --verbose --sdk_root=/home/logic/Android --licenses
  echo y | ./sdkmanager --verbose --sdk_root=/home/logic/Android "platform-tools"
  echo y | ./sdkmanager --verbose --sdk_root=/home/logic/Android "system-images;android-25;default;x86"
  echo y | ./sdkmanager --verbose --sdk_root=/home/logic/Android "emulator"

  ./sdkmanager --verbose --sdk_root=/home/logic/Android --list
cd -
