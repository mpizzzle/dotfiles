#!/bin/sh

flat=0
inverse=0
random=0
all=0

OPTS="h:ira"
LONGOPTS="help,inverse,random,all"

parsed=$(getopt --options=$OPTS --longoptions=$LONGOPTS -- "$@")
eval set -- "${parsed[@]}"

while true; do
  case "$1" in
    -i|--inverse) inverse=1 ;;
    -r|--random) random=1 ;;
    -a|--all) all=1 ;;

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

while true; do
  row=$(psql spanish-dictionary -q -c "SELECT word_english, word_spanish, entry_id, successes FROM dictionary WHERE next_appearance < current_timestamp ORDER BY random() limit 1;" --csv -t)
  row=$(echo $row | perl -pe 's/,(?=[^\s])/\%/g' | sed 's/"//g')

  if [ "$row" == "" ]; then
    next_appearance=$(psql spanish-dictionary -q -c "SELECT next_appearance FROM dictionary ORDER BY next_appearance limit 1;" --csv -t)
    echo "Up to date! next question is at $next_appearance."
    all=0
  else

    #word_english=$(echo $row | awk 'FNR == 1 { print };')
    #word_spanish=$(echo $row | awk 'FNR == 2 { print };')
    #entry_id=$(echo $row | awk 'FNR == 3 { print };')
    #successes=$(echo $row | awk 'FNR == 4 { print };')

    word_english=$(echo $row | awk '{split($0,a,"%"); print a[1]};')
    word_spanish=$(echo $row | awk '{split($0,a,"%"); print a[2]};')
    entry_id=$(echo $row | awk '{split($0,a,"%"); print a[3]};')
    successes=$(echo $row | awk '{split($0,a,"%"); print a[4]};')

    if [ "$random" = "1" ]; then
      choice=$(shuf -i 1-2 -n 1)
    else
      choice=$inverse
    fi

    if [ "$choice" == "1" ]; then
      var=$word_english
      echo $word_spanish
    else
      var=$word_spanish
      echo $word_english
    fi

    read user_input

    if [ "$var" == "$user_input" ]; then
      successes=$((successes + 1))
      fib=$(bc -l <<< "(((sqrt(5) + 1) / 2) ^ ($successes + 1) - (-((sqrt(5) + 1) / 2)) ^ -($successes + 1)) / sqrt(5)" | awk '{printf("%d\n", ($1 + 0.5) * 5)}')

      echo "correct! will ask you again in $fib minutes."
      future_date=$(date --iso-8601=seconds -d "+$fib minutes")
      psql spanish-dictionary -q -c "UPDATE dictionary SET successes = $successes, next_appearance = '$future_date' WHERE entry_id = $entry_id"
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
      psql spanish-dictionary -q -c "UPDATE dictionary SET successes = 0 WHERE entry_id = $entry_id"
    fi
  fi

  if [ "$all" == "0" ]; then
    break
  fi
done
