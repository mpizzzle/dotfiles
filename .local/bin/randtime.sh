#!/bin/sh

r=0
c=0
challenge=1
flat=0

OPTS="hc:fr"
LONGOPTS="help,challenge:,flat,round"

parsed=$(getopt --options=$OPTS --longoptions=$LONGOPTS -- "$@")
eval set -- "${parsed[@]}"

while true; do
  case "$1" in
    -f|--flat) flat=1 ;;
    -r|--round) r=1 ;;
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
  export LC_ALL=en_GB.UTF-8
  from=$(date "+%s")
  rand=$(shuf -i 1-2147483648 -n 1)

  p=""
  if [ $((rand % 2)) == 0 ]; then
    format="+%I:%M %p"
    p=$(date -d "@$rand" "+%p")
  else
    format="+%I:%M"
  fi

  date -d "@$rand" "$format"
  h=$(date -d "@$rand" "+%I")
  m=$(date -d "@$rand" "+%M")
  export LC_ALL=es_MX.UTF-8

  h=${h#0}
  m=${m#0}

  if [ "$r" == "1" ]; then
    m=$((( (m + 2) / 5) * 5 ))
    if [ $m == 60 ]; then
      m=0
      h=$(((h % 12) + 1))
    fi
  fi

  hour=$(python ~/.local/bin/inttoesp.py "$h")

  if [ $m != 0 ]; then
    if [ $m == 15 ]; then
      minutes=" y cuarto"
    elif [ $m -lt 30 ]; then
      minutes=" y $(python ~/.local/bin/inttoesp.py $m)"
    elif [ $m == 30 ]; then
      minutes=" y media"
    fi

    if [ $m == 45 ]; then
      minutes=" menos cuarto"
      hour="$(python ~/.local/bin/inttoesp.py $(((h % 12) + 1)))"
    elif [ $m -gt 30 ]; then
      minutes=" menos $(python ~/.local/bin/inttoesp.py $((60 - $m)))"
      hour="$(python ~/.local/bin/inttoesp.py $(((h % 12) + 1)))"
    fi
  else
    minutes=""
  fi

  if [ "$p" == "am" ]; then
    if [ $((h % 12)) -lt 6 ]; then
      period=" de la madrugada"
    else
      period=" de la mañana"
    fi
  elif [ "$p" == "pm" ]; then
    if [ $((h % 12)) -lt 6 ]; then
      period=" de la tarde"
    else
      period=" de la noche"
    fi
  else
    period=""
  fi

  if [ $hour == "uno" ]; then
    full_date="Es la una$minutes$period"
  else
    full_date="Son las $hour$minutes$period"
  fi

  if [ $h == 12 ] && [ $m == 0 ]; then
    if [ "$p" == "am" ]; then
      full_date="Es mediodía"
    elif [ "$p" == "pm" ]; then
      full_date="Es medianoche"
    fi
  fi
  
  read user_input
  
  if [ "$full_date" == "$user_input" ]; then
    echo "correcto!"
    successes=$((successes + 1))
  else
    actual=""
    for (( j=0; j<${#full_date}; j++ )); do
      if [ "${full_date:$j:1}" == "${user_input:$j:1}" ]; then
        actual="$actual${full_date:$j:1}"
      else
        actual="$actual\e[01;31m${full_date:$j:1}\e[0m"
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
