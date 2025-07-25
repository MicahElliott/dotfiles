######################################################################
# Aliases

# DILEMMA: Sometimes we need functions to do the job when an alias
# won't suffice. So should aliases and functions files be combined??
######################################################################

# MacOS hack
if [[ $ostype = 'Darwin' ]]; then alias ls=gls; fi

### Highest importance, 1-char shortcuts.
# A -- apt package mgmt
#alias a='sudo aptitude'
#alias a='awk'
alias a='alias'
# C -- cat/pygmentize
# None seem to have markdown support
alias c2='/usr/bin/coderay' # uses bold unlike pygmentize
#alias c='python3 =pygmentize'
#alias c='pygmentize'
#alias c='src-hilite-lesspipe.sh'
alias c=bat

# D -- dirs
# alias d='dirs -v'
alias ds='dirs -v'
# E -- file Explorer
#alias e='epiphany'
#alias e='nemo --no-desktop'
# alias e='emacs --daemon'
alias ec='emacsclient -c'
alias e='_eat_msg open'
# F -- fc history display
alias f='fc -ldD'
alias fm=pcmanfm  # file manager
# G --  grep searching
# alias g='ag'
alias g='rg'
# PCRE and color for grep
#alias g='grep --color=always -P'
alias gr='g -ir'
# alias gc='g -C4'
# H -- help system
# I can't seem to get ESC-h working for run-help, so this'll have to do.
alias h=run-help
# I -- initialize project working dir (see func)
# J -- job control
alias j='jobs'
# L -- dir listing
alias ls='ls -F --color=auto'
alias l='ls -hlkABFX --color=auto'
# alias l='exa -lBF -sextension --git --group-directories-first'
# M -- audio player
alias m=$APLAYER
# N --
# Might use n (node version tool)
#alias n=nautilus
#alias n='nemo --no-desktop'
# O -- open, the right way
alias o='mimeo'
# P -- print, eg. envars
alias p='print -l'
alias q='exit'
# R -- littler
#disable r
# S -- regex-enabled sed
alias s="gsed -r 's///'"
alias sn='sed -nr'
# T -- tree
#alias t='tree *~node_modules'
alias t='tree -C --charset utf8'
alias td='t -d'
alias th='thunar'
# V -- edit (see func)
# W -- command info
alias w='whence'
alias wa='w -av'
alias wm='w -m'
alias w1='whence'
# X -- exit (see func)
alias x='exit'
# Y -- yaourt package manager
alias y=yaourt

### Listing
# Make all ls have color.
# alias ls='ls --color=auto'
# Micah's custom ls.
#alias lm='ls -hlABFX'
# sort by Extension.
# alias le='ls -hlABFX'
# Human readable size ordering.
# alias lh='exa -la -ssize --git'
alias lh='ls -lhkABF --color=auto'
# alias ls='ls --color=auto'
# order by Time.
# alias lt='exa -lra -tmodified --git'
alias lt='ls -lrtkhABF --color=auto'
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
#alias b="./bin/bundle"
alias b="bundle"
# alias bi="b install --path vendor"
alias bi="b install"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

alias ri='ri -f ansi'
alias rb=chruby
alias chr=chruby
alias rv=chruby
alias ru=ruby
alias rl=bin/rails
alias rk=bin/rake
alias rs=bin/rspec
#alias rg=bin/guard # see function
#alias cu=cucumber
# alias rubocop='rubocop --rails'  # get some extra checks

### Archlinux / sudo
# pacman/packer shortcuts
# OOPS: The --noedit kills zsh completion
#alias packer='packer --noedit'
#alias pm='packer --noedit'
alias sc='systemctl'
alias scu='sc --user'
alias ssc='sudo systemctl'
alias jc='journalctl -xal'
alias sjc='sudo journalctl -xal'
alias spk='sudo pkill'
# Better -S-completion than yaourt
alias pm='sudo pacman'
alias am='aurget'
alias yao='yaourt --noconfirm'
alias yaoup='yao -Syu --aur'
alias sl='slocate -r'
alias up='sudo updatedb'
alias fw='firewall-cmd'

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
alias dt='date +%Y%m%d'    # frequent 8-digit stamp: 20160114
alias dt8=dt
alias day=dt
alias dts='date +%s'       # seconds since epoch: 1452795263
alias dte=dts
alias dt10=dts
alias dtep='print "use this to parse: date -d @123..."'  # parse the epoch
alias dtp='date -d '       # parse
alias dttm='date --utc +%Y%m%d%H%M%S'  # datetime: 20160114192940
alias dt14=dttm
#alias dd='date -d'  # okay to mask dd since use infrequently
alias dt13=dtb
alias dto='date +%Y%j'     # ordinal date: 2016016 (16th day of year)
alias dt7=dto
# https://en.wikipedia.org/wiki/ISO_week_date
alias dtwk='date +W%V'     # week date: W02
alias dtyrwk='date +%GW%V' # year week date: 2016W02
# ISO 8601
alias dtw='date +%G-W%V-%' # year week: 2016-W02-4
alias dti='date -I'        # ISO-8601: 2016-01-14
alias dt-=dti
alias dtI='date -u +%Y%m%dT%H%M%S'        # 20160111T173110Z
alias dtI-='date -u +%Y-%m-%dT%H:%M:%SZ'  # 2016-01-11T17:31:10Z
alias dtI0='date -u -Iseconds'            # 2016-01-11T17:31:10+0000
alias dto-='date +%Y-%j'                  # ordinal date: 2016-016
# Weird mongo
alias dtb="date-iso2bson.rb <<<\"'`dt-`'\""  # for mongo bson

alias mp=$APLAYER
alias vp=$VPLAYER

### Git
# VCS commands are 2 chars.
# NOTE: it would be better to have these as functions that knew which
# VCS to apply to, but only aliases are smart enough to complete well.
alias st='git status'
# alias di='git diff'
# alias dic='git diff --cached'
alias glo='git log --stat'
alias glo2='git log --abbrev-commit --pretty=format:"%Cgreen%h %Cred%ai %Creset%s %Cgreen(%aN)"'
alias gci='git commit'
alias gcip='git commit -p'
alias gco='git checkout'
alias gbr='git branch'
alias gad='git add'
alias gfe='git fetch -v'
alias gfed='git fetch --dry-run'
alias gre='git rebase -v'
alias gmet='git mergetool'
#alias cl='git clone'
alias glsf='git ls-files'
# Masks gnu-ls
# alias gls='git ls-files'
alias gpu='git push origin master'

# Home git mgmt
# http://silas.sewell.org/blog/2009/03/08/profile-management-with-git-and-github/
# You can set up with:
#   cd ~
#   git clone git://github.com/MicahElliott/dotfiles ~/.dotfiles.git
#   mv .dotfiles.git/* .
#
# If you want to ever make changes (recommended!), you should fork and clone your own.
#alias dotfiles='git --git-dir=$HOME/.dotfiles.git/.git --work-tree=$HOME'
# Neat that can have custom ignore file, so as not to muck up globally utilized ~/.gitignore
alias dotfiles='git --git-dir=$HOME/.dotfiles.git/.git --work-tree=$HOME -c core.excludesfile=$HOME/.dotfilesignore'
alias .it='dotfiles'
alias .ad2='dotfiles add'  # completion does not work
alias .ad='dotfiles stage' # so use semi-working synonym
alias .lo='dotfiles log --stat'
alias .ci='dotfiles commit'
alias .di='dotfiles diff'
alias .st='dotfiles status'
alias .rm='dotfiles rm'  # maybe add --cached
alias .pu='dotfiles push origin master'
alias .fe='dotfiles fetch -v'
alias .ls='dotfiles ls-files'
alias .ign='comm -13 <(dls $(p .*(.))|sort) <(p .*(.)|sort)'  # ignored files

### Python
# VirtualEnvWrapper (see .../virtualenvwrapper.sh)
# Seems pretty silly that ~8 ve/vewrapper commands all get shoved into
# global path space with no name cohesion; hence these aliases.
# Should conider removing synonyms/redundancy, but will keep for now.
# Minimal useful set: new, use, deactivate
#   Creation/deletion.
alias ve='virtualenv --system-site-packages'
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

# Pipenv
alias pe=pipenv
alias pe-check='pipenv check'
alias pe-clean='pipenv clean'
alias pe-graph='pipenv graph'
alias pe-install='pipenv install'
alias pe-uninstall='pipenv uninstall'
alias pe-lock='pipenv lock'
alias pe-open='pipenv open'
alias pe-run='pipenv run'
alias pe-shell='pipenv shell'
alias pe-sync='pipenv sync'
alias pe-update='pipenv update'

# Note that all the Python bootstrapping packaging utils get
# sudo-installed globally into /usr/local/bin.

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
alias re-plugins=". $my_shdir/plugins.zsh"
alias zp=re-plugins

# alias fn='declare -f'

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

alias 1='pu'
alias 2='pu ~2'
alias 3='pu ~3'
alias 4='pu ~4'
alias 5='pu ~5'
alias 6='pu ~6'
alias 7='pu ~7'
alias 8='pu ~8'
alias 9='pu ~9'

alias de='vared dirstack'
alias dired='vared dirstack'

### Racket
alias rt=racket
alias ro=raco

### Enablers
alias en-py2='py2en'
alias en-chruby='echo already enabled'
alias en-nvm='nvi'
alias en-ffsdk='ffi'
alias en-docker='sc start docker; sudo sysctl net.ipv4.ip_forward=1'

### Other
alias clean="rm -f *~ .*~ core *.bak"
alias info='info --vi-keys'

alias zg='zgrep -E --color=always'

alias el='elinks -no-numbering -no-references -dump-width 200 -dump'
alias dump=el

alias ss2='gnumeric'
alias spread='soffice --calc'  # masks the ss socket tool.

alias ec='ebook-convert'

alias gdb='gdb -silent'
#alias less='vimpager'
alias less='less'
alias elinks='TERM=xterm-256color elinks'

#alias mc='make clean'
#alias mn='make -n'

# alias pg='pgrep --full --list-full'
alias pg='pgrep -fl'
alias pk='pkill --full'
alias pk='pkill -f'

# Be safe. Unfortunate that stupid --no-clobber won't error when avoiding
# overwrite.
alias mv='mv -i'
alias cp='cp -i'

# Type `zmv` alone for origin of this alias; pretty nice!
# mmv *.jpg *-large.jpg
alias mmv='noglob zmv -W'
# nmv -n (*)-edited.jpg \$1.jpg
alias nmv='noglob zmv'
alias zcp='zmv -C'

alias pp='print -P'

alias ap=ansible-playbook
alias ap19=ansible-playbook-19

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

#alias shoot='scrot -s'
#alias shoot="maim -s snapshot-`dts`.png"
alias ssr='simplescreenrecorder'
alias vidcap='simplescreenrecorder'
alias webcam=wxcam
alias cam=wxcam
alias webshoot=wkhtmltoimage

#alias go=$BROWSER
alias ch='chromium --disable-web-security'

alias cu='curl -i'

alias my-curl="curl -s -v -H 'Cache-Control: no-cache' -H 'Content-Type: application/json'"

alias mysql='mysql --auto-rehash'

alias stderred='export LD_PRELOAD="/usr/lib/libstderred.so"'

# alias ans=ansible

alias android-pull='adb pull sdcard/DCIM/Camera/ ~/Pictures/n5'
alias n5=android-pull

# Can't figure out how to disable reboot, and accidentally completing it.
# https://wiki.archlinux.org/index.php/allow_users_to_shutdown
alias reboot='print "you probably do not really mean that"'

alias kc=keychains

alias sm="ssh -F ${ANSIBLE_INVENTORY:h}/ssh-inventory.config"
alias scpm="scp -F ${ANSIBLE_INVENTORY:h}/ssh-inventory.config"

# alias s3='aws s3 --acl=public-read'
# alias s3cp='aws s3 cp --acl=public-read'
# alias s3ls='aws s3 ls'
# s3rver testing; neat!
alias s3='aws --profile mdelocal --endpoint-url=http://localhost:4568 s3'

alias ddb='aws dynamodb --endpoint-url http://localhost:8000 --profile mdelocal'

# Don't know where alias make='colourify make' is coming from
unalias make

my_zk=localhost
my_bss=localhost:9092
my_schema_registry=http://schema-registry.service.consul
# my_brokers=kafka.service.consul:9092
my_brokers=localhost:9092
# my_schema_registry=http://schema-registry.service.consul
# alias k-topics='kafka-topics --zookeeper zookeeper-aws.service.consul:2181 --list'
alias k-topics='kafka-topics --zookeeper $my_zk --list | fzf'
alias k-avro-consumer='kafka-avro-console-consumer --bootstrap-server $my_bss --property schema.registry.url=$my_schema_registry --from-beginning --topic '

alias k-groups='kafka-consumer-groups --bootstrap-server $my_bss --group finops.kstreams --reset-offsets --to-latest --topic '
alias k-producer='kafka-console-producer --broker-list $my_brokers --topic '

k-consumer() {
    [[ -z $1 ]] && { echo 'USAGE: k-consumer <topic>'; echo 'Prints the last 30 records'; return }
    kafka-console-consumer --from-beginning --bootstrap-server $my_bss --timeout-ms 5000 --topic $1 | tail -30
}

alias k-consumer-fzf='k-consumer $(k-topics)'

alias k-topic-create='kafka-topics --zookeeper $my_zk --create --partitions 1 --replication-factor 1  --topic'

k-producer-x() {
    if [[ -z $1 ]]; then
        print 'USAGE: k-producer <topic>'
    fi
    kafka-console-producer --broker-list $my_brokers  --property parse.key=true --property key.schema='{"type":"string"}' --property "key.separator=|" --topic $1
}

k-consumer-avro() {
     kafka-avro-console-consumer --from-beginning --bootstrap-server $my_bss --timeout-ms 1000 --topic $1
}
