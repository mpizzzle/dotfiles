#!/bin/sh

scrot -o "$XDG_CACHE_HOME/scrot/scrot.png"
zbarimg "$XDG_CACHE_HOME/scrot/scrot.png" -q --raw | xclip -selection clipboard
rm "$XDG_CACHE_HOME/scrot/scrot.png"
