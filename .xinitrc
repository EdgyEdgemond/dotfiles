#!/bin/bash

numlockx &
setxkbmap -option caps:escape

WM=herbstluftwm

[ -f $HOME/.Xmodmap ] && xmodmap $HOME/.Xmodmap
dbus-launch --exit-with-session $WM & WMPID=$!

[ -f $HOME/.Xresources ] && xrdb -merge $HOME/.Xresources

[ -x $HOME/.randwallpaper ] && $HOME/.randwallpaper &
[ -x $HOME/.conkyrc ] && conky -d &

wait $WMPID
