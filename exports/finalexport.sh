#!/bin/sh
printf '\033c\033]0;%s\a' bubble-bobble-godot
base_path="$(dirname "$(realpath "$0")")"
"$base_path/finalexport.x86_64" "$@"
