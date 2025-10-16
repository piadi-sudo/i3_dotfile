#!/bin/bash
# Carica i colori di Pywal
source "$HOME/.cache/wal/colors.sh"

# Prendi lo status del player senza spazi
player_status=$(playerctl --player=spotify,spotifyd,vlc,mpd status 2>/dev/null | tr -d '[:space:]')

if [ "$player_status" = "Playing" ]; then
    artist=$(playerctl --player=spotify,spotifyd,vlc,mpd metadata artist)
    title=$(playerctl --player=spotify,spotifyd,vlc,mpd metadata title)
    echo "%{F$color2}PLAY $artist - ${title:0:50}%{F-}"   # verde Pywal
elif [ "$player_status" = "Paused" ]; then
    artist=$(playerctl --player=spotify,spotifyd,vlc,mpd metadata artist)
    title=$(playerctl --player=spotify,spotifyd,vlc,mpd metadata title)
    echo "%{F$color3}PAUSE $artist - ${title:0:50}%{F-}"  # giallo Pywal
else
    echo "%{F$color1}STOP Nessuna musica%{F-}"           # rosso Pywal
fi


