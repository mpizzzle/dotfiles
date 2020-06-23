#!/bin/sh

cat "$XDG_DATA_HOME/acento" | dmenu | awk '{print $2}' | tr -d '\n' | xclip -selection clipboard
