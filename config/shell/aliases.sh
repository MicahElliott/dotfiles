######################################################################
# Aliases

# DILEMMA: Sometimes we need functions to do the job when an alias
# won't suffice. So should aliases and functions files be combined??
######################################################################

### Highest importance, 1-char shortcuts.
# A -- apt package mgmt
#alias a='sudo aptitude'
alias a='awk'
# C -- cat/pygmentize
# None seem to have markdown support
alias c='/usr/bin/coderay' # uses bold unlike pygmentize
alias c2='python3 =pygmentize'
#alias c='pygmentize'
#alias c='src-hilite-lesspipe.sh'
# D -- dirs
alias d='dirs -v'
# E -- super-fast-to-start-up browser
alias e='epiphany'
# F -- fc history display
alias f='fc -ldD'
# G -- grep searching
#alias g='ack'
# PCRE and color for grep
alias g='grep --color=always -P'
alias gr='g -ir'
# H -- help system
alias h=help
# I -- initialize project working dir (see func)
# J -- job control
alias j='jobs'
# L -- dir listing
alias l='ls -hlABFX'
# M -- audio player
alias m=$APLAYER
# N -- nautilus
alias n=nautilus
# O -- open, the right way
alias o='mimeo'
# P -- print, eg. envars
alias p='print -l'
alias q='exit'
# R -- littler
disable r
# S -- regex-enabled sed
alias s='sed -r'
alias sn='sed -nr'
# T -- tree
#alias t='tree *~node_modules'
alias t='tree -C --charset utf8'
alias th='thunar'
# V -- edit (see func)
# W -- command info
alias w='whence'
alias wa='whence -av'
alias w1='whence'
# X -- exit (see func)
alias x='exit'
# Y -- yaourt package manager
alias y=yaourt

### Listing
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

### Ruby
#   Rubygems
##alias gs='gem search -r --details' # Too slow
alias gs='gem search -r'
# See functions for "gi" equivalent.
#alias gi='gem install'
#   Bundler
# http://ryan.mcgeary.org/2011/02/09/vendor-everything-still-applies/
# http://stackoverflow.com/a/9791080/326516
alias b="bundle"
alias bi="b install --path vendor/bundle --binstubs"
# Not useful? http://gembundler.com/bundle_package.html
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

alias ri='ri -f ansi'
alias rb=rbenv
alias chr=chruby
alias rv=chruby
alias ru=ruby
alias rl=bin/rails
alias rk=bin/rake
alias rs=bin/rspec
#alias rg=bin/guard # see function
#alias cu=cucumber
alias rbw='rbenv which'
alias rbwa='rbenv whence'

### Node/JavaScript
alias jg=grunt
alias jb=brunch
alias bws='brunch watch --server'
alias bbo='brunch build --optimize --config config-release.ls'
alias nv=nvm
# Node with rlwrap
# http://blog.doteight.com/blog/2011/01/16/rlwrap-and-node/
alias node='NODE_NO_READLINE=1 rlwrap -pgreen -S "node> " node'
#alias coffee='NODE_NO_READLINE=1 rlwrap -pyellow -S "coffee> " coffee'
# Can't alias coffee since it screws up syntastic.
alias cs='rlwrap -s 10000 -H ./coffee.hist coffee -i'
alias jsh=jshon
alias lsc='livescript'
# rlwrap is broken for lsc; it uses raw mode? Have to either use `rlwrap -a` for
# history or go without hist and get nice object prop completion
alias ilsh='rlwrap -a -r -H ./lsc.hist -s 10000 lsc'
# Still get single session history, plus really nice emacs-style obj
# completions and function showing. Lacks any kind of search (ctrl-r).
alias ils='livescript -d'
alias mo=mocha

### Archlinux / sudo
# pacman/packer shortcuts
# OOPS: The --noedit kills zsh completion
#alias packer='packer --noedit'
#alias pm='packer --noedit'
alias sc='sudo systemctl'
alias spk='sudo pkill'
# Better -S-completion than yaourt
alias pm='sudo pacman'
alias yao='yaourt --noconfirm'
alias yaoup='yao -Syu --aur'
alias sl='slocate -r'
alias up='sudo updatedb'

### Ubuntu
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
alias dt-='date -I'
alias dd='date -d'  # okay to mask dd since use infrequently
alias dt2="date-iso2bson.rb <<<\"'`dt-`'\""

alias mp=$APLAYER
alias vp=$VPLAYER

### Git
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
#alias cl='git clone'
alias lsf='git ls-files'
alias gls='git ls-files'
alias gpu='git push origin master'

# Home git mgmt
alias dotfiles='git --git-dir=$HOME/.dotfiles.git/.git --work-tree=$HOME'
alias dit='dotfiles'
alias dad2='dotfiles add'  # completion does not work
alias dad='dotfiles stage' # so use semi-working synonym
alias dlo='dotfiles log --stat'
alias dci='dotfiles commit'
alias ddi='dotfiles diff'
alias dst='dotfiles status'
alias drm='dotfiles rm'  # maybe add --cached
alias dpu='dotfiles push origin master'
alias dfe='dotfiles fetch -v'
alias dls='dotfiles ls-files'
alias dign='comm -13 <(dls $(p .*(.))|sort) <(p .*(.)|sort)'  # ignored files

### Python
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

### Vim
# Editing of config stuff.
#alias vi-shell='v -S ~/config/shell/Session.vim'
alias vi-shell='v -o ~/.zshrc $my_shdir/options.zsh $my_shdir/envars.sh $my_shdir/aliases.sh $my_shdir/aliases.zsh $my_shdir/functions.sh'
alias vi-mbg='v -S ~/proj/Membean/Session.vim'
alias vi-sudo='sudoedit'

# Seems to need to live as alias, not as file/function
alias vim2html='vim -c ":TOhtml $1| w |q |q"'

#alias view='vim -R'
# Don't bother with vim's readonly view
#disable view
alias view="feh --title '%f | %wx%h | %S | %t | %m | %n | %p | %u/%l'"
# Vim-like
alias pw=pwd
alias se=setopt
#alias v='export VIMTAGS=$(pwd)/tags'

### Shell
alias re-env=". $my_shdir/envars.sh"
alias re-funcs=". $my_shdir/functions.sh"
re-aliases() { . $my_shdir/aliases.sh; . $my_shdir/aliases.zsh }
alias re-opts=". $my_shdir/options.zsh"

alias fn='declare -f'

alias hi=history
# Read shared global history's missing recent entries.
# Won't remember if "history load" or "history read" so creating both.
# Don't need a history write alias, thanks to incappendhistory option.
alias hr='fc -RI'
alias hl='fc -RI'
alias hg='histgrep.zsh' # masking mercurial, oh well

alias cdl='cd -l'
alias cde='vim -o2 .enterrc .exitrc'
#alias md=mkdir
alias rd=rmdir
#alias c=wcd
alias pu='pushd'
alias po='popd'
alias cx='chmod +x'

### Enablers
alias en-py2='py2en'
alias en-chruby='echo already enabled'
alias en-rbenv='rbi'
alias en-nvm='nvi'
alias en-ffsdk='ffi'

### Other
alias clean="rm -f *~ .*~ core *.bak"
alias info='info --vi-keys'

alias zg='zgrep -E --color=always'

alias el='elinks -no-numbering -no-references -dump-width 200 -dump'
alias dump=el

alias ss2='gnumeric'
alias ss='soffice --calc'  # masks the ss socket tool.

alias ec='ebook-convert'

alias gdb='gdb -silent'
#alias less='vimpager'
alias less='less'
alias elinks='TERM=xterm-256color elinks'

#alias mc='make clean'
#alias mn='make -n'

alias pg='pgrep'
alias pk='pkill'

# Be safe. Unfortunate that stupid --no-clobber won't error when avoiding
# overwrite.
alias mv='mv -i'
alias cp='cp -i'

alias tm='tmux'
# Each slime wants its own socket.
tmn() { tmux -L $PWD:t new }

# Latest download, see also "latest" func.
#alias dl='ls "$HOME/Downloads/$(ls -rt $HOME/Downloads/ |tail -1)"'

alias top='htop -d 5'

alias mkf="mkfifo $TMPDIR/refresher.fifo && cat > $TMPDIR/refresher.fifo &"

alias vlcshot='print ~/.local/share/vlc/$(ls -t ~/.local/share/vlc/ |head -1)'

# Helpers for trash-cli.
alias trash-restore=restore-trash
alias trash-empty=empty-trash
alias trash-list=restore-list
alias trash-auto=autotrash

alias ta='tabs 16'

alias printerconfig=system-config-printer

alias xl=xlsxcat.zsh

alias shoot='scrot -s'
alias ssr='simplescreenrecorder'
alias vidcap='simplescreenrecorder'
alias webcam=wxcam
alias cam=wxcam
alias webshoot=wkhtmltoimage

alias go=$BROWSER
alias ch='chromium --disable-web-security'

alias cu='curl -i'

alias mysql='mysql --auto-rehash'

alias stderred='export LD_PRELOAD="/usr/lib/libstderred.so"'
