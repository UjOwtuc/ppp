#!/bin/sh

USERNAME=$1
[ "${USERNAME}" ] || exit 1
PASSWORD=$2
[ "${PASSWORD}" ] || exit 1

adduser --gecos "${USERNAME}" --disabled-password --shell /bin/zsh "${USERNAME}"
adduser "${USERNAME}" sudo

# Needed for hardware access rights
adduser "${USERNAME}" video
adduser "${USERNAME}" render
adduser "${USERNAME}" audio
adduser "${USERNAME}" bluetooth
adduser "${USERNAME}" plugdev
adduser "${USERNAME}" input
adduser "${USERNAME}" dialout
adduser "${USERNAME}" feedbackd

echo "${USERNAME}:${PASSWORD}" | chpasswd
