#!/bin/sh

english_word=""
spanish_word=""

OPTS="he:s:"
LONGOPTS="help,english:,spanish:"

parsed=$(getopt --options=$OPTS --longoptions=$LONGOPTS -- "$@")
eval set -- "${parsed[@]}"

while true; do
  case "$1" in
    -e|--english)
      english_word="$2"
      shift;;

    -s|--spanish)
      spanish_word="$2"
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

if [ "$english_word" == "" ]; then
  echo "english word:"
  read english_word
fi
if [ "$spanish_word" == "" ]; then
  echo "spanish word:"
  read spanish_word
fi

psql spanish-dictionary -c "INSERT INTO dictionary (word_english, word_spanish, successes, next_appearance) VALUES ('$english_word', '$spanish_word', 0, '$(date --iso-8601=seconds)');"
