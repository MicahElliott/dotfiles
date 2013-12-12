#! /bin/zsh

# NAME — DESCRIPTION...

logger -s hi there

usage() {
  print "Usage: foo
  -s  something
  -u  other

Example:
  % foo [] ARG
"
  exit 1
}

usage

while getopts ':su:' arg; do
  case $arg in
    s) print got s; s=sss;;
    u) print got u;;
    \*) print nothing: $OPTARG; usage;;
    \?) print invalid option: $OPTARG; usage;;
  esac
done

print 'got here'
print "s: $s"

if [[ -f foo ]] print 'seeing foo'
