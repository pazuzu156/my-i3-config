#!/bin/bash

# take current screen snapshot
scrot /tmp/screen.png

# define color and get screen size
COLOR=#373d48
SIZE=$(xrandr --current | grep '*' | uniq | awk '{print $1}')

# generate new image from size and color
convert -size ${SIZE} xc:${COLOR} /tmp/screen-color.png

# change alpha channel of solid color image
convert /tmp/screen-color.png -alpha set -channel A -evaluate set 50% /tmp/screen-color.png

# paint and blur the original scrot image
convert /tmp/screen.png -paint 3 -blur 0x8 /tmp/screen.png

# composite translucent solid color image to the original scrot image
convert /tmp/screen.png /tmp/screen-color.png -gravity center -composite -matte /tmp/screen.png

# composite our lock icon onto the generated scrot image
convert /tmp/screen.png ~/.config/i3/scripts/lock2.png -gravity center -composite -matte /tmp/screen.png

# run i3lock and display with the new generated image
i3lock -e -i /tmp/screen.png
