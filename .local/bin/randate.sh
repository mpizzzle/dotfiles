#!/bin/sh

c=0
challenge=1
flat=0

OPTS="hc:f"
LONGOPTS="help,challenge:,flat"

parsed=$(getopt --options=$OPTS --longoptions=$LONGOPTS -- "$@")
eval set -- "${parsed[@]}"

while true; do
  case "$1" in
    -f|--flat) flat=1 ;;
    -c|--challenge)
      c=1
      challenge=$2
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

  rand=$(shuf -i 1-2147483648 -n 1)
  export LC_ALL=en_GB.UTF-8
  date -d "@$rand" '+%A the %d of %B, %Y'
  export LC_ALL=es_MX.UTF-8
  
  day=$(python ~/.local/bin/inttoesp.py $(date -d "@$rand" "+%d"))
  year=$(python ~/.local/bin/inttoesp.py $(date -d "@$rand" "+%Y"))
  
  if [ "$day" == "uno" ]; then
    day="primero"
  fi
  var=$(date -d "@$rand" "+%A el $day de %B del $year")
  read user_input
  
  if [ "$var" == "$user_input" ]; then
    echo "correcto!"
    successes=$((successes + 1))
  else
    actual=""
    for (( j=0; j<${#var}; j++ )); do
      if [ "${var:$j:1}" == "${user_input:$j:1}" ]; then
        actual="$actual${var:$j:1}"
      else
        actual="$actual\e[01;31m${var:$j:1}\e[0m"
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
