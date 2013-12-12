######################################################################
# Envars
#
# Things that are only used by Zsh should not be exported.
######################################################################

# ???: Maybe didn't want anything to look like DOS.
unset USERNAME

HISTIGNORE='k:ls:lm:bg:fg:jobs:pwd:kill:declare:history:cd:cd :&: *:'
HISTSIZE=20000
HISTFILESIZE=$HISTSIZE
#export HISTFILE=~/.history/bh-$$

# Mail agents need to see these
export EDITOR=vim
export XEDITOR=$EDITOR
export VISUAL=$EDITOR
#export VIMTAGS
export TMPDIR=~/tmp
export BROWSER=firefox-aurora  # previously: chromium, google-chrome  
export CHROME_BIN=/usr/bin/chromium
export DE=i3 # must be Desktop Environment (was xfce in archbang's .xinitrc)
export MAILCHECK=60

export IMGEDITOR=gimp
export IMGVIEWER=feh
export VPLAYER=smplayer
export APLAYER=mplayer

# Pager stuff
#export PAGER=most
#export PAGER=vimpager
export PAGER=less
# Enable ipython to display color sequences in PAGER (http://zi.ma/9e4f04)
export LESS='-F -R -S -X'
# Make less more friendly for non-text input files, see lesspipe(1)
# Set LESSOPEN/LESSCLOSE.
[[ -x /usr/bin/lesspipe ]] && eval "$(lesspipe)"
# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\e[01;31m'       # ??
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # headings
export LESS_TERMCAP_me=$'\e[0m'           # end
export LESS_TERMCAP_us=$'\e[04;38;5;82m' # emphasis
export LESS_TERMCAP_ue=$'\e[0m'           # end
export LESS_TERMCAP_so=$'\e[1;38;5;226;48;5;236m'    # footer, search, etc
export LESS_TERMCAP_se=$'\e[0m'           # end

export READNULLCMD=less

export EMAIL=$my_email
export REPLYTO=$EMAIL
export HGUSER="$my_fullname ($(hostname -s)) <$my_email>"
export HGMERGE=vimdiff
export HGEDITOR=hgeditor
export INPUTRC=~/.inputrc

# Python
#export PYTHONPATH="$HOME/local/lib/python:$HOME/local/lib/python/site-packages:$HOME/local/lib/python2.6/site-packages:$HOME/contrib/lib:."
# My personal python modules.
#export PYTHONPATH=$PYTHONPATH:"$HOME/lib/python"
export VIRTUAL_ENV_DISABLE_PROMPT=1
export VIRTUALENV_USE_DISTRIBUTE=1
export WORKON_HOME=$HOME/.virtualenvs
export DJANGO_SETTINGS_MODULE=settings

export RLWRAP_EDITOR="$EDITOR -c ':set filetype=clojure'"
export RLWRAP_OPTIONS='--multi-line -pyellow --remember --complete-filenames --histsize 10000'

# Might be enough for cljs.
export PATH=$PATH:/opt/clojurescript/bin

# TERM should be set in ~/.Xdefaults, if at all.
#export TERM=linux
#test "$OSTYPE" = "cygwin" &&
#    export TERM=dumb ||
#    export TERM=xterm
#export TERM=xterm
#export TERM=xterm-256color
export XTERM=urxvtcd
export TERMINAL=$XTERM

# Home path areas
# NOTE: ~/local is early since it should only be used to replace sys utils
export PATH=$HOME/bin:$HOME/local/bin:$HOME/contrib/bin:$PATH
# System path areas
# NOTE: stuff like /usr/local/bin should be added by any system, so
# don't want to duplicate them here.
# Administrative areas sometimes useful for non-root user.
# No longer needed on Arch
#export PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin

# Ruby
# FIXME: some gems want 1.8 (not 1.8.7) in PATH.
which ruby >/dev/null && {
    # Fastest way to get version. BUT STILL SLOWS DOWN SHELL STARTUP!
    #local rubyver=$( ruby -v |awk '{print $2}' )
    # Hack for 1.8.x (see http://gist.github.com/54177)
    #export RUBYOPT="rubygems"
    #export PATH=$PATH:$HOME/.gem/ruby/$rubyver/bin
    ##export PATH=$PATH:/var/lib/gems/$rubyver/bin
    # Try: gem help environment
    #export GEM_HOME=$HOME/.gem/ruby/$rubyver
}
export RUBYLIB=$HOME/proj/Membean/misc/bin

# rbenv
export PATH=$HOME/.rbenv/bin:$PATH
# SLOW!! Does a rehash.
#eval "$(rbenv init -)"

# chruby, completion, autoswitching (installed via yaourt)
source /usr/share/chruby/chruby.sh
RUBIES=( ~/.rbenv/versions/* )
export RUBIES
# https://github.com/postmodern/chruby/issues/27#issuecomment-16911865
compctl -g '~/.rbenv/versions/*(:t)' chruby
source /usr/share/chruby/auto.sh

# nvm: See ni/jsi funcs. Just a little too slow for every shell.

# Node http://tnovelli.net/blog/blog.2011-08-27.node-npm-user-install.html
export PATH=$HOME/.local/bin:$PATH

export DEBUG='brunch:*'

#export RAILS_ROOT=~/proj/Membean/mbg
#PATH+=:$RAILS_ROOT/script

# R
export PATH=$PATH:/usr/lib/R/bin
export PERL5LIB=$PERL5LIB:/usr/share/R/share/perl

# Membean
export PATH=$HOME/proj/Membean/misc/bin:$PATH
export PATH=$HOME/proj/Membean/misc/srm:$PATH
export PATH=$HOME/proj/Membean/mbg/script:$PATH
export MB=~/proj/Membean/mbg
export MB_MBG=$HOME/proj/Membean/mbg
export MB_WORDSTUDY=$HOME/proj/Membean/wordstudy
export MB_MISC=$HOME/proj/Membean/misc
export MB_YAML=$HOME/proj/Membean/mb-cont-yaml

# Haskell cabal stuff.
#export PATH=$HOME/.cabal/bin:$PATH

# Android SDK
#export PATH=$PATH:$HOME/opt/android-sdk-linux_86/tools
export PATH=$PATH:/opt/android-sdk/platform-tools
export PATH=$PATH:/opt/android-sdk/tools

# Recent Groovy
#export PATH=$HOME/opt/groovy-1.8.1/bin:$PATH

# Clojure
#export PATH=$HOME/.cljr/bin:$PATH
export PATH=$HOME/.lein/bin:$PATH

# Gitcontainer binstubs
export PATH=$PATH:$HOME/gitcontainer/bin

# Local dir stuff.
export PATH=$PATH:./bin

# Get rake to STFU.
export MAKE=make

# Sencha crap.
#export PATH=$PATH:$HOME/opt/SenchaArchitect:$HOME/opt/SenchaSDKTools-2.0.0-beta3

#export dir_stack=$HOME

## COLORS ############################################################
# Make dircolors work on non-RH systems.
[[ -e "$HOME/.dir_colors" ]] && export DIR_COLORS="$HOME/.dir_colors"
[[ -e "$DIR_COLORS" ]] || DIR_COLORS=""
# Must here trick dircolors into not seeing "256color".
# Results in “export LS_COLORS=…”
eval "$(TERM=xterm dircolors -b $DIR_COLORS)"

export LD_PRELOAD="/usr/lib/libstderred.so"


# Why was I doing this? Probably just for bash.
#PS1="\h$ "

# According to:
# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#SEC267
# you need to set HELPDIR to make mini-help with run-help work.
HELPDIR=~/local/doc/zsh/help  # was prescribed as /usr/share/zsh/help

L="/media/LACIE"

# Handy custom envars.
dn=/dev/null

# Archlinux dictionary
dict=/usr/share/dict/american-english

lh='localhost:3000'

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

#export JENKINS_USER=$my_fname

export SRM_REMOTE=1

#-- Bottom Matter ----------------------------------------------------

# I think this will uniqify PATH in case this file is re-sourced.
# Appears to need to be down here at bottom.
# http://www.zsh.org/mla/users/1998/msg00490.html
typeset -U path
