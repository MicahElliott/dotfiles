#! /bin/zsh

# telediff — remote diff two files

# Conveniently follows same format/order as scp since common subsequent step

usage="Usage: $0:t HOST:FILE [FILE]

Example:
  % $0:t foo/foo.sh staging.example.com:misc/bin/foo.sh
"

. helpers.zsh
requires colordiff

[[ -z $1 ]] || [[ -z $2 ]] && { print $usage; exit }

rspec="$2"
host=${rspec[(ws.:.)1]}
rpath=${rspec[(ws.:.)2]}
# Don't be too fancy; just require both args
#[[ -z $2 ]] && lpath=$rpath:t || lpath=$2
lpath=$1

print comparing: $lpath $host:$rpath
colordiff -u $lpath <(ssh $host "cat $rpath") || {
  print "\n\nYou might want to copy your version across:"
  print "  scp $lpath $host:$rpath"
}
