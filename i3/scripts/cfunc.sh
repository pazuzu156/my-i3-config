#!/bin/bash

# Base defines as required by my Arch setup
# remove/add as needed
export MAKEOPTS="-j 4"
export MAKEFLAGS="${MAKEOPTS}"

# custom functions
# delete what you don't need

# Run neofetch forcing Arch Linux ASCII art
# Not really needed if you don't rename lsb-release info
function neo {
    ASCII_ARCH=/usr/share/neofetch/ascii/distro/arch
    neofetch --ascii ${ASCII_ARCH}
    unset ASCII_ARCH
}

# Edit i3 config
function i3conf-edit {
    vim ~/.i3/config
    i3 restart
}

# Edit this file
function cfunc-edit {
    vim ~/.i3/scripts/cfunc.sh
    resource-i3func
}

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

    cp -v ${I3C}/compton_i3.conf ${MI3C}/i3/compton_i3.conf
    cp -v ${I3C}/compton_xfce.conf ${MI3C}/i3/compton_xfce.conf
    cp -v ${I3C}/config ${MI3C}/i3/config
    cp -v ${I3C}/dunstrc ${MI3C}/i3/dunstrc
    cp -v ${I3C}/i3blocks.conf ${MI3C}/i3/i3blocks.conf
    cp -v ${I3C}/i3scrot.conf ${MI3C}/i3/i3scrot.conf

    cp -v ${I3C}/scripts/lock.sh ${MI3C}/i3/scripts/lock.sh
    cp -v ${I3C}/scripts/lock.png ${MI3C}/i3/scripts/lock.png
    cp -v ${I3C}/scripts/cfunc.sh ${MI3C}/i3/scripts/cfunc.sh
    cp -v ${I3C}/scripts/runsteamapp.sh ${MI3C}/i3/scripts/runsteamapp.sh
    cp -v ${I3C}/scripts/i3startup.sh ${MI3C}/i3/scripts/i3startup.sh
    cp -v ${I3C}/scripts/xfcestartup.sh ${MI3C}/i3/scripts/xfcestartup.sh

    cp -v ${ROFI}/config ${MI3C}/rofi/config

    cp -v ${TERMC}/config ${MI3C}/terminator/config

    cp -v $HOME/.vimrc ${MI3C}/.vimrc
    cp -v $HOME/.zshrc ${MI3C}/.zshrc
    cp -v $HOME/.xinitrc ${MI3C}/.xinitrc

    unset CFG
    unset I3C
    unset ROFI
    unset TERMC
    unset MI3C
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
# Must provide the partition number!
function winmount {
    MNT=/mnt/Windows
    if ! [ -z ${1+x} ] ; then
        if ! [ -d ${MNT} ] ; then
            sudo mkdir ${MNT}
        fi

        sudo mount $1 /mnt/Windows
        echo "Mounted. Run cdwin to open the directory"
    else
        echo "You must give a parition to mount!"
    fi

    unset MNT
}

# Unmounts a Windows partition mounted with winmount
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

    unset EXPECTED_SIGNATURE
    unset ACTUAL_SIGNATURE
}

# Runs a source on this script to re-source it
# into the active terminal to update any changes
# on the fly
function resource-i3func {
    source ${HOME}/.config/i3/scripts/cfunc.sh
}

# Mount Android device.
# Requires jmtpfs
function android-mount {
    AD=${HOME}/android
    if ! [ -d ${AD} ] ; then
        mkdir ${AD}
    fi

    jmtpfs ${AD}

    unset AD
}

# Unmount a device mounted with android-mount
function android-umount {
    AD=${HOME}/android
    sudo umount -R ${AD}
    rm -rf ${AD}
    echo 'Unmounted. Run `android-mount` to remount device'

    unset AD
}

# aliases
# delete what you don't need
alias lampp='sudo /opt/lampp/lampp $1'
alias srcinfo='makepkg --printsrcinfo > .SRCINFO'
alias cdwin='cd /mnt/Windows'

# Add STARTX_LOGIN to the calling script
# Just define it to load in (also, set to true)
if ! [ -z ${STARTX_LOGIN+x} ] ; then
    if ${STARTX_LOGIN} ; then
        if ! xset q &>/dev/null ; then
            startx
            # exit once X closes (for true log out)
            exit
        else
            neo
        fi
    else
        neo
    fi
else
    neo
fi

