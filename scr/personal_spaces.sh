#!/bin/bash

if [ "$EUID" -ne 0 ]
then
    >&2 echo "This script must be run as root."
    exit
fi

if [[ "$#" -ne 1 ]]
then
    >&2 echo "Usage: ${0} username"
    exit
fi

if [[ ! -d "/home/${1}" ]]
then
    >&2 echo "Error: user ${1} does not exist."
    exit
fi

if [[ $(grep ${1} /home/webmaster/nginx/docker-compose.yml | wc -l) -gt 0 ]]
then
    >&2 echo "User ${1} already had access to personal spaces."
    exit
fi

mkdir -p /home/${1}/public_html
chown -R ${1}:${1} /home/${1}/public_html

sed -i "s/volumes:/volumes:\n      - \/home\/$1\/public_html:\/home\/$1\/public_html/g" /home/webmaster/nginx/docker-compose.yml

echo "Granted acces to ${1} to personal spaces. Remember to restart nginx for changes to take effect."
