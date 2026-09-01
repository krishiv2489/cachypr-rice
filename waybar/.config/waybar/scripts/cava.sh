#!/bin/bash
# CAVA feed for Waybar's custom/cava module.
# Emits JSON so Waybar can read a "playing"/"silent" class and
# drive the bubble animation from style.css.

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

# ascii digits -> block glyphs (0 = silence, 1-7 = increasing bar height)
cava -p "$CAVA_CFG" | sed -u \
	's/;//g; s/0/ /g; s/1/▂/g; s/2/▃/g; s/3/▄/g; s/4/▅/g; s/5/▆/g; s/6/▇/g; s/7/█/g' | awk -v frames=330 '
# frames = seconds * framerate. 330 = 5.5s at 60fps.
# Change "frames" above to retune how long silence must last before it hides.
BEGIN { silent_count = 0 }
{
    line = $0
    non_space = gsub(/[^ ]/, "&", line)   # count active bar characters this frame

    # Allow up to 1 stray bar so a tiny noise floor cannot block detection
    if (non_space <= 1) {
        silent_count++
    } else {
        silent_count = 0
    }

    if (silent_count >= frames) {
        print "{\"text\": \"\", \"class\": \"silent\"}"
    } else {
        print "{\"text\": \"" $0 "\", \"class\": \"playing\"}"
    }
    fflush(stdout)
}'
