#!/bin/bash

# If you call this script, please do so with `sudo`
# It's best to call it from the `lemp` alias defined in
# 'cfunc.sh'
if [ ${1+x} ] ; then
    ACTION=$(echo "$1" | tr '[:upper:]' '[:lower:]')

    if [ $ACTION = "stop" ] ; then
        ACTIONS="stopping"
    else
        ACTIONS="${ACTION}ing"
    fi

    echo -n "$ACTIONS nginx..."
    systemctl $ACTION nginx
    echo "ok"
    echo -n "$ACTIONS php-fpm..."
    systemctl $ACTION php-fpm
    echo "ok"
    echo -n "$ACTIONS mariadb..."
    systemctl $ACTION mariadb
    echo "ok"
else
    echo "Must have an action (start|stop|restart)"
fi
