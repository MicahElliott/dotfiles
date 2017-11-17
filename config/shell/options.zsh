# -*- mode: sh -*-
# Zsh-specific options and params setup.
# See zshoptions for setopt stuff.
# See zshparam for envars that affect environment.
# Note that vars like CDPATH/cdpath, PATH/pathstay in sync when you edit
# just one. Lower-cased is the convenient array form.


######################################################################
### Params (need to come before autoload stuff)

# Search path for function defs; add mine here.
# System completions live in:
#   /usr/share/zsh/functions/Completion/Unix/
# so have a local personal dir similar.
#fpath=( $fpath ~/config/shell/funcs )
# My funcs.
fpath=( ~/config/shell/zsh/functions $fpath )
# My prompts.
fpath=( ~/config/shell/zsh/prompts $fpath )
# Contrib funcs.
fpath=( ~/contrib/zsh/functions $fpath )

# Necessary?
#fpath+=( ~/config/shell/ )

# fpath+=/home/mde/gitcontainer/projects/hap
# path+=/home/mde/gitcontainer/projects/hap

#fpath+=~/gitcontainer/projects/zsh-ansible

# Zsh book pg 334
fpath=( ~/.zfunc $fpath )
autoload -- ~/.zfunc/[^_]*(:t)

# Funny stuff like this might be necessary for activating new funcs:
##local f
##f=(~/exp/zsh/fun/*(.))
##unfunction $f:t 2> /dev/null
##autoload -U $f:t
##compinit


# Stupid pip has to be different; using the old zshcompctl completion system.
# Generated by ‘pip completion --zsh’
# pip zsh completion start
#function _pip_completion {
  #local words cword
  #read -Ac words
  #read -cn cword
  #reply=( $( COMP_WORDS="$words[*]" COMP_CWORD=$(( cword-1 )) PIP_AUTO_COMPLETE=1 $words[1] ) )
#}
#compctl -K _pip_completion pip
# pip zsh completion end


# This is awesome! Tab-completion works to expand these!
# Needs to only include dirs that don’t have lots of subdirs.
# Test the reach of this with ‘mkdir foo; cd foo; cd <tab>; rmdir foo’
cdpath=(  ~/proj /media/LACIE
         ~/gitcontainer/collections/reference ~/gitcontainer/gists ~/config
         ~/clients )
# cd-able locations. Also awesome. Going with convention of 'd' prefix
# to later enable some completion of "cd d«tab»" to expand only cdables,
# since presently there's no reasonable way for zsh to know which of so
# many envars to expand.
dz=~/proj/cliguy/zsh/zshcasts
dsg=~/clients/huawei/dev/eBento2-ServicesGateway-testg
dsrc=~/archive/src

# Doesn't seem to work for vi-movement.
# Good for emacs word-separation (like vim's `iskeyword`
# http://stackoverflow.com/questions/444951/zsh-stop-backward-kill-word-on-directory-delimiter
WORDCHARS='_'

# Set output of time cmd
# Default %J %U user %S system %P cpu %*E total
TIMEFMT='%U user, %S kernel, %P cpu, %M mbmaxmem, %X kbheap, %D kbstack, %K kbspacetot, %*E totelapsed'

# https://stackoverflow.com/questions/10847255/how-to-make-zsh-forward-word-behaviour-same-as-in-bash-emacs
# Emacs-like navigation
# Corresponding function in ~/contrib/zsh/functions/forward-word-match
autoload -U select-word-style
select-word-style bash

######################################################################
### Funky stuff — not exactly options/params

# The following lines were added by compinstall
zstyle :compinstall filename '/home/mde/.zshrc'

autoload -Uz compinit; compinit

## Help system. See zshcontrib(1) for instructions.
unalias run-help
autoload run-help

# Trying auto-completion
# https://unix.stackexchange.com/questions/84844/make-zsh-completion-show-the-first-guess-on-the-same-line-like-fishs
# autoload predict-on
# predict-on

# According to:
# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#SEC267
# you need to set HELPDIR to make mini-help with run-help work.
#print "ENABLE: run-help, if not on system (ex: /usr/share/zsh/5.0.5/help/)"
#print "  by downloading/extracting zsh sources.\n"
# Manual steps:
#   cd ~/tmp"
#   wget 'http://downloads.sourceforge.net/project/zsh/zsh/5.0.5/zsh-5.0.5.tar.bz2'"
#   tar xjvf 'http://downloads.sourceforge.net/project/zsh/zsh/5.0.5/zsh-5.0.5.tar.bz2'"
#   perl zsh-5.0.5/Util/helpfiles zshbuiltins ~/local/doc/zsh/help"
#HELPDIR=~/local/doc/zsh/help
# Probably no longer needed:
# HELPDIR=/usr/share/zsh/5.4.2/help
# [[ -d $HELPDIR ]] || print "WARNING: change HELPDIR in options.zsh from non-existent $HELPDIR"
bindkey "^[h" run-help
bindkey "^[H" run-help

# Arch zsh packages.
# https://github.com/zsh-users/zsh-syntax-highlighting/tree/master/highlighters
# Options:
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/highlighters/main/main-highlighter.zsh
if [[ -f /etc/redhat-release ]]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets pattern )
# Hmm, just basic colors? rgybmc
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=cyan
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=cyan
#ZSH_HIGHLIGHT_STYLES[assign]=none
ZSH_HIGHLIGHT_STYLES[assign]=fg=blue

# Doesn't seem to work.
#source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# SLOW!!
#source /usr/share/zsh/scripts/antigen/antigen.zsh

# Prompt.
setopt promptsubst
autoload -Uz promptinit; promptinit
autoload -Uz vcs_info; vcs_info
autoload -Uz colors; colors
#prompt walters red
#prompt fade
#prompt pws
#prompt bart
#prompt mde
# Set prompt to random color.
#prompt balance $(( $RANDOM % 9 ))
#prompt balance black
prompt cliguy green
#prompt membean
#prompt wunjo
# prompt off

autoload zmv

# My funcs.
autoload v foofunc

# Mime types; enable massive set of "alias -s" (MAYBE SLOW)
#autoload -U zsh-mime-setup; zsh-mime-setup

# Multibyte/unicode character input based on mnemonics, a la vim's Ctrl-K
# http://zsh.sourceforge.net/FAQ/zshfaq05.html
autoload -Uz insert-composed-char
zle -N insert-composed-char
# Map it to <F5>
#bindkey '\e[15~' insert-composed-char  # F5
#bindkey '^K' insert-composed-char  # same as vim

### Custom inserts
# CTRLs available: ^r ^t ^y ^o ^p ^a ^f ^b ^n
# ALT/ESC example: bindkey '^[f' foo
# Ideas:
# https://github.com/tomsquest/dotfiles/blob/master/zsh/bindkey.zsh
# http://michael-prokop.at/computer/config/.zsh/zsh_keybindings
# Insert an mc3 query.
##insert_query () { zle beginning-of-line; zle -U "mc3q '{}' _id" }
##insert-mc3q() { LBUFFER="opts=--csv mc3q '{"; RBUFFER=":\"\"}' _id |csv2tsv.rb S" }
#insert-mc3q() { LBUFFER="opts=--csv mc3q '{\""; RBUFFER="\"://i, abandon:{\$ne:true}}' _id TSV" }
#zle -N insert-mc3q
#bindkey '^f' insert-mc3q
#insert-mc3s() { LBUFFER="mc3s "; RBUFFER=" J" }
#zle -N insert-mc3s
#bindkey '^[f' insert-mc3s
## Calculator
#insert-calc() { LBUFFER='p $(('; RBUFFER='))' }
#zle -N insert-calc
##bindkey '^f' insert-mc3q
#bindkey '^[c' insert-calc
## Sed
#insert-sed() { LBUFFER+="s 's/" RBUFFER="//'" }
#zle -N insert-sed
#bindkey '^[s' insert-sed
## Auto-clipboard
#  #zle vi-insert
#insert-clip() { LBUFFER="print \"$LBUFFER" RBUFFER+='" |xsel' }
#zle -N insert-clip
## Note that -a effects cmd mode
#bindkey -a '^[x' insert-clip

# Disabling: funny alt-mode behavrior after quick esc-w for word-jumping
#insert-while() { LBUFFER='while read -r x; do ' RBUFFER='print $x; done <~/test/aaa.lst' }
#zle -N insert-while
#bindkey '^[w' insert-while

# Set vi mode.
#bindkey -e
#bindkey -v
# Not necesssary and not recommended (according to zshoptions);
# might also be getting settings from inputrc.
#setopt vi
# Workaround for funny Ubuntu setting.
#bindkey '\e/' vi-history-search-backward

# zsh-specific command finder
# Two bugs!
# https://bugs.launchpad.net/ubuntu/+source/command-not-found/+bug/624565
#. /etc/zsh_command_not_found

# Do menu-driven completion.
zstyle ':completion:*' menu select

# Color completion for some things.
# http://linuxshellaccount.blogspot.com/2008/12/color-completion-using-zsh-modules-on.html
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
#zstyle ':completion:*' group-name ''
# formatting and messages
zstyle ':completion:*'              verbose     yes
zstyle ':completion:*:descriptions' format     "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages'     format     '%d'
zstyle ':completion:*:warnings'     format     "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections'  format     '%B%d (errors: %e)%b'
zstyle ':completion:*'              group-name ''

# Completers for my own scripts
zstyle ':completion:*:*:sstrans*:*' file-patterns '*.(lst|clst)'
zstyle ':completion:*:*:ssnorm*:*'  file-patterns '*.tsv'


######################################################################
### Options

setopt interactivecomments
# Don't exit on ^D
setopt ignoreeof

# Changing dirs.
setopt cdablevars pushdignoredups pushdsilent chaselinks

# Enable ~ ^ # in glob patterns.
setopt extendedglob

# Too many scripts use globals or forget to make local.
#setopt warncreateglobal

# Report on bg jobs immediately when they finish.
setopt notify

# History
setopt appendhistory banghist histignorealldups histfindnodups
setopt histignorespace histnostore histreduceblanks histsavenodups
setopt incappendhistory extendedhistory

setopt nocaseglob
setopt correct

# Kinda cool, but eventually annoying to have all shells share hist in
# real-time. Better to just use "fc -RI" to Read Incrementallly the
# missing shared entries.
#setopt sharehistory

# Nice safety, Was just too annoying to have to hit <enter> after !$
#setopt histverify

# Neat! Can say "subdir/myutil" to invoke myutil.
setopt pathdirs

# Don’t overwrite existing files.
setopt noclobber

# Fancy regexes in =~
setopt rematchpcre

setopt shortloops

setopt braceccl  # Support chars in range: {a-z}
                  # Note difference from:   {0..9}

# Obviate tee, plus other niceties
setopt multios

# Trying out 0-based arrays! Matches bash and ls
#setopt kshzerosubscript

# Enable some nice things to go into post-prompt commands.
typeset -ga preexec_functions
typeset -ga precmd_functions

# Bail out of scripts as soon as the first error hits.
#setopt errexit

# Zsh-specific envar overrides for history control. Behave more like
# options than envars.
# http://zsh.sourceforge.net/FAQ/zshfaq03.html#l38
SAVEHIST=20000
HISTFILE=~/.zhistory
HISTIGNORE='k:ls:lm:bg:fg:jobs:pwd:declare:history:fc:d:&: *:'
HISTSIZE=20000
HISTFILESIZE=$HISTSIZE

# Stop Esc-* from acting like Alt
# http://www.johnhawthorn.com/2012/09/vi-escape-delays/
KEYTIMEOUT=1

# Automatically show time info for long-running commands.
REPORTTIME=1

# Make debug prompt more useful by showing time per command
export PS4='%B%* %2N:%i>%b '

# export ANSIBLE_INVENTORY=~/proj/XXX/provn/ansible/hosts

# Consider MIME filetype enabling. SLOW!
# http://www.bash2zsh.com/essays/essay1_file_manager.html
#autoload -U zsh-mime-setup; zsh-mime-setup

#umask 002

# Modal cursor color for vi's insert/normal modes.
# http://stackoverflow.com/questions/30985436/
# https://bbs.archlinux.org/viewtopic.php?id=95078
# http://unix.stackexchange.com/questions/115009/how-to-change-the-cursor-theme-in-cli
# zle-line-init () {
  #
  #zle -K viins
  # zle -K vicmd  # start in cmd (normal) mode
  #echo -ne "\033]12;Grey\007"
  #echo -n 'grayline1'
  #echo -ne "\033]12;Gray\007"
  #echo -ne "\033[4 q"
  #print 'did init' >/dev/pts/16
# }
zle-keymap-select () {
  if [[ $KEYMAP == vicmd ]]; then  # normal/cmd mode
    if [[ -z $TMUX ]]; then
      printf "\033]12;Green\007"
      printf "\033[2 q"
    else
      printf "\033Ptmux;\033\033]12;red\007\033\\"
      printf "\033Ptmux;\033\033[2 q\033\\"
    fi
  else  # insert mode
    if [[ -z $TMUX ]]; then
      printf "\033]12;Grey\007"
      printf "\033[4 q"
    else
      printf "\033Ptmux;\033\033]12;grey\007\033\\"
      printf "\033Ptmux;\033\033[4 q\033\\"
    fi
  fi
  #print 'did select' >/dev/pts/16
}

zle-start-in-cmd-mode () {
  print 'entering cmd mode'
  zle vi-cmd-mode
}

if [[ $TERM == rxvt-unicode-256color ]]; then
  #zle -N zle-keymap-select
  #zle -N zle-line-init
  #zle -N zle-start-in-cmd-mode
fi

# Set tabs to non-standard (non-8) width.
# See: `man 1p tabs` for some interesting options!
#tabs -16

# Disable C-s as XOFF
# https://coderwall.com/p/ltiqsq
stty stop ''
stty start ''
stty -ixon
stty -ixoff

# Stop that dang bell (must be done in x)
# xset -b

# Misc completions (should I have a zstyle.zsh file?)
# FIXME: Not completing dirs
zstyle ':completion:*:*:mp4crush*:*' file-patterns '*.mp4'
zstyle ':completion:*:*:bkgd:*' file-patterns '*.jpg'
zstyle ':completion:*:*:feh:*' file-patterns '*.(jpg|png)'
zstyle ':completion:*:*:mb-purge-non-deliverables*:*' file-patterns '*.txt'
zstyle ':completion:*:*:(v|vim):*' ignored-patterns '*.(o|so|mp3|jpg|png|pdf|xcf)'

# Direnv (probably not slow but should keep an eye on it)
eval "$(direnv hook zsh)"

#fontset.zsh big

# # ansi-term should track cwd
# # http://stackoverflow.com/questions/3508387/
# if [ -n "$INSIDE_EMACS" ]; then
#   chpwd() { print -P "\033AnSiTc %d" }
#   print -P "\033AnSiTu %n"
#   print -P "\033AnSiTc %d"
#   export TERM=xterm-256color
# fi

######################################################################
# FUZZY COMPLETION: FZF
# C-T for normal finding
# C-r for history search
# M-c for cd
# https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh
# https://github.com/junegunn/fzf/wiki/Configuring-fuzzy-completion
# Remove default transpose-chars binding that conflicts with fzf
bindkey -r '^T'
. /usr/share/fzf/key-bindings.zsh
. /usr/share/fzf/completion.zsh
export FZF_DEFAULT_COMMAND="fzf --preview 'head -100 {}'"
# export FZF_COMPLETION_TRIGGER=''
# If you want TAB to do FZF.
# bindkey '^I' fzf-completion
# Guessing this makes normal TAB completion continue to work as usual.
# bindkey '^I' $fzf_default_completion
export FZF_CTRL_T_OPTS="--preview '(highlight -O xterm256 -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
# export FZF_CTRL_T_OPTS="--preview 'cat {} | head -200'"


# Z cd jump around tracking, silently observing
# https://github.com/rupa/z
# . /usr/share/z/z.sh
. /usr/lib/z.sh

export ZPLUG_HOME=~/.zplug
# . $ZPLUG_HOME/init.zsh
. /usr/share/zsh/scripts/zplug/init.zsh
