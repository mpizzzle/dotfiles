#!/bin/sh

nmcli connection show | grep wlp2s0 | awk '{ print $1 }'
