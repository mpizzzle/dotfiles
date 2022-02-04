#!/bin/sh

userresources=$HOME/.config/Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

#[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zprofile" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/zprofile"

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

picom -b
wallpapers.sh ~/documents/wallpapers &

while true; do
 xsetroot -name "$(statusbar.sh)"
 sleep 5s
done &

while true; do
 ssh-agent dwm
done
