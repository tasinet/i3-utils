#!/bin/bash

# partly duplicated in open-in-follow.sh
# keep in sync

set -vx 

target_workspace_idx=$1
command=${@:2}

if [ -z "$target_workspace_idx" ] || [ -z "$command" ]; then
  echo usage: $0 WORKSPACE_INDEX COMMAND
  exit 1
fi

current_workspace_name=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2)
target_workspace_name=$(i3-get-workspace-names.sh | head -n $target_workspace_idx | tail -n 1 )
echo target workspace name $target_workspace_name
echo current workspace name $current_workspace_name

i3-msg -- exec --no-startup-id $command
./i3-await.sh new
if [ "$current_workspace_name" != "$target_workspace_name" ]; then
  echo moving to $target_workspace_name
  i3 move workspace "$target_workspace_name"
fi
