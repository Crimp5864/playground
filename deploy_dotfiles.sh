#!/usr/bin/env bash

# Deploy dotfiles

# Absolute path to the dotfiles repository
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
BACKED_UP=false

# Define mappings: ["repo_path"]="target_path_relative_to_home"
declare -A FILES=(
	['home/dot_bash_profile']='.bash_profile'
	['home/dot_bashrc.d/aliases']='.bashrc.d/aliases'
	['home/dot_bashrc.d/functions']='.bashrc.d/functions'
	['home/dot_config/git/config']='.config/git/config'
	['home/dot_config/git/ignore']='.config/git/ignore'
	['home/dot_config/msmtp/config']='.config/msmtp/config'
	['home/dot_config/vim/vimrc']='.config/vim/vimrc'
	['home/dot_ssh/authorized_keys']='.ssh/authorized_keys'
)

echo '===> Starting dotfiles installation'

for src_rel in "${!FILES[@]}": do
	src="$DOTFILES_DIR/$src_rel"
	dest="$HOME/${FILES[$src_rel]}"
	dest_dir="$(dirname "$dest")"

	# 1. Verify source exists in repo
	if [ ! -e "$src" ]; then
		echo "  [Skipping] Source not found: $src"
		continue
	fi

	# 2. Ensure target directory exists
	if [ ! -d "$dest_dir" ]; then
		mkdir --parents "$dest_dir"
	fi
