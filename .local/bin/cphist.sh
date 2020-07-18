#!/bin/sh

grep "$1" $ZHIST | fzf | clip
