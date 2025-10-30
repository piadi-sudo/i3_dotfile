#!/bin/bash
killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 0.2; done
polybar main -c "$HOME/.config/polybar/config.ini" 2>&1 | tee -a /tmp/polybar.log &
echo "Bar launched..."
