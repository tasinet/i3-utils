#!/bin/bash

# partly duplicated in open-in-follow.sh
# keep in sync

set -vx 

command=$@

target_workspace_name=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2)
echo target workspace name $target_workspace_name
echo current workspace name $current_workspace_name

i3-msg -- exec --no-startup-id $command
./i3-await.sh new
current_workspace_name=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2)

if [ "$current_workspace_name" != "$target_workspace_name" ]; then
  echo moving to $target_workspace_name
  i3 move workspace "$target_workspace_name"
fi
