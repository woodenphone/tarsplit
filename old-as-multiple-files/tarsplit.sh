#!/usr/bin/env bash
## tarsplit.sh
## Author: Ctrl-S
## Created: 2021-02-18
## Modified: 2021-02-18
pfx="tarsplit.sh:"

# Use 'strict mode' for BASH to avoid bugs that can break something
set -euo pipefail # https://devhints.io/bash
IFS=$'\n\t' # http://redsymbol.net/articles/unofficial-bash-strict-mode/


## 
## == Options ==
##
source tarsplit.config.sh ## Uses vars:
# num_kb="10485760" # 10 GiB = 10485760 KiB
# nv_script="nv_script.sh"
# src="/mnt/tape-temp/co/" ## src.
# vol_file="/mnt/tape-temp/split/volume.tar" ## intermediate file.
# dest_path="/mnt/tape-temp/split/co.tar" # dest filename. a padded number is appended to this.
# volno_file="/mnt/tape-temp/tarsplit/volumenumber.txt"

##
## == Actual tasks ==
##
start_epoch=`date +"%s"`
echo "${pfx} Starting at start_epoch=${start_epoch}"


## Dirs must exist.
vol_dir=$(dirname $vol_file)
echo "${pfx} vol_dir=${vol_dir}"
mkdir -vp "${vol_dir}"
dest_dir=$(dirname $dest_path)
echo "${pfx} dest_dir=${dest_dir}"
mkdir -vp "${dest_dir}"


tar_args=(
	-cf
	"${vol_file}" # Volume to write to.
	"${src}" # Source files to tar.
	--recursion
	--multi-volume 
	--tape-length="${num_kb}" # Integer number of KiB.
	--new-volume-script="${nv_script}" # Runs after each volume is maxed.
	--volno-file="${volno_file}" # Holds volume counter.
	--checkpoint=1000 # Progress message every n files.
	)

echo "${pfx} tar_args: ${tar_args[@]}"
tar "${tar_args[@]}"

end_epoch=`date +"%s"`
echo "${pfx} End of script. start_epoch=${start_epoch}; end_epoch=${end_epoch}"