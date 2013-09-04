#!/bin/bash

numlockx &

WM=herbstluftwm

[ -f $HOME/.Xmodmap ] && xmodmap $HOME/.Xmodmap
dbus-launch --exit-with-session $WM & WMPID=$!

[ -f $HOME/.Xresources ] && xrdb -merge $HOME/.Xresources

[ -x $HOME/.randwallpaper ] && $HOME/.randwallpaper &

wait $WMPID
