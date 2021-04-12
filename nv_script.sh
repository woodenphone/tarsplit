#!/usr/bin/env bash
## nv_script.sh
## (Used by tarsplit.sh)
## Runs between pseudo-volumes
## Author: Ctrl-S
## Created: 2021-02-18
## Modified: 2021-02-18
pfx="nv_script.sh:"
echo "${pfx} Start."


# Use 'strict mode' for BASH to avoid bugs that can break something
set -euo pipefail # https://devhints.io/bash
IFS=$'\n\t' # http://redsymbol.net/articles/unofficial-bash-strict-mode/



source tarsplit.config.sh ## Uses vars:
# num_kb="10485760" # 10 GiB = 10485760 KiB
# nv_script="nv_script.sh"
# src="/mnt/tape-temp/co/co/" ## src.
# vol_file="/mnt/tape-temp/tarsplit/volume.tar" ## intermediate file.
# dest_path="/mnt/tape-temp/tarsplit/co.tar" # dest filename. a padded number is appended to this.
# volno_file="/mnt/tape-temp/tarsplit/volumenumber.txt"

##
## == Actual tasks ==
##


echo "${pfx} vol_file=${vol_file}"
## Prepare name for volume

volno=$( cat "${volno_file}" ) 
# tar volume file is 1-indexed.
echo "${pfx} volno=${volno}"
# prev_volno="$(($volno-1))" # Convert from 1-indexed into 0-indexed

## pad / zfill number https://stackoverflow.com/questions/5417979/batch-rename-sequential-files-by-padding-with-zeroes
padded_num=`printf "%03d" "$volno"`
echo "${pfx} padded_num=${padded_num}"

new_path="${dest_path}.${padded_num}"
echo "${pfx} new_path=${new_path}"

mv "${vol_file}" "${new_path}"

echo "${pfx} End."