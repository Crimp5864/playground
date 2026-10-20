#!/usr/bin/env bash

# Check systems online

systems=(
	'latitude-e7440-0-nix.local'
	'latitude-e7440-1-nix.local'
	'satellite-c55t-nix.local'
)

check_up() {
	echo "---"
	echo "Initiating up check."
	echo "---"

	for system in "${systems[@]}"; do
		if ping -c 3 -W 2 "$system" &> /dev/null; then
			echo "$system is reachable."
		else
			echo "$system is unreachable."
		fi
	done
	
	echo "---"
	echo "Up check complete."
}

check_access() {
	echo "---"
	echo "Initiating access check."
	echo "---"	

	for system in "${systems[@]}"; do
		if ssh -o ConnectTimeout=3 -o BatchMode=yes "nick"@"$system" "true" &> /dev/null; then
			echo "System is accessible."
		else
			echo "System is inaccessible."
		fi
	done

	echo "---"
	echo "Access check complete."
}

check_up

check_access
