#!/bin/sh

pacman -Qo $(cat $1 | awk '{print $2}')
