#! /bin/zsh

# docxcat — dump docx files

docx=${1?Must provide docx}

for f in $argv; do
  # Stupid thing won't send messages to stderr.
  #lowriter --nologo --headless --convert-to pdf $f
  #pdfcat.zsh $f:r.pdf
  # More reliable way?
  unoconv -f doc $f
  antiword $f:r.doc
done

# Not tested yet.
es=$?
if [[ $? -gt 0 ]]; then
  print 'Oops, try catdoc'
  exit $es
fi

# Could do it in loop to one file, like in xlsxcat.
#
# touch all.txt; for r in *.rtf; do catdoc $r >$r:r.txt; print '='$r:r >>all.txt; cat $r:r.txt >>all.txt ;done
# http://superuser.com/questions/165978/command-line-tool-in-linux-to-extract-text-from-word-excel-powerpoint-or-co
# Also try: abiword --to=txt myfile.doc
