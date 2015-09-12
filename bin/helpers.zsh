# utilsrc — utilities for zsh scripts

autoload -Uz colors; colors

error() {
    print "\n$fg[red]ERROR:$reset_color $@" >&2
    print "\n$usage"
    exit 1
}
err()     { print $1 >&2; exit 1 }
warn()    { print "$fg[yellow]WARNING:$reset_color $@" >&2 }
#warn()   { print $1 >&2 }
elapsed() { print $(( $(date +%s) - time0 )) }

[[ $1 == '-h' ]] && { print $usage; exit }

requires() {
  for req in $*; do
    hash $req 2>/dev/null || err "missing requirement: $req"
  done
}
