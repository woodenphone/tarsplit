#!/usr/bin/env bash
## tarsplit-single.sh
## Create tars of a given size.
## Author: Ctrl-S
## Created: 2021-02-18
## Modified: 2021-02-18
this_file_path="tarsplit-single.sh"

# Use 'strict mode' for BASH to avoid bugs that can break something
set -euo pipefail # https://devhints.io/bash
IFS=$'\n\t' # http://redsymbol.net/articles/unofficial-bash-strict-mode/

new_vol() {
	## Pretend to be a tape changer.
	##
	echo "${pfx} vol_file=${vol_file}"

	## Prepare name for volume
	volno=$( cat "${volno_file?}" ) 
	# tar volume file is 1-indexed.
	echo "${pfx} volno=${volno}"
	# prev_volno="$(($volno-1))" # Convert from 1-indexed into 0-indexed

	## pad / zfill number https://stackoverflow.com/questions/5417979/batch-rename-sequential-files-by-padding-with-zeroes
	padded_num=`printf "%03d" "${volno?}"`
	echo "${pfx} padded_num=${padded_num}"

	new_path="${dest_path}.${padded_num}"
	echo "${pfx} new_path=${new_path}"
	# Move volume to new location:
	mv "${vol_file?}" "${new_path?}"
}

invoke_tar() {
	## Start tar when user invokes this script.
	##
	echo "${pfx} src=${src}"
	echo "${pfx} dest=${dest}"
	echo "${pfx} vol_file=${vol_file}"
	echo "${pfx} kb_limit=${kb_limit}"
	tar_args=(
		-cf
		"${vol_file?}" # Volume to write to.
		"${src?}" # Source files to tar.
		--recursion
		--multi-volume 
		--tape-length="${num_kb?}" # Integer number of KiB.
		--new-volume-script="${this_file_path?} -N" # Runs after each volume is maxed.
		--volno-file="${volno_file?}" # Holds volume counter.
		--checkpoint=1000 # Progress message every n files.
		)
	echo "${pfx} tar_args: ${tar_args[@]}"
	tar "${tar_args[@]}"
}

## Default values
is_nvscript=; # Null.
src=; # Null.
dest=; # Null.
vol_file=; # Null.
kb_limit=; # Null.

while getopts r:s:d:l:p: option
do case "${option}" in
N) is_nvscript=1;; # Are we called as --new-volume-script fomr tar?
s) src=${OPTARG};; # Source
d) dest=${OPTARG};; # Dest
v) vol_file=${OPTARG};; # volume file.
k) kb_limit=${OPTARG};; # volume file.
esac done

## What mode is this being run as?
if test $is_nvscript -gt 0; then
	pfx="nvol:"
	new_vol
else
	pfx="run:"
	start_epoch=`date +"%s"`
	echo "${pfx} Starting at start_epoch=${start_epoch}"
	invoke_tar
	end_epoch=`date +"%s"`
	echo "${pfx} End of script. start_epoch=${start_epoch}; end_epoch=${end_epoch}"
fi
echo "${pfx} EOF."