#!/bin/sh

#
# Openbox autostart script
#

xsetroot -solid black &
tint2 &
conky &
thunar --daemon &

export BROWSER="chromium"

# Gnome keyring (use by svn client auth)
/usr/bin/gnome-keyring-daemon --start --components=gpg
/usr/bin/gnome-keyring-daemon --start --components=pkcs11
/usr/bin/gnome-keyring-daemon --start --components=secrets
/usr/bin/gnome-keyring-daemon --start --components=ssh
