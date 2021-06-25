#!/usr/bin/env bash
## tarsplit.config.sh
## Author: Ctrl-S
## Created: 2021-02-18
## Modified: 2021-02-18

## 
## Options
##
num_kb="10485760" # 10 GiB = 10485760 KiB
nv_script="/mnt/tape-temp/tarsplit/nv_script.sh"
src="/mnt/tape-temp/co/co/" ## src.
vol_file="/mnt/tape-temp/tarsplit/volume.tar" ## intermediate file.
dest_path="/mnt/tape-temp/tarsplit/co.tar" # dest filename. a padded number is appended to this.
volno_file="/mnt/tape-temp/tarsplit/volumenumber.txt"