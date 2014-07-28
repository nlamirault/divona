#!/bin/bash

echo "Install Powerline using PIP"
pip2 install --user git+git://github.com/Lokaltog/powerline

echo "Configure fonts"
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
mkdir -p ~/.fonts/
mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts

echo "Configure Powerline symbols"
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

echo "Setup Powerline"
mkdir -p $HOME/.config/powerline
cp -r ~/.local/lib/python2.7/site-packages/powerline/config_files/*  $HOME/.config/powerline
echo "Change 'default_leftonly' theme in shell section of $HOME/.config/powerline/config.json"
