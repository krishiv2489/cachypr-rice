#!/bin/bash

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
CAVA_CFG="$CACHE_DIR/waybar_cava.conf"

cat >"$CAVA_CFG" <<EOF
[general]
bars = 10
framerate = 60
waveform = 1    

[input]
method = pipewire
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
bar_delimiter = 59

[smoothing]
noise_reduction = 88     ; 0-100, default 77. Higher = calmer frame-to-frame motion
monstercat = 1           ; blends neighboring bar heights into one continuous hill
waves = 1                ; extends that blending further for a rippling look

EOF

cava -p "$CAVA_CFG" | sed -u \
	's/;//g; s/0/ /g; s/1/▂/g; s/2/▃/g; s/3/▄/g; s/4/▅/g; s/5/▆/g; s/6/▇/g; s/7/█/g'
