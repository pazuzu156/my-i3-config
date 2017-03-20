# my-i3-config
This repo houses the configuration files/shell scripts I use for my current i3 install

## Using
To use these config files, you need to make sure you have the same apps installed I use. Otherwise, you can simply edit them to fit your needs

## Requirements
I'm an Arch Linux user, so all packages I list are listed as they are in the arch repository and the AUR. They might be named differently for your distro.

`imagemagick` - For i3lock since I use a custom shell script for my lock screen  
`scrot` - Screenshots AND i3lock (used to take screenshot for lock screen)  
`i3scrot-git` - (AUR) Used for taking screenshots easy in i3  
`i3blocks` - (AUR) Used for the status bar (i3status wrapper)  
`i3-gaps-git` - (AUR) Used for adding gaps between windows  
`feh` - For setting the wallpaper (Remember to call `$ feh --bg-fill PATH` first!)  
`dunst` - Notification daemon  
`terminator` - Terminal emulator  
`numlockx` - Enabling num lock on login  
`firefox` - Web browser ;)  
`rofi-git` - (AUR) The dmenu replacer  
`compton` - The window compositor (Called in .xinitrc

Having these packages installed will work with my current config. The i3 config is also styled to match the Arc-Dark theme. You may change the colors used to suit your needs, or leave them if you like the color scheme.
