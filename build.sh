#!/usr/bin/env bash

set -x

ANDROID_API_LEVEL=26
SCREEN_RESOLUTION=1920x1080

docker rmi openbox-android

set -ex

# build openbox as base
cd dockerfiles/ubuntu
  docker build . -t openbox-android
cd -

  # build openbox as base
  cd dockerfiles/openbox
    docker build . -t openbox-android
  cd -

  # build appium
  cd dockerfiles/appium
    docker build . -t openbox-android
  cd -

  cd dockerfiles/noVNC
    docker build . -t openbox-android
  cd -

  # build android emulator
  cd dockerfiles/android
    docker build -f dockerfile.base . \
      --build-arg="ANDROID_API_LEVEL=$ANDROID_API_LEVEL" \
      --build-arg="SCREEN_RESOLUTION=$SCREEN_RESOLUTION" \
      -t openbox-android

    docker build . \
      --build-arg="ANDROID_API_LEVEL=$ANDROID_API_LEVEL" \
      --build-arg="SCREEN_RESOLUTION=$SCREEN_RESOLUTION" \
      -t openbox-android


  cd -

# finialize docker
cd dockerfiles/final
  docker build . \
    --build-arg="ANDROID_API_LEVEL=$ANDROID_API_LEVEL" \
    -t openbox-android
cd -

docker image tag openbox-android 192.168.10.61:5000/logickee/openbox-android

# docker push 192.168.10.61:5000/logickee/openbox-android 
docker run --rm -it \
  --privileged \
  --device /dev/kvm \
  -v ./share:/share \
  -v ./dockerfiles/final/etc/supervisord-emulator.conf:/etc/supervisord-emulator.conf \
  -p 15900:5900 \
  -p 6080:6080 \
  -p 4723:4723 \
  --name logickee_docker_android openbox-android 
  # bash
