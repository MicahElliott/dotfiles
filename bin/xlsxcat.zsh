#! /bin/zsh

# xlsxcat — convert list of xlsx files

usage="USAGE: xlsxcat *.xlsx"
#xlsxs=${1?Must provide xlsx file(s)}
xlsxs=( $argv[1,-1] )
#print $xlsxs

mkdir -p tmp

for x in $xlsxs; do
  csv=tmp/$x:r.csv
  # Use -S for multiple worksheets. Will create csv.0, csv.1, ...
  ssconvert -S $x $csv &>/dev/null
  # Assume never more than 10 sheets!
  for c in $csv.<0-9>; do
    print '='$c
    cat $c
  done
done
