#!/bin/sh

WALLPAPER=$(ls $1 | shuf -n 1)

str=$WALLPAPER
EXTENSION="${str: -3}"

if [ $(ps waux | grep xwinwrap | wc -l) -gt 1 ]
then
  exec pkill xwinwrap
fi

if [ "$EXTENSION" = "gif" ]
then
  exec xwinwrap -ov -fs -- gifview -w WID -a $1/$WALLPAPER
elif [ "$EXTENSION" = "mp4" ]
then
  exec xwinwrap -ov -fs -- mpv --loop-file --mute=yes -vo x11 -wid WID $1/$WALLPAPER
else
  exec feh --bg-fill --no-fehbg $1/$WALLPAPER
fi
