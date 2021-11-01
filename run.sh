tb=$1
shift
bsc -sim -u -g mkTb $tb && bsc -sim -e mkTb && ./bsim $@
