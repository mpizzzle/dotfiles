#!/bin/sh

kill $(ps waux | awk '{$1=$3=$4=$5=$6=$7=$8=$9=$10=""; print $0}' | fzf | awk '{print $1}')
