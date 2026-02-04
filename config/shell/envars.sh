######################################################################
# Envars
#
# Things that are only used by Zsh should not be exported.
######################################################################

# Work stuff, not in git
export WORK_ENV=~/config/shell/work.sh
if [[ ! -f $WORK_ENV ]]; then
    print "Missing non-git $WORK_ENV environment file." 2>&1
else
    print "enabling work_env"
    . $WORK_ENV
fi

# ???: Maybe didn't want anything to look like DOS.
unset USERNAME

# Unnecessary??
#export GPG_TTY=$(tty)

#print "Enabling gpg-agent env stuff"
#. ~/.gpg-agent-info

# Maybe not what I want, but trying it out -- used by emacs' age.el
export PINENTRY_PROGRAM=pinentry-gnome3

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache

# Mail agents need to see these
#export EDITOR=vim
export EDITOR=emacsclient
export ALTERNATE_EDITOR=''
export XEDITOR=$EDITOR
export VISUAL=$EDITOR
#export VIMTAGS
export TMPDIR=~/tmp
export BROWSER=firefox  # previously: chromium, google-chrome
export CHROME_BIN=/usr/bin/chromium
# export DE=i3 # must be Desktop Environment (was xfce in archbang's .xinitrc)
export MAILCHECK=60

if [[ $OSTYPE =~ '^darwin' ]]; then CLIPPER=pbcopy; else CLIPPER=xclip; fi
export CLIPPER

export IMGEDITOR=gimp
export IMGVIEWER=feh
export VPLAYER=smplayer
export APLAYER=mplayer

export RBW_MENU_COMMAND="fzf"

# Pager stuff
#export PAGER=most
#export PAGER=vimpager
export PAGER=less
# Enable ipythoN to display color sequences in PAGER (http://zi.ma/9e4f04)
export LESS='-R -S -X'
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

export TMUXCOLOR=white

export EMAIL=$my_email
export REPLYTO=$EMAIL

export INPUTRC=~/.inputrc

# Python
#export PYTHONPATH="$HOME/local/lib/python:$HOME/local/lib/python/site-packages:$HOME/local/lib/python2.6/site-packages:$HOME/contrib/lib:."
# My personal python modules.
#export PYTHONPATH=$PYTHONPATH:"$HOME/lib/python"
export VIRTUAL_ENV_DISABLE_PROMPT=1
export VIRTUALENV_USE_DISTRIBUTE=1
export WORKON_HOME=$HOME/.virtualenvs
export DJANGO_SETTINGS_MODULE=settings

export PATH=$PATH:/miniconda3/bin

path+=~/.pyenv/bin
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

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
# export XTERM=urxvtcd

# export TERM=kitty
# export TERMINAL=$TERM

# Needed for eshell
#CDPATH=$cdpath
#export CDPATH

export mp=~/proj
export gp=~/gitcontainer/projects

# Home path areas
# NOTE: ~/local is early since it should only be used to replace sys utils
export PATH=$HOME/bin:$HOME/local/bin:$HOME/contrib/bin:$PATH
# System path areas
# NOTE: stuff like /usr/local/bin should be added by any system, so
# don't want to duplicate them here.
# Administrative areas sometimes useful for non-root user.
# No longer needed on Arch
export PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin

# Ruby
# FIXME: some gems want 1.8 (not 1.8.7) in PATH.
which ruby >/dev/null && {
    # Fastest way to get version. BUT STILL SLOWS DOWN SHELL STARTUP!
    #local rubyver=$( ruby -v |awk '{print $2}' )
    # Hack for 1.8.x (see http://gist.github.com/54177)
    #export RUBYOPT="rubygems"
    #export PATH=$PATH:$HOME/.gem/ruby/$rubyver/bin
    path+=~/.gem/ruby/2.2.0/bin
    # path+=~/.gem/ruby/2.4.0/bin
    ##export PATH=$PATH:/var/lib/gems/$rubyver/bin
    # Try: gem help environment
    #export GEM_HOME=$HOME/.gem/ruby/$rubyver
}

# print 'enabling chruby'
# source /usr/local/share/chruby/chruby.sh
# source /usr/local/share/chruby/auto.sh
# path+=~/.gem/ruby/bin

# Node
# nvm: See ni/jsi funcs. Just a little too slow for every shell.
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$HOME/.local/bin:$PATH

# Node http://tnovelli.net/blog/blog.2011-08-27.node-npm-user-install.html
# export PATH="$HOME/.npm/bin:$PATH"
# export N_PREFIX=$HOME/.n
# export PATH="$PATH:$N_PREFIX/bin"

# https://stackoverflow.com/questions/18088372/how-to-npm-install-global-not-as-root
export NPM_PACKAGES="${HOME}/.npm"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$NPM_PACKAGES/bin:$PATH"

#export DEBUG='brunch:*'

# https://github.com/visionmedia/n
# export N_PREFIX=~/local

# R
export PATH=$PATH:/usr/lib/R/bin
export PERL5LIB=$PERL5LIB:/usr/share/R/share/perl

# Android SDK
#export PATH=$PATH:$HOME/opt/android-sdk-linux_86/tools
export PATH=$PATH:/opt/android-sdk/platform-tools
export PATH=$PATH:/opt/android-sdk/tools

# Clojure
#export PATH=$HOME/.cljr/bin:$PATH
export PATH=$HOME/.lein/bin:$PATH
export BOOT_CLOJURE_VERSION=1.10.0
# Stop java 14 warnings: Options -Xverify:none and -noverify were deprecated in JDK 13
# https://github.com/technomancy/leiningen/issues/2611#issuecomment-577288859
export LEIN_JVM_OPTS="-XX:TieredStopAtLevel=1"

path+=~/src/cljfmt-graalvm

path+=~/proj/captainhook/bin
path+=~/proj/tufa/bin
path+=~/proj/havoc/bin
path+=~/proj/manget/bin

# path+=~/.jenv/bin

# Gitcontainer binstubs
export PATH=$PATH:$HOME/gitcontainer/bin

# Local dir stuff.
export PATH=$PATH:./bin

# Racket tools
export PATH=/opt/racket/bin:$PATH
path+=$HOME/gitcontainer/projects/reptl

# OCaml (or: eval `opam config env`)
export MANPATH="$HOME/.opam/system/man:$MANPATH"
export PATH="$HOME/.opam/system/bin:$PATH"
export CAML_LD_LIBRARY_PATH="$HOME/.opam/system/lib/stublibs:/usr/lib/ocaml/stublibs"
export PERL5LIB="$HOME/.opam/system/lib/perl5:/usr/share/R/share/perl:/usr/share/R/share/perl:$PERL5LIB"
export OCAML_TOPLEVEL_PATH="$HOME/.opam/system/lib/toplevel"

# Get rake to STFU.
export MAKE=make

export VAGRANT_DEFAULT_PROVIDER=libvirt

# Golang
export GOPATH=~/go
# export PATH=$PATH:$GOPATH/bin
# export PATH=$PATH:$GOROOT/bin
path+=$GOPATH/bin
export GOROOT=~/.g/go
path=($GOROOT/bin $path)

path+=~/.cargo/bin

# Zig
path+=~/src/zig/zig-x86_64-linux-0.15.1

# BQN
path+=~/src/CBQN

export EGET_BIN=~/.local/bin

export CAPT_VERBOSE=1 CAPT_INTERACTIVE=1

export OLLAMA_API_BASE='http://127.0.0.1:11434'

# SDKMAN https://github.com/sdkman/sdkman-cli
# print 'enabling sdkman (SLOW)'
# export SDKMAN_DIR=~/.sdkman
# [[ -s ~/.sdkman/bin/sdkman-init.sh ]] && source ~/.sdkman/bin/sdkman-init.sh

# path+=~/vendor/flutter/bin

# path+=~/vendor/confluent-5.3.1/bin
# path+=~/vendor/confluent-cli

# ## ASDF
# print 'enabling asdf'
# . $HOME/.asdf/asdf.sh
# # append completions to fpath
# fpath=(${ASDF_DIR}/completions $fpath)

# Rabbitmq
path+=/usr/local/opt/rabbitmq/sbin


# export SCAD_DOCKER=podman
alias docker=podman
# export SCAD_DOCKER=docker
export SCAD_DOCKER=podman


# stderred: stderr in red (https://github.com/ku1ik/stderred)
# Doesn't work with magit-process: color doesn't reset and everything after an error stays red
# export LD_PRELOAD="$HOME/src/stderred/build/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"


## COLORS ############################################################
# Make dircolors work on non-RH systems.
print 'enabling dircolors'
# [[ -e "$HOME/proj/dircolors/dir_colors" ]] && export DIR_COLORS="$HOME/proj/dircolors/dir_colors" ||
export DIR_COLORS="$HOME/proj/dircolors/dir_colors"
[[ -e $DIR_COLORS ]] || echo "Could not find dir_colors: $DIR_COLORS"
# [[ -e "$DIR_COLORS" ]] || DIR_COLORS=""

# https://github.com/trapd00r/LS_COLORS
# Must here trick dircolors into not seeing "256color".
# Results in “export LS_COLORS=…”
eval "$(TERM=xterm dircolors -b $DIR_COLORS)"
# source ~/src/LS_COLORS/lscolors.sh
# Enable colors for tab-completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Handy custom envars.
dn=/dev/null
sc=~/.ssh/config

# Archlinux dictionary
# dict=/usr/share/dict/american-english
dict=~/contrib/dict/10k-3.num
DICT=~/contrib/dict/10k-3.num
freqs=~/contrib/unigram_freq.csv
freqs2=~/contrib/unigram_freq2.lst
# More generic symlink to actual dictionary
words=/usr/share/dict/words

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


#-- Bottom Matter ----------------------------------------------------

# I think this will uniqify PATH in case this file is re-sourced.
# Appears to need to be down here at bottom.
# http://www.zsh.org/mla/users/1998/msg00490.html
typeset -U path
