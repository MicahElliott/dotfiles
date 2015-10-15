#! /usr/bin/env zsh

# ipof — show ip of host in ssh config

host=${1?Must provide host}

grep -A1 "^Host $host" ~/.ssh/config |tail -1 |awk '{print $2}'
