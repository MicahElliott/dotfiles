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
