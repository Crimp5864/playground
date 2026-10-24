#!/usr/bin/env bash

API_KEY="Some value"

: "${API_KEY:?Error: API_KEY environment variable must be set.}"

echo "The value of API_KEY is: $API_KEY"
