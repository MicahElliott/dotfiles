#! /usr/bin/zsh

# descmulti — describe a dir full of scripts

usage="descmulti"

. helpers.zsh

requires desc.zsh

#for s in *.rb *.zsh; do
for s in *; do
  desc=$(desc.zsh $s)
  if [[ -n $desc ]]; then
    print "${s:r}:\t$desc"
  else
    warn "no description: $s"
  fi
done
