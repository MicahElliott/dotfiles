#! /bin/zsh

# xlsxcat — convert list of xlsx files

usage="USAGE: xlsxcat *.xlsx"
#xlsxs=${1?Must provide xlsx file(s)}
xlsxs=( $argv[1,-1] )
#print $xlsxs

for x in $xlsxs; do
  csv=$x:r.csv
  print '='$x:r
  ssconvert $x $csv &>/dev/null
  cat $csv
done
