#! /bin/zsh

# histgrep — grep for pattern in zsh history, and print human-readable datestamp

pat=${1?Must provide pattern}

IFS=$'\n' items=( $(grep -P $pat ~/.zsh_history) )

for i in $items; do
  stamp=$(sed -r 's/: ([0-9]+):.*/\1/' <<<$i)
  day=$(date -d @$stamp '+%F %a %T')
  cmd=$(sed -r 's/: ([0-9]+):0;//' <<<$i)
  print "$day -- $cmd"
done
