#! /bin/zsh

# telediff — remote diff two files

usage="Usage: $0:t HOST:FILE [FILE]

Example:
  % $0:t staging.example.com:misc/bin/db2git.sh foo/mydb2.sh
"

. utilsrc.zsh
requires colordiff

[[ -z $1 ]] && { print $usage; exit }

rspec="$1"
host=${rspec[(ws.:.)1]}
rpath=${rspec[(ws.:.)2]}
[[ -z $2 ]] && lpath=$rpath:t || lpath=$2

#colordiff -u <(ssh $host 'cat membean/misc/bin/db2git.sh') $lpath
colordiff -u <(ssh $host "cat $rpath") $lpath
