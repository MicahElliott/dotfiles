#! /usr/bin/env zsh

# desktop-spin — rotate through i3 desktops

delay=5s

while `true`; do
  for i in {1..4}; do
    i3-msg "workspace number $i"
    sleep $delay
  done
done
