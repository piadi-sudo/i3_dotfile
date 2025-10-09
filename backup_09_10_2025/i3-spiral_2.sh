#!/bin/bash
# i3 spiral automatico
# cambia direzione del prossimo split a ogni nuova finestra

STATE_FILE="/tmp/i3_spiral_state"
[[ ! -f "$STATE_FILE" ]] && echo "vertical" > "$STATE_FILE"

i3-msg -t subscribe '[ "window" ]' | while read -r event; do
    # quando si apre una nuova finestra
    if echo "$event" | grep -q '"change":"new"'; then
        dir=$(cat "$STATE_FILE")
        if [[ "$dir" == "vertical" ]]; then
            i3-msg "split horizontal"
            echo "horizontal" > "$STATE_FILE"
        else
            i3-msg "split vertical"
            echo "vertical" > "$STATE_FILE"
        fi
    fi
done
