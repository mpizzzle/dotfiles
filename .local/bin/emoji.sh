#!/bin/sh

cat "$XDG_DATA_HOME/emoji" | dmenu | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard
