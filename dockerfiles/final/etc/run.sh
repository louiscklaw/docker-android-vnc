#!/usr/bin/env bash

set -x

# /usr/bin/supervisord -c /etc/supervisord-screen.conf &
# /etc/supervisord-appium.conf &

cat /etc/supervisord-emulator.conf 
cat /etc/launch_emulator.sh 

for i in /etc/supervisord*.conf; do
  /usr/bin/supervisord -c  $i &
done

wait
