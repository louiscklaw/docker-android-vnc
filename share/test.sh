#!/usr/bin/env bash

set -ex

ANDROID_HOME=/android


cd /android/cmdline-tools/bin
  # ./avdmanager -v list
  ./avdmanager -v create avd -f -n test_nexus -k 'system-images;android-25;default;x86' -p /root
cd -

