#!/bin/bash

set -e

vim=0
vagrant=0

if [[ $# -gt 2 ]]
then
  echo "Unsupported"
  return 1
elif [[ $# -eq 0 ]]
then
  vim=1
  vagrant=1
else
  if [[ $1 == $2 ]]
  then
    echo "Please select different componets to install"
    return 1
  else
    if [[ $1 == "vim" || $2 == "vim" ]]
    then
      vim=1
    elif [[ $1 == "vagrant" || $2 == "vagrant" ]]
    then
      vagrant=1
    else
      echo "Currently support vim and vagrant only"
      return 1
    fi
  fi
fi

# Install some basic packages
packages="git vim ruby rubygems curl tmux htop"

pacman -S --noconfirm $packages

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
target=$(readlink -f "$DIR")

if [[ $vim -eq 1 ]]
then
  $target/install-vim.sh
fi

if [[ $vagrant -eq 1 ]]
then
  $target/install-vagrant.sh
fi

$target/apply-terminal.sh
