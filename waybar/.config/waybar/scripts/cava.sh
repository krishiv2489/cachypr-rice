#!/bin/bash

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
CAVA_CFG="$CACHE_DIR/waybar_cava.conf"

cat >"$CAVA_CFG" <<EOF
[general]
bars = 20
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
noise_reduction = 88
monstercat = 1
waves = 1
EOF

# Process output and emit JSON for Waybar
cava -p "$CAVA_CFG" | sed -u \
	's/;//g; s/0/ /g; s/1/▂/g; s/2/▃/g; s/3/▄/g; s/4/▅/g; s/5/▆/g; s/6/▇/g; s/7/█/g' | awk -v frames=600 '
BEGIN { silent = 0; }
{
    # If the output is empty or only contains spaces
    if ($0 ~ /^ +$/ || $0 == "") {
        silent++
    } else {
        silent = 0
    }

    # 600 frames = 10 seconds of silence
    if (silent >= frames) {
        # Output a single space to keep widget alive, but flag it as silent for CSS
        print "{\"text\": \" \", \"class\": \"silent\"}"
    } else {
        print "{\"text\": \"" $0 "\", \"class\": \"playing\"}"
    }
    fflush(stdout)
}'
