######################################################################
# Options
######################################################################

# New shopt-style.
shopt -s cdable_vars
# Do hash checking, since hashall is on.
shopt -s checkhash
# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s histappend

# Old set-style.
shopt -s -o history
shopt -s -o histexpand
# Don't logout on ^D.
shopt -s -o ignoreeof
# Don't let '>' redirects accidentally clobber an existing file.
shopt -s -o noclobber
# Extended globbing
shopt -s extglob
