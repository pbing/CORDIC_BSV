#!/bin/zsh
export BSC_OPTIONS="$BSC_OPTIONS -opt-undetermined-vals -unspecified-to X"
bsc -verilog -u $@
