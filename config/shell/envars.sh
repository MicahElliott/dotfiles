######################################################################
# Envars
#
# Things that are only used by Zsh should not be exported.
######################################################################

# ???: Maybe didn't want anything to look like DOS.
unset USERNAME

my_zshdir=~/config/shell

HISTIGNORE='k:ls:lm:bg:fg:jobs:pwd:kill:declare:history:cd:cd :&: *:'
HISTSIZE=10000
HISTFILESIZE=$HISTSIZE
#export HISTFILE=~/.history/bh-$$

# mail agents need to see these
export EDITOR=vim
export XEDITOR=vim
export VISUAL=vim
export HGEDITOR=hgeditor
#export VIMTAGS
export TMPDIR=~/tmp
#export BROWSER=chromium-browser
export BROWSER=epiphany-browser
export MAILCHECK=60

export PAGER=less
#export PAGER=most
# Enable ipython to display color sequences in PAGER (http://zi.ma/9e4f04)
export LESS='-F -R -S -X'
# Make less more friendly for non-text input files, see lesspipe(1)
# Set LESSOPEN/LESSCLOSE.
[[ -x /usr/bin/lesspipe ]] && eval "$(lesspipe)"

#export REPLYTO="micah.d.elliott@intel.com"
export EMAIL="mde@MicahElliott.com"
export HGUSER="Micah Elliott ($(hostname -s)) <mde@MicahElliott.com>"
export HGMERGE=vimdiff
export INPUTRC=~/.inputrc
#export PYTHONPATH="$HOME/local/lib/python:$HOME/local/lib/python/site-packages:$HOME/local/lib/python2.6/site-packages:$HOME/contrib/lib:."
# Micah's personal python modules.
#export PYTHONPATH=$PYTHONPATH:"$HOME/lib/python"
export VIRTUAL_ENV_DISABLE_PROMPT=1
export DJANGO_SETTINGS_MODULE=settings
#export UGRAPH_ROOT=$HOME/

export RLWRAP_EDITOR="vim -c ':set filetype=clojure'"
export RLWRAP_OPTIONS='--multi-line -pyellow --remember -c'

#export TERM=linux
#test "$OSTYPE" = "cygwin" &&
#    export TERM=dumb ||
#    export TERM=xterm
#export TERM=xterm
#export TERM=xterm-256color
export XTERM=urxvtcd

# Home path areas
# NOTE: ~/local is early since it should only be used to replace
# system utils; e.g., hg.
export PATH=$HOME/bin:$HOME/local/bin:$HOME/contrib/bin:$PATH
# System path areas
# NOTE: stuff like /usr/local/bin should be added by any system, so
# don't want to duplicate them here.
# Administrative areas sometimes useful for non-root user.
export PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin

# Ruby
# FIXME: some gems want 1.8 (not 1.8.7) in PATH.
which ruby >/dev/null && {
    # Fastest way to get version.
    local rubyver=$( ruby -v |awk '{print $2}' )
    # Hack for 1.8.x (see http://gist.github.com/54177)
    #export RUBYOPT="rubygems"
    #export PATH=$PATH:$HOME/.gem/ruby/$rubyver/bin
    ##export PATH=$PATH:/var/lib/gems/$rubyver/bin
    # Try: gem help environment
    #export GEM_HOME=$HOME/.gem/ruby/$rubyver
}

# rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

#export RAILS_ROOT=~/proj/Membean/mbg
#PATH+=:$RAILS_ROOT/script

# R
export PATH=$PATH:/usr/lib/R/bin
export PERL5LIB=$PERL5LIB:/usr/share/R/share/perl

# Membean
export PATH=$HOME/proj/Membean/misc/bin:$PATH
export PATH=$HOME/proj/Membean/mbg/script:$PATH
export MB=~/proj/Membean/mbg
export MB_MBG=$HOME/proj/Membean/mbg
export MB_WORDSTUDY=$HOME/proj/Membean/wordstudy
export MB_MISC=$HOME/proj/Membean/misc
export MB_YAML=$HOME/proj/Membean/mb-cont-yaml

# Haskell cabal stuff.
export PATH=$HOME/.cabal/bin:$PATH

# Android SDK
export PATH=$PATH:$HOME/opt/android-sdk-linux_86/tools

# Recent Groovy
export PATH=$HOME/opt/groovy-1.8.1/bin:$PATH

#export PATH=$HOME/.cljr/bin:$PATH
export PATH=$HOME/.lein/bin:$PATH

# Local stuff.
export PATH=$PATH:./bin

# Get rake to STFU.
export MAKE=make

#export dir_stack=$HOME

## COLORS ############################################################
# Make dircolors work on non-RH systems.
[[ -e "$HOME/.dir_colors" ]] && export DIR_COLORS="$HOME/.dir_colors"
[[ -e "$DIR_COLORS" ]] || DIR_COLORS=""
# Must here trick dircolors into not seeing "256color".
# Results in “export LS_COLORS=…”
eval "$(TERM=xterm dircolors -b $DIR_COLORS)"

# Why was I doing this? Probably just for bash.
#PS1="\h$ "

# According to:
# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#SEC267
# you need to set HELPDIR to make mini-help with run-help work.
HELPDIR=/usr/share/zsh/help

L="/media/LACIE"

export VIRTUALENV_USE_DISTRIBUTE=1
export WORKON_HOME=$HOME/.virtualenvs

# Colorful pager.

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\e[01;31m'       # ??
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # headings
export LESS_TERMCAP_me=$'\e[0m'           # end
export LESS_TERMCAP_us=$'\e[04;38;5;82m' # emphasis
export LESS_TERMCAP_ue=$'\e[0m'           # end
export LESS_TERMCAP_so=$'\e[1;38;5;226;48;5;236m'    # footer, search, etc
export LESS_TERMCAP_se=$'\e[0m'           # end

# How color sequences work:
# echo $'\e[1;4;5;38;5;118;42m'" hi there "
# That says "1,4,5 are codes preceding the detected special code 38.
# There's something about 38 that makes this work.
# Then look ahead for another detectable code and find 118. Since
# there's a 5 preceding it, interpret it as a 256. Finally, detect the
# BG 42 code at the end.

#SSHAGENT=/usr/bin/ssh-agent
#SSHAGENTARGS="-s"
#if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
#    eval `$SSHAGENT $SSHAGENTARGS`
#    trap "kill $SSH_AGENT_PID" 0
#fi

export JENKINS_USER=micah


#-- Bottom Matter ----------------------------------------------------

# I think this will uniqify PATH in case this file is re-sourced.
# Appears to need to be down here at bottom.
# http://www.zsh.org/mla/users/1998/msg00490.html
typeset -U path
