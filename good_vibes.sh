#!/usr/bin/env bash

_USER_NAME="${USER_NAME:-$USER}"
_USER_AGE="${USER_AGE:-""}"

compliment_name() {
  local name="$1"
  echo "Wow, $name, you have a beautiful name!"
}

compliment_age() {
  local name="$1"
  local age="$2"
  if [[ "$age" -gt '30' ]]; then
    echo "Seriously $name? I thought you were $(( age - 7 ))"
  else
    echo "Such a weird age, are you sure it'sa number?"
  fi
}

compliment_name 
compliment_age
