#!/bin/bash

set -e

if [ -z "$SUDO_USER" ]
then
  U=$USER
else
  U=$SUDO_USER
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
target=$(readlink -f "$DIR")

home_dir=$(getent passwd "$U" | cut -d: -f 6)

if [ ! -f $home_dir/.vim/installed ]
then
  pacman -S --noconfirm vim ruby rubygems
  gem install rake --no-rdoc --no-ri
  sudo -u $U -H curl -Lo- http://bit.ly/janus-bootstrap | sudo -u $U -H bash
  sudo -u $U -H touch .vim/installed
fi

terminal_directories=("janus" "vim/colors")

for terminal_directory in "${terminal_directories[@]}"
do
  if [ -h .$terminal_directory ]
  then
    rm .$terminal_directory
  elif [ -d .$terminal_directory ]
  then
    mv .$terminal_directory .$terminal_directory.old
  fi
  sudo -u $U ln -s $target/../$terminal_directory $home_dir/.$terminal_directory
done
