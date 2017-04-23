#!/bin/bash

# This was taken and adapted from this source:
# https://goo.gl/j34FyO (Arch Wiki | Steam Troubleshooting)
killall compton && $1;
$(bash -c ~/.config/i3/scripts/compton_startup.sh)
