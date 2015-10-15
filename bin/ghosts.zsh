#! /usr/bin/env zsh

# ghosts — grep hosts in ssh config

#pat=${1?Must provide arg}
pat=${1-}

ghosts() {
  local all names ips pat=$1
  all=$(grep -A1 "^Host $pat" ~/.ssh/config)
  names=( $(awk '/^Host / {print $2}' <<<$all) )
  ips=( $(awk '/^  Hostname / {print $2}' <<<$all) )
  paste =(print -l $names) =(print -l $ips)
}

ghosts $pat
