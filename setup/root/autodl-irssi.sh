#!/bin/bash

pacman -S perl base-devel curl wget git irssi --noconfirm

# install perl packages through pacman
pacman -S perl-archive-zip perl-net-ssleay perl-html-parser perl-xml-libxml perl-digest-sha perl-json perl-json-xs --noconfirm

# enable PHP Sockets
sed -i -e "s/;extension=sockets.so/extension=sockets.so/g" "/etc/php/php.ini"

cd /home/nobody
# Download irssi scripts
mkdir -p .irssi/scripts/autorun
cd .irssi/scripts
curl -sL http://git.io/vlcND | grep -Po '(?<="browser_download_url": ")(.*-v[\d.]+.zip)' | xargs wget --quiet -O autodl-irssi.zip
unzip -o autodl-irssi.zip
rm autodl-irssi.zip
cp autodl-irssi.pl autorun/

# clone rutorrent plugin
cd /usr/share/webapps/rutorrent/plugins
git clone https://github.com/autodl-community/autodl-rutorrent.git autodl-irssi

# create conf.php that matches settings.in /home/nobody/.autodl/autodl.conf
echo '<?php
$autodlPort = 6738;
$autodlPassword = "weehoo";
?>' >> autodl-irssi/conf.php
