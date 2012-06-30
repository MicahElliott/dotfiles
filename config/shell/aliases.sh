######################################################################
# Aliases
######################################################################

### Highest importance, 1-char shortcuts.
# A -- apt package mgmt
alias a='sudo aptitude'
# C -- cat/pygmentize
#alias c='coderay' # not installing on arch
alias c='pygmentize'
# D -- dirs
alias d='dirs -v'
# E -- super-fast-to-start-up browser
alias e='epiphany'
# F -- fc history display
alias f='fc -ldD'
# G -- grep searching
alias g='egrep --color=always'
alias gr='g -ir'
# H -- help system
alias h=help
# I -- initialize project working dir (see func)
# J -- job control
alias j='jobs'
# L -- dir listing
alias l='ls -hlABFX'
# M -- audio player
alias m='mplayer'
# N -- nautilus
alias n=nautilus
# O -- open, the right way
alias o='xdg-open'
# P -- print, eg. envars
alias p='print -l'
alias q='exit'
# R -- rake
#alias r='rake'
# S -- regex-enabled sed
alias s='sed -r'
alias sn='sed -nr'
# T -- test (see func)
# V -- edit (see func)
# W -- command info
alias w='whence'
alias wa='whence -av'
alias w1='whence'
# X -- exit (see func)
alias x='exit'

alias rb=rbenv
alias rl=bin/rails
alias rk=bin/rake
alias rs=bin/rspec

alias go=$BROWSER

alias zg='zgrep -E --color=always'

alias el='elinks -no-numbering -no-references -dump-width 200 -dump'
alias dump=el

# DILEMMA: Sometimes we need functions to do the job when an alias
# won't suffice. So should aliases and functions files be combined??

alias hi=history
# Read shared global history's missing recent entries.
# Won't remember if "history load" or "history read" so creating both.
# Don't need a history write alias, thanks to incappendhistory option.
alias hr='fc -RI'
alias hl='fc -RI'

# Make all ls have color.
alias ls='ls --color=auto'
# Micah's custom ls.
#alias lm='ls -hlABFX'
# sort by Extension.
alias le='ls -hlABFX'
# Human readable size ordering.
alias lh='ls -hlrS'
# order by Time.
alias lt='ls -hlrt'
ltt() { print -l ${1}*(.Om[-15,-1]) }
alias l.='ls -lBd .[a-zA-Z]*'
alias la='ls -a'
alias ll='ls -l'
alias lx='ls -hXB'
alias l1="ls -rt |awk 'END {print $NF}'" # or |tail -1
alias ltc='ls -l --time=ctime'
alias lta='ls -l --time=atime'
alias ltm='ls -l --time=mtime'
alias lmp='ls -lBX *.py'
#alias mc='make clean'
#alias mn='make -n'
alias cdl='cd -l'
alias cde='vim -o2 .enterrc .exitrc'
#alias c=wcd
alias pu='pushd'
alias po='popd'
alias clean="rm -f *~ .*~ core *.bak"
alias gdb='gdb -silent'
alias info='info --vi-keys'
alias view='vim -R'
#alias v='export VIMTAGS=$(pwd)/tags'
alias cx='chmod +x'
alias vp='versatile purple1'
alias vb='versatile blue1'
alias vg='versatile green1'
alias less='less -R'
alias tree='tree -C --charset utf8'
alias elinks='TERM=xterm-256color elinks'

alias pg='pgrep'
alias pk='pkill'
alias spk='sudo pkill'

# Latest download, see also "latest" func.
alias dl='ls "$HOME/Downloads/$(ls -rt $HOME/Downloads/ |tail -1)"'

# rubygems
##alias gs='gem search -r --details' # Too slow
alias gs='gem search -r'
# See functions for "gi" equivalent.
#alias gi='gem install'

# bundler
# http://ryan.mcgeary.org/2011/02/09/vendor-everything-still-applies/
alias b="bundle"
alias bi="b install --path vendor --binstubs"
# Not useful? http://gembundler.com/bundle_package.html
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

# testing
alias cu=cucumber

# Be safe. Unfortunate that stupid --no-clobber won't error when avoiding overwrite.
alias mv='mv -i'
alias cp='cp -i'

# pacman/packer shortcuts
# OOPS: The --noedit kills zsh completion
alias packer='packer --noedit'
alias pm=packer

# apt-* shortcuts
# Will make a good blog post. Note these won't tab-complete in bash.
# Maybe should just use aptitude for everything? This article says to:
# http://luv.asn.au/overheads/aptitude/aptitude-intro.html
alias a-update='sudo apt-get update'
alias a-upgrade='sudo apt-get upgrade'
alias a-up='sudo apt-get update && sudo apt-get upgrade'
#alias a-install-pkg='sudo apt-get install'
alias a-install-PKG='sudo aptitude install'
# http://www.linuxquestions.org/questions/debian-26/%5Baptitude%5D-how-to-get-a-list-of-all-installed-packages-458119/
alias a-manually-installed='aptitude search "~i" |g "^i   "'
#a-have-pkg() { dpkg --list |egrep -q "\b$1\b" && echo yes || echo no ; }
a-have-pkg() { dpkg --list |egrep " $1 " ; }
alias a-remove-PKG='sudo apt-get remove'
alias a-show-PKG='apt-cache show'
alias a-search-STR='apt-cache search'
alias a-depends-PKG='apt-cache depends'
alias a-list-PKG='apt-file list'
alias a-find-FILE='apt-file find'
alias a-add-PPA='sudo add-apt-repository'

alias jobdone="date |mail -s 'job done' $EMAIL"

#alias latest='ls ~/Downloads/$(ls -rt ~/Downloads/ |tail -1)'
alias day="date '+%Y%m%d'"
alias dt='date "+%Y%m%d"'

alias gm='gnome-mplayer'

# VCS commands are 2 chars.
# NOTE: it would be better to have these as functions that knew which
# VCS to apply to, but only aliases are smart enough to complete well.
alias st='git status'
alias di='git diff'
alias lo='git log --stat'
alias lo2='git log --abbrev-commit --pretty=format:"%Cgreen%h %Cred%ai %Creset%s %Cgreen(%aN)"'
alias ci='git commit'
alias co='git checkout'
alias br='git branch'
alias ad='git add'
alias fe='git fetch -v'
alias fed='git fetch --dry-run'
alias re='git rebase -v'

# Home git mgmt
alias dotfiles='git --git-dir=$HOME/.dotfiles.git/.git --work-tree=$HOME'
alias dad='dotfiles add'
alias dlo='dotfiles log --stat'
alias dci='dotfiles commit'
alias ddi='dotfiles diff'
alias dst='dotfiles status'
alias dpu='dotfiles push origin master'

alias ri='ri -f ansi'
alias top='htop -d 5'

alias mysql='mysql --auto-rehash'

# VirtualEnvWrapper (see .../virtualenvwrapper.sh)
# Seems pretty silly that ~8 ve/vewrapper commands all get shoved into
# global path space with no name cohesion; hence these aliases.
# Should conider removing synonyms/redundancy, but will keep for now.
# Minimal useful set: new, use, deactivate
#   Creation/deletion.
alias ve-new='mkvirtualenv --distribute --no-site-packages'
alias ve-make='ve-new'  # Like “rvm install” but no installation necessary.
alias ve-cp='cpvirtualenv'
alias ve-rm='rmvirtualenv'
#   Usage/navigation.
alias ve-lsenvs='workon' # workon <tab> works great so prefer over lsvirtualenv
alias ve-available='workon'
alias ve-lspackages='lssitepackages'
alias ve-use='workon'  # Resemble RVM.
alias ve-workon='workon'
alias ve-activate='workon'  # To be congruent with “deactivate”.
alias ve-deactivate='deactivate'
alias ve-adddir='add2virtualenv'
#   Obscure. Probably don’t ever want to work out of these.
alias ve-cdpackages='cdsitepackages'
alias ve-cdve='cdvirtualenv'

# Note that all the Python bootstrapping packaging utils get
# sudo-installed globally into /usr/local/bin.

# Editing of config stuff.
alias vi-shell='v -S ~/config/shell/Session.vim'
alias vi-mbg='v -S ~/proj/Membean/Session.vim'

alias re-env=". $my_zshdir/envars.sh"
alias re-funcs=". $my_zshdir/functions.sh"
# Moved to function to enable re-sourcing both alias files.
#alias re-aliases=". $my_zshdir/aliases.sh"
alias re-opts=". $my_zshdir/options.zsh"

alias mkf="mkfifo $TMPDIR/refresher.fifo && cat > $TMPDIR/refresher.fifo &"

alias vlcshot='print ~/.local/share/vlc/$(ls -t ~/.local/share/vlc/ |head -1)'

# Helpers for trash-cli.
alias trash-restore=restore-trash
alias trash-empty=empty-trash
alias trash-list=restore-list
alias trash-auto=autotrash
