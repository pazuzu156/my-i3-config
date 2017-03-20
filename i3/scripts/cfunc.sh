#!/bin/bash

# If statement to run startx on login if x not up
# if x is up, run neofetch (comment out block to disable)

if ! xset q &>/dev/null ; then
    startx
else
    neofetch
fi

# make stuff (if you want it)
export MAKEOPTS="-j 4"
export MAKEFLAGS="${MAKEOPTS}"

# custom functions
# delete what you don't need
function grub-update {
    sudo grub-mkconfig -o /boot/grub/grub.cfg
}

function grub-edit {
    sudo vim /etc/default/grub
    grub-update
}

function updi3conf {
    I3C=$HOME/.config/i3
    MI3C=$HOME/my-i3-config

    cp -v ${I3C}/compton.conf ${MI3C}/i3/compton.conf
    cp -v ${I3C}/config ${MI3C}/i3/config
    cp -v ${I3C}/dunstrc ${MI3C}/i3/dunstrc
    cp -v ${I3C}/i3blocks.conf ${MI3C}/i3/i3blocks.conf
    cp -v ${I3C}/i3scrot.conf ${MI3C}/i3/i3scrot.conf

    cp -v ${I3C}/scripts/lock.sh ${MI3C}/i3/scripts/lock.sh
    cp -v ${I3C}/scripts/lock.png ${MI3C}/i3/scripts/lock.png
    cp -v ${I3C}/scripts/cfunc.sh ${MI3C}/i3/scripts/cfunc.sh

    cp -v $HOME/.vimrc ${MI3C}/.vimrc
    cp -v $HOME/.zshrc ${MI3C}/.zshrc
    cp -v $HOME/.xinitrc ${MI3C}/.xinitrc
}

# aliases
# delete what you don't need
alias lampp='sudo /opt/lampp/lampp $1'
alias srcinfo='makepkg --printsrcinfo > .SRCINFO'
