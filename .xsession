#!/bin/sh

picom -b
wallpapers.sh ~/wallpapers &

while true; do
 xsetroot -name "$(statusbar.sh)"
 sleep 5s
done &
