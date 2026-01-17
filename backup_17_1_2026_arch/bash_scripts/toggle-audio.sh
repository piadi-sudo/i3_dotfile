#!/bin/bash

# Sink IDs
CUFFIE="alsa_output.pci-0000_10_00.6.analog-stereo"
HDMI="alsa_output.pci-0000_01_00.1.hdmi-stereo"

# Sink corrente
CURRENT=$(pactl info | grep "Default Sink" | awk '{print $3}')

# Toggle sink
if [ "$CURRENT" = "$CUFFIE" ]; then
    TARGET="$HDMI"
    ICON="display"
    NOTIFY="Output → HDMI (secondario)"
else
    TARGET="$CUFFIE"
    ICON="audio-headphones"
    NOTIFY="Output → Cuffie"
fi

# Imposta il sink predefinito
pactl set-default-sink "$TARGET"

# Risveglia il sink se sospeso
pactl set-sink-mute "$TARGET" false
# (facoltativo) riproduci un suono di test per attivarlo
paplay /usr/share/sounds/freedesktop/stereo/complete.oga &

# Sposta tutte le applicazioni già in riproduzione sul nuovo sink
for INPUT in $(pactl list short sink-inputs | awk '{print $1}'); do
    pactl move-sink-input "$INPUT" "$TARGET"
done

# Notifica
notify-send -i "$ICON" "Audio" "$NOTIFY"

