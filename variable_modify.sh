#!/usr/bin/env bash

filename="/path/to/script.sh"
just_name="${filename##*/}"
just_ext="${filename##*.}"
just_root="${filename%/*}"
#just_ext="${filename%%.*}"

echo "Name is: $just_name"
echo "Extension is: $just_ext"
echo "Root is: $just_root"
