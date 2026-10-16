#!/usr/bin/env bash

# System info and resource usage script

## Configuration
# System
[[ -r /etc/os-release ]] && source /etc/os-release
os_name="$NAME"
os_version="$VERSION_ID"
host_name="$HOSTNAME"
cat << EOF
===========================
 SYSTEM INFORMATION REPORT
===========================
 Hostname : $host_name
 OS	  : $os_name $os_version
===========================
EOF

# Read line by line until we find the model name, then extract it
while IFS=':' read -r key value; do
    # Clean up leading/trailing whitespace
    key="${key//[[:space:]]/}"
    if [[ "$key" == "modelname" ]]; then
        cpu_model="${value# }" # Strip leading space
        break
    fi
done < /proc/cpuinfo
echo "CPU model is $cpu_model"

# Data

# Formatting

# Output
