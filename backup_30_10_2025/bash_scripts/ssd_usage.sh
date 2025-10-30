#!/bin/bash
source "$HOME/.cache/wal/colors.sh"

USAGE=$(df -h / | awk 'NR==2 {gsub("%",""); print $5}' | tr -d '[:space:]')

if [ "$USAGE" -ge 90 ]; then
    echo "%{F$color1}SSD $USAGE%%{F-}"   # rosso Pywal
elif [ "$USAGE" -ge 70 ]; then
    echo "%{F$color3}SSD $USAGE%%{F-}"   # giallo Pywal
else
    echo "%{F$color2}SSD $USAGE%%{F-}"   # verde Pywal
fi

