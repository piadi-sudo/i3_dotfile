#!/usr/bin/env bash

# Power Menu per Rofi
OPTIONS="  Shutdown\n  Reboot\n  Logout"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Power Menu" -lines 3 -width 20)

case "$CHOICE" in
    "  Shutdown")
        systemctl poweroff
        ;;
    "  Reboot")
        systemctl reboot
        ;;
    "  Logout")
        i3-msg exit
        ;;
esac

