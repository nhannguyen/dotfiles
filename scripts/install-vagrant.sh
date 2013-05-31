#!/bin/bash

set -e

pacman -S --noconfirm virtualbox

if [ -z "$SUDO_USER" ]
then
  U=$USER
else
  U=$SUDO_USER
fi

sudo -u $U -H gem install vagrant --no-rdoc --no-ri
