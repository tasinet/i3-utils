#!/bin/bash

if [ $# -ne 1 ]; then
  echo "provide ONE window event .change type (new, focus, title, ...)"
  echo "Example: i3-follow.sh new"
  echo "See https://i3wm.org/docs/ipc.html#_window_event"
  exit 128
fi

if [ -z $(which jq) ]; then
  echo Unmet dependency: jq
  echo Please install jq, I need it to parse JSON.
  exit 127
fi

parentpid=$BASHPID

i3-msg -t subscribe -m '[ "window" ]' 2> /dev/null | while read line; do
  change=$(echo $line | jq '.change')
  if [ "$change" = "\"$@\"" ]; then
    echo $line
    # exit will not exit immediately, killing i3-msg gracefully does
    # ugly but reliable ¯\_(ツ)_/¯
    i3msgpid=$(pgrep -P $parentpid i3-msg)
    if [ -z $i3msgpid ]; then
      # fallback if above failed for whatever reason
      echo "Failed to find i3-msg pid under mine ($parentpid)" 1>&2
      # This will affect exit status and will print an error message on some shells
      kill -HUP $parentpid
    else
      kill -HUP $i3msgpid
      exit 0
    fi
  fi
done
