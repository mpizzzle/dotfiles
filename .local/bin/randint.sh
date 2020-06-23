#!/bin/sh

c=0
challenge=1
flat=0
range="1-100"

OPTS="hc:fr:"
LONGOPTS="help,challenge:,flat,range:"

parsed=$(getopt --options=$OPTS --longoptions=$LONGOPTS -- "$@")
eval set -- "${parsed[@]}"

while true; do
  case "$1" in
    -f|--flat) flat=1 ;;
    -c|--challenge)
      c=1
      challenge=$2
      shift;;
    -r|--range)
      range="$2"
      shift;;

    --) # end of arguments
      shift
      break
      ;;

    *)
      printf '%s\n' "Error while parsing CLI options" 1>&2
      ;;
  esac

  shift
done

successes=0
from=0
til=0
average=0

if [ "$c" == "1" ]; then
  clear
  for i in {3..1}; do
    echo "$i"
    sleep 1
    clear
  done 
fi

for i in $(seq $challenge); do
  from=$(date "+%s")

  rand=$(shuf -i "$range" -n 1)
  echo $rand | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta'
  
  word=$(python ~/.local/bin/inttoesp.py "$rand")
  
  read user_input
  
  if [ "$word" == "$user_input" ]; then
    echo "correcto!"
    successes=$((successes + 1))
  else
    actual=""
    for (( j=0; j<${#word}; j++ )); do
      if [ "${word:$j:1}" == "${user_input:$j:1}" ]; then
        actual="$actual${word:$j:1}"
      else
        actual="$actual\e[01;31m${word:$j:1}\e[0m"
      fi
    done
    echo -e $actual
  fi

  til=$(date "+%s")
  average=$((average + (til - from)))
done

if [ "$c" == "1" ]; then
  echo "average time: $((average/challenge)) s"
  echo "total time: $average s"
  echo "total: $successes / $challenge correct!"
fi
