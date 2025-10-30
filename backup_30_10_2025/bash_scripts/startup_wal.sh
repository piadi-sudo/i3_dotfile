#!/usr/bin/env bash

LAST_WALL_FILE="$HOME/.cache/wal/last_wallpaper"

if [ -f "$LAST_WALL_FILE" ]; then
    WALL=$(cat "$LAST_WALL_FILE")
    [ -f "$WALL" ] && feh --no-fehbg --bg-fill "$WALL"
fi

