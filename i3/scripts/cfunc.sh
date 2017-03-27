#!/bin/bash

# If statement to run startx on login if x not up
# if x is up, run neofetch (comment out variable to disable)

STARTX_LOGIN=true

if ! [ -z ${STARTX_LOGIN+x} ] ; then
    if ${STARTX_LOGIN} ; then
        if ! xset q &>/dev/null ; then
            startx
        else
            neofetch
        fi
    else
        neofetch
    fi
else
    neofetch
fi

# make stuff (if you want it)
export MAKEOPTS="-j 4"
export MAKEFLAGS="${MAKEOPTS}"

# custom functions
# delete what you don't need

# Update grub config
function grub-update {
    sudo grub-mkconfig -o /boot/grub/grub.cfg
}

# Edit /etc/default/grub then update
function grub-edit {
    sudo vim /etc/default/grub
    grub-update
}

# Update my i3 config scripts
function updi3conf {
    CFG=${HOME}/.config
    I3C=${CFG}/i3
    ROFI=${CFG}/rofi
    TERMC=${CFG}/terminator
    MI3C=${HOME}/my-i3-config

    cp -v ${I3C}/compton.conf ${MI3C}/i3/compton.conf
    cp -v ${I3C}/config ${MI3C}/i3/config
    cp -v ${I3C}/dunstrc ${MI3C}/i3/dunstrc
    cp -v ${I3C}/i3blocks.conf ${MI3C}/i3/i3blocks.conf
    cp -v ${I3C}/i3scrot.conf ${MI3C}/i3/i3scrot.conf

    cp -v ${I3C}/scripts/lock.sh ${MI3C}/i3/scripts/lock.sh
    cp -v ${I3C}/scripts/lock.png ${MI3C}/i3/scripts/lock.png
    cp -v ${I3C}/scripts/cfunc.sh ${MI3C}/i3/scripts/cfunc.sh

    cp -v ${ROFI}/config ${MI3C}/rofi/config

    cp -v ${TERMC}/config ${MI3C}/terminator/config

    cp -v $HOME/.vimrc ${MI3C}/.vimrc
    cp -v $HOME/.zshrc ${MI3C}/.zshrc
    cp -v $HOME/.xinitrc ${MI3C}/.xinitrc
}

# Perform basic git add/commit/tags/push
function git-push {
    git add -A
    git commit -S -s -m $1
    if ! [ -z ${2+x} ] ; then
        git tag v$2
        git push --tags
    fi
    git push
}

# Mount/Unmount Windows partition
function winmount {
    if ! [ -z ${1+x} ] ; then
        sudo mkdir /mnt/Windows
        sudo mount $1 /mnt/Windows
        echo "Mounted. Run cdwin to open the directory"
    else
        echo "You must give a parition to mount!"
    fi
}

function winumount {
    sudo umount -R /mnt/Windows
    sudo rm -rf /mnt/Windows
    echo "Unmounted. To remount, run winmount"
}

# Specific to PHP
# Composer install script
function install-composer {
    EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

    if [ "${EXPECTED_SIGNATURE}" != "${ACTUAL_SIGNATURE}" ] ; then
        >&2 echo 'ERROR: Invalid installer signature'
        rm composer-setup.php
    else
        php composer-setup.php --quiet
        php -r "unlink('composer-setup.php');"
        sudo mv composer.phar /usr/bin/composer
        echo 'Composer installed. Run `composer` to make sure it is there'
    fi
}

# Runs a source on this script to re-source it
# into the active terminal to update any changes
# on the fly
function resource-i3func {
    source ${HOME}/.config/i3/scripts/cfunc.sh
}

# aliases
# delete what you don't need
alias lampp='sudo /opt/lampp/lampp $1'
alias srcinfo='makepkg --printsrcinfo > .SRCINFO'
alias cdwin='cd /mnt/Windows'
