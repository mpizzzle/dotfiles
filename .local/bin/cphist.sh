#!/bin/sh

grep "$1" $ZHIST | fzf | tr -d '\n' | xclip -selection clipboard
