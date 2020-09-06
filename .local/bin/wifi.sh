#!/bin/sh

SSID=$(nmcli device wifi list | awk '{ print $3 };' | fzf)

nmcli --ask device wifi connect "$SSID"
