#!/bin/bash

set -e

active_workspace=$(i3-msg -t get_workspaces | jq '.[] | select(.focused).num')

nodes=$(i3-msg -t get_tree | jq '(.nodes[].nodes[].nodes[] | select(.type=="workspace") | select(.num=='"$active_workspace"') ) // -1' | tee _work)

out=$(echo $nodes | jq 'recurse(.nodes[]) | select(.nodes[].focused==true) ')

echo $out
