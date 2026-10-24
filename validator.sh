#!/usr/bin/env bash

read -p 'Enter an email address: ' input

if [[ "$input" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo 'Valid! You entered a valid email address.'
  else
      echo 'Error: Not a valid email address.'
fi
