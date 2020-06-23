#!/bin/sh

devices=$(simple-mtpfs -l)
if [[ "$devices" = "No raw devices found." ]] ; then
  echo $devices
else
  choice=$(echo $devices | fzf | sed "s/://g" | awk '{print $1}')
  simple-mtpfs --device $choice ~/phone
fi  
