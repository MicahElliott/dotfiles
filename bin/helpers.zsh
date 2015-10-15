# helpers — utilities/helpers for zsh scripts (source this)
# Source this at top of your script; don't run it!
# Ex:
# . helpers.zsh

autoload -Uz colors; colors


### Absolute Paths
# Example showing absolute paths of running script.
# Node: __dirname and __filename
# Ruby: __FILE__
# Python: __file__
#print $PWD
#pwd -P
#print $0:h

__dirname__=$(cd -P $0:h && pwd -P)
__file__=$__dirname__/$0:t
#print $__dirname__
#print $__file__

### Reporting/Logging
error() {
    print "\n$fg[red]ERROR:$reset_color $@" >&2
    print "\n$usage"
    exit 1
}
err()     { print $1 >&2; exit 1 }
warn()    { print "$fg[yellow]WARNING:$reset_color $@" >&2 }
#warn()   { print $1 >&2 }
elapsed() { print $(( $(date +%s) - time0 )); }


### Usage
[[ $1 == '-h' ]] && { print $usage; exit }

requires() {
  for req in $*; do
    hash $req 2>/dev/null || err "missing requirement: $req"
  done
}
