#!/bin/sh

c=0
challenge=1

OPTS="hc:fr:"
LONGOPTS="help,challenge:"

parsed=$(getopt --options=$OPTS --longoptions=$LONGOPTS -- "$@")
eval set -- "${parsed[@]}"

while true; do
  case "$1" in
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

  entry=$(cat $XDG_DATA_HOME/letters | shuf -n 1)

  echo $entry | awk '{ print $1 };'
  letter=$(echo $entry | awk '{ print $2 };')
  
  read user_input
  
  if [ "$letter" == "$user_input" ]; then
    echo "correcto!"
    successes=$((successes + 1))
  else
    actual=""
    for (( j=0; j<${#letter}; j++ )); do
      if [ "${letter:$j:1}" == "${user_input:$j:1}" ]; then
        actual="$actual${letter:$j:1}"
      else
        actual="$actual\e[01;31m${letter:$j:1}\e[0m"
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
