#!/usr/bin/env bash

### Configuration and flags
FORCE=0
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

### Logging functions
log_info() {
  echo -e "\e[34m[INFO]\e[0m $*"
}
log_success() {
  echo -e "\e[32m[SUCCESS]\e[0m $*"
}
log_warn() {
  echo -e "\e[33m[WARN]\e[0m $*"
}
log_error() {
  echo -e "\e[31m[ERROR]\e[0m $*" >&2
}

### Test logging
log_info 'This is info.'
log_success 'This is success.'
log_warn 'This is a warning.'
log_error 'This is an error.'
echo 'done'
