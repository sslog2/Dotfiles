#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Launch bar1
while pgrep -u $UID -x polybar >/dev/null; do sleep 1;done

polybar bar1 &

if xrandr -q | grep -q 'HDMI-1-0 connected'; then
    echo "---" | tee -a /tmp/polybar2.log
    polybar bar2 2>&1 | tee -a /tmp/polybar2.log &
fi
