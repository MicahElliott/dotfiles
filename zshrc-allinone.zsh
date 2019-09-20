## ENVARS

export PAGER=less
export LESS='-F -R -S -X'


## OPTIONS

WORDCHARS='_'

# Set output of time cmd
# Default %J %U user %S system %P cpu %*E total
TIMEFMT='%U user, %S kernel, %P cpu, %M mbmaxmem, %X kbheap, %D kbstack, %K kbspacetot, %*E totelapsed'

# https://stackoverflow.com/questions/10847255/how-to-make-zsh-forward-word-behaviour-same-as-in-bash-emacs
# Emacs-like navigation
# Corresponding function in ~/contrib/zsh/functions/forward-word-match
autoload -U select-word-style
select-word-style bash

autoload -Uz compinit; compinit

## Help system. See zshcontrib(1) for instructions.
# unalias run-help
autoload run-help

bindkey "^[h" run-help
bindkey "^[H" run-help
# Prompt.
setopt promptsubst
autoload -Uz promptinit; promptinit
autoload -Uz vcs_info; vcs_info
autoload -Uz colors; colors

autoload zmv

# Do menu-driven completion.
zstyle ':completion:*' menu select

setopt interactivecomments
# Don't exit on ^D
setopt ignoreeof

# Changing dirs.
setopt cdablevars pushdignoredups pushdsilent chaselinks

# Enable ~ ^ # in glob patterns.
setopt extendedglob

# Report on bg jobs immediately when they finish.
setopt notify

# History
setopt appendhistory banghist histignorealldups histfindnodups
setopt histignorespace histnostore histreduceblanks histsavenodups
setopt incappendhistory extendedhistory

setopt nocaseglob
setopt correct

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

# Enable some nice things to go into post-prompt commands.
typeset -ga preexec_functions
typeset -ga precmd_functions

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

export FZF_DEFAULT_COMMAND="fzf --preview 'head -100 {}'"
# export FZF_COMPLETION_TRIGGER=''
# If you want TAB to do FZF.
# bindkey '^I' fzf-completion
# Guessing this makes normal TAB completion continue to work as usual.
# bindkey '^I' $fzf_default_completion
# export FZF_CTRL_T_OPTS="--preview '(highlight -O xterm256 -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_OPTS="--preview '(rougify {} || cat {} || tree -C {}) 2> /dev/null | head -200'"
# export FZF_CTRL_T_OPTS="--preview 'cat {} | head -200'"


# Z cd jump around tracking, silently observing
# https://github.com/rupa/z
# . /usr/share/z/z.sh
# . /usr/lib/z.sh

export ZPLUG_HOME=~/.zplug
# . $ZPLUG_HOME/init.zsh
# . /usr/share/zsh/scripts/zplug/init.zsh



## ALIASES

alias a='alias'
alias d='dirs -v'
alias f='fc -ldD'
alias h=run-help
alias j='jobs'
alias l='ls -hlkABFX --color=auto'
alias p='print -l'
alias q='exit'
alias s='sed -r'
alias sn='sed -nr'
alias t='tree -C --charset utf8'
alias td='t -d'
alias w='whence'
alias wa='w -av'
alias wm='w -m'
alias w1='whence'
alias x='exit'
alias lh='ls -lhkABF --color=auto'
alias lt='ls -lrtkhABF --color=auto'
ltt() { print -l ${1}*(.Om[-15,-1]) }
alias l.='ls -lBd .[a-zA-Z]*'
alias la='ls -a'
alias ll='ls -l'
alias lx='ls -hXB'
alias l1="ls -rt |awk 'END {print $NF}'" # or |tail -1

### Archlinux / sudo
alias sc='systemctl'
alias scu='sc --user'
alias ssc='sudo systemctl'
alias jc='journalctl -xal'
alias sjc='sudo journalctl -xal'
alias spk='sudo pkill'
alias sl='slocate -r'
alias up='sudo updatedb'
alias fw='firewall-cmd'

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

alias fn='declare -f'

alias cdl='cd -l'
alias md=mkdir
alias rd=rmdir
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

alias el='elinks -no-numbering -no-references -dump-width 200 -dump'
alias dump=el

# alias pg='pgrep --full --list-full'
alias pg='pgrep -fL'
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

alias tm='tmux'
# Each slime wants its own socket.
tmn() { tmux -L $PWD:t new }

### Docker
# alias dk='sudo docker'
alias dk='docker'
alias dkb='dk build'
alias dkh='dk history'
alias dka='dk attach'
alias dki='dk image'
alias dkc='dk container'
alias dkl='dk logs'
alias dkn='dk network'
alias dkp='dk ps'
alias dkr='dk run'
alias dks='dk search'
alias dkt='dk top'
alias dkv='dk volume'
alias dc='docker-compose'

### Globals
alias -g A='| a'
alias -g B='| bcat'
alias -g C='| wc -l'
alias -g D='| dump'
alias -g G='| grep --line-buffered'
alias -g F='| fzf'
alias -g H='| head'
alias -g J='| jq'
alias -g L='| less'
alias -g P='| $PAGER'
alias -g S='| sort -n'
alias -g T='| tail'
alias -g U='| uniq'
alias -g X='| xsel -b'

yum-bootstrap() { yum install zsh tmux git jq emacs-nox }


## KAFKA

# alias k-topics='kafka-topics --zookeeper zookeeper-aws.service.consul:2181 --list'
alias k-topics='kafka-topics --zookeeper zookeeper.service.consul --list'
alias k-avro-consumer='kafka-avro-console-consumer --bootstrap-server kafka.service.consul:9092 --property schema.registry.url=http://schema-registry.service.consul --from-beginning --topic '
alias k-consumer='kafka-console-consumer --from-beginning --bootstrap-server kafka.service.consul:9092 --topic '
alias k-groups='kafka-consumer-groups --bootstrap-server kafka.service.consul:9092 --group finops.kstreams --reset-offsets --to-latest --topic '
alias k-producer='kafka-console-producer --broker-list kafka.service.consul:9092  --property parse.key=true --property key.schema='{"type":"string"}' --property "key.separator=|" --topic '

sshm() { ssh -t $1 'ssh $(consul members | grep mesosslave | grep alive | awk "{print \$1}" | head -n 1)' }
