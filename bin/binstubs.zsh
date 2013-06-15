#! /bin/zsh

# binstubs — generate binstub symlinks for a set of dirs

# Some discussion:
# https://github.com/sstephenson/rbenv/wiki/Understanding-binstubs
#
# So this is just a simplified version using symlinks instead of setting up
# environments. Really only useful for standalone scripts, which many gists
# are.
#
# Suffers from fixed base dir due to `ln` not being able to work outside of
# cwd, and don't want to cd all around at this point. And several other
# shortcoming.

setopt extendedglob

#base=${1?Must provide base arg}
#start=${2-.}
base=.

#stubsdir=$base/bin
stubsdir=bin
ignores='(gems|forks)'

#bindirs=( $start/**/bin~**/$ignores )
#bindirs=( ./**/bin~**/$ignores )
#bindirs=( ./**/bin~**/${ignores}* )
# HACK: Need some eval trick for pre-glob expansion of $ignores
bindirs=( **/bin~**(gems|forks)* )

absstubsdir=$PWD/$stubsdir
if ! (( ${path[(i)$absstubsdir]} <= $#path )); then
  print "ERROR: first ensure that $absstubsdir is in your \$path\!"
  exit 1
fi

#print "Generating symlinks for the following dirs:"
#print -l $bindirs
print "Generating symlinks for $#bindirs dirs."


mkdir -p $stubsdir

for bdir in $bindirs; do
  [[ $bdir == $stubsdir ]] && continue
  #print "### $bdir"
  #ls -l $bdir
  # HACK: check for emtpy dir
  nfiles=$( ls $bdir |wc -l )
  (( nfiles == 0 )) && continue
  # Okay, they're not all executable, but might want resource-like files/dirs.
  for exe in $bdir/*; do
    [[ $exe:e == bat ]] && continue
    ln -s ../$exe $stubsdir/$exe:t
  done
done


# Remove (or warn of) dead symlinks
# http://www.zsh.org/mla/users/2005/msg00394.html

print "You should rehash now."
print "Peek in $stubsdir to see all your new scripts\!"
