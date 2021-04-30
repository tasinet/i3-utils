#!/bin/bash

if [ $# -gt 3 ]; then
  echo "provide ONE or TWO window event .change type(s) (new, focus, title, ...)"
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
  if [ "$change" = "\"$1\"" -o "$change" = "\"$2\"" -o  "$change" = "\"$3\"" ]; then
    echo $line
  fi
done
