#!/bin/bash

set -ex

if [ -z $@ ]; then
    exit
fi

layout=$(./i3-get-focused-container.sh | jq .layout | sed s/\"//g )
if [[ $layout = "splitv" ]] || [[ $layout = "stacked" ]]; then
    dir="up"
else
    dir="left"
fi
echo $layout-$dir

i3-msg -t command -- exec $@
./i3-await.sh new || true
i3-msg -t command move $dir

if [ -e "_work" ]; then
    rm _work
fi
