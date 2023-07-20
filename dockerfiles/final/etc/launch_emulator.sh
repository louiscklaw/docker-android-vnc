#!/usr/bin/env bash

set -x

/root/Android/emulator/emulator \
  -avd test_nexus \
  -sysdir $ANDROID_HOME/system-images/android-$ANDROID_API_LEVEL/default/x86/

# bash
