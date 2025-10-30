#!/bin/bash

# Sink IDs
CUFFIE="alsa_output.pci-0000_11_00.6.analog-surround-21"
HDMI="alsa_output.pci-0000_01_00.1.hdmi-stereo"

# Legge il sink predefinito
CURRENT=$(pactl info | grep "Default Sink" | awk '{print $3}')

if [ "$CURRENT" = "$CUFFIE" ]; then
  TARGET="$HDMI"
  notify-send "Audio" "Output → HDMI"
else
  TARGET="$CUFFIE"
  notify-send "Audio" "Output → Cuffie"
fi

# Imposta il sink predefinito
pactl set-default-sink "$TARGET"

# Sposta tutte le applicazioni già in riproduzione sul nuovo sink
for INPUT in $(pactl list short sink-inputs | awk '{print $1}'); do
  pactl move-sink-input $INPUT "$TARGET"
done
