#! /usr/bin/zsh

# unlatin — convert file with latin encoding to utf-8

# Various tools (sed, CSV parsers) require extra work when dealing with
# ISO-8859 (latin), so this script converts safely to UTF-8. Run this in a
# pipeline when input encoding types are questionable.
#
# Typical encoding values from the `file` command are:
# * UTF-8
# * ASCII
# * ISO-8859

fl=${1?Must provide arg}
bak=$fl.orig

if file -b $fl |grep -q 8859; then
  #print "Detected latin; fixing in-place in 2s..."
  print "Detected latin; fixing in-place."
  #sleep 2
  mv $fl $bak
  iconv -f latin1 -t utf-8 $bak >$fl
  print "Created backup file: $bak"
else
  print "Not latin; no worries; not touching."
fi
