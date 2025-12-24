#!/bin/bash
# i3 spiral (manual rotation)
# ruota la direzione del prossimo split in modo ciclico: vertical → horizontal → vertical → horizontal

# file per salvare la direzione corrente
STATE_FILE="/tmp/i3_spiral_state"

# leggi stato precedente
if [[ -f "$STATE_FILE" ]]; then
    state=$(cat "$STATE_FILE")
else
    state="vertical"
fi

# ruota lo stato
if [[ "$state" == "vertical" ]]; then
    i3-msg "split horizontal"
    echo "horizontal" > "$STATE_FILE"
else
    i3-msg "split vertical"
    echo "vertical" > "$STATE_FILE"
fi

