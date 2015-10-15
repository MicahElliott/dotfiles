#! /usr/bin/env zsh

# sshrmkey — delete a line containing stale/offending key

line=${1?Must provide offending line}

sed -i "${line}d" ~/.ssh/known_hosts
