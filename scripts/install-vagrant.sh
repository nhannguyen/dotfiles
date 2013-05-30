#!/bin/bash

set -e

if [ ! -f /etc/apt/source.list.d/virtualbox.list ]
then
  echo deb http://download.virtualbox.org/virtualbox/debian `lsb_release -cs` contrib | tee /etc/apt/sources.list.d/virtualbox.list
  wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O - | apt-key add -
fi

apt-get update
apt-get install -y linux-headers-$(uname -r) dkms virtualbox-4.2 rubygems ruby-dev
gem install vagrant --no-rdoc --no-ri
