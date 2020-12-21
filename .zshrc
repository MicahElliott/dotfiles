# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -*- mode: sh -*-

######################################################################
# .zshrc
######################################################################

# Two reasons for splitting into files, instead of big unified .zshrc:
#
# 1. Can separate different things for different shells (zsh, bash)
#
# 2. Can have a “reload” util that just re`source`s a subset of the files.
#
# Using perlesque convention that ‘my_*’ vars are globally visible things that
# I have set.
#
# Noticed that archlinux et al do the same type of `source`ing of worker
# scripts in /etc/profile and /etc/profile.d/

# Timing
##zmodload zsh/zprof

# Specifics for user, to set subsequent envars
my_fname=micah
my_email='mde@micahelliott.com'
my_fullname='Micah Elliott'

my_shdir=~/config/shell

case $(uname) in
    Linux)   ostype=Linux ;;
    FreeBSD) ostype=FreeBSD ;;
    Darwin)  ostype=Darwin ;;
esac

# source ~/contrib/bin/antigen.zsh

# This order can be important. I like to make sure all the envars are
# set so subsequent functions etc can make use of them.
# Doing actions.sh early to avoid 3rd-party stuff overriding anything.
my_configs=(
    $my_shdir/macos.sh # no-op if not darwin
    $my_shdir/envars.sh
    $my_shdir/vendor.sh # activation of other scripts beyond my control
    $my_shdir/options.zsh # potential to be slow
    $my_shdir/aliases.sh
    $my_shdir/aliases.zsh
    $my_shdir/functions.sh
    # Load plugins manually since zplug is sooo slow.
    # And this makes it possible to run basic shells in vterm etc.
    # plugins.zsh
)
print 'Skipping plugins to enable faster minimal zsh.  Run ‘zp’ for full zplug.'
#my_plugins=( $my_shdir/zsh/plugins/*.zsh )
my_plugins=( )

# Time the stuff.
integer t0=$(date '+%s')

# Source all the Zsh-specific and sh-generic files.
for f in $my_configs; do
    ##print starting $f
    [[ -f $f ]] && . $f
    ##print finished $f
done
for plugin in $my_plugins; do
    #print "Enabling plugin: $plugin:t:r"
    #. $plugin
done
unset f plugin

# Site-specific
_siterc="$my_shdir/$(hostname).sh"
[[ -f $_siterc ]] && . $_siterc || :
unset _siterc

# VTerm promt/dir tracking
# https://github.com/akermu/emacs-libvterm#directory-tracking-and-prompt-tracking
# Start with a really simple prompt, enabling jumping with: C-c C-t ... C-c C-p
PROMPT='%1~ %# '
vterm_prompt_end() { vterm_printf "51;A$(pwd)" }
setopt PROMPT_SUBST
PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'


function {
    local -i t1 startup
    t1=$(date '+%s')
    startup=$(( t1 - t0 ))
    [[ $startup -gt 1 ]] && print "Hmm, poor shell startup time: $startup"
    ##print "startup time: $startup"
}
unset t0

# Timing
##zprof

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
