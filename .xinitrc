#!/bin/bash

numlockx &
setxkbmap -option caps:escape

WM=herbstluftwm

[ -f $HOME/.Xmodmap ] && xmodmap $HOME/.Xmodmap
dbus-launch --exit-with-session $WM & WMPID=$!

[ -f $HOME/.Xresources ] && xrdb -merge $HOME/.Xresources

[ -x $HOME/.randwallpaper ] && $HOME/.randwallpaper &

[ -f $HOME/.conkyrc ] && conky -d &

[Desktop Entry]
Encoding=UTF-8
Version=0.9.1
Type=Application
Name=conky
Comment=
Exec=conky -d
StartupNotify=False
Terminal=False
Hidden=False

[Desktop Entry]
Encoding=UTF-8
Name=Music Player Daemon
Comment=
Exec=mpd
StartupNotify=False
Terminal=False
Hidden=False

wait $WMPID
