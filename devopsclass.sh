#!/usr/bin/env bash

# Root check
if [ "$EUID" -ne 0 ]; then
	echo "Must be run as root (or with sudo)"
	exit 1
fi

echo "Script to install git"
echo "Installation started"

if [ "$( uname )" == "Linux" ]; then
	echo "Operating system is Linux, installing git"
	dnf install git -y
elif [ "$( uname )" == "Darwin" ]; then
	echo "Operating system is MacOS, installing git"
	brew install git
else
	echo "Not installing git"
fi
