#!/bin/bash
compton -b --config ~/.config/i3/compton_xfce.conf &
exec startxfce4
