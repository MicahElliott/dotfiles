######################################################################
# Functions
######################################################################

# These should mostly be separated out into separate files for each
# func. Some could also be scripts. Mostly these should be functions
# if they affect the environment in some way.

out()  { print $@ ; }
warn() { print "$fg[yel]WARNING:$reset_color" $@ >&2 }
err()  { print "$fg[red]ERROR:$reset_color" $@ >&2 }

# Tar conveniences.
tarc() { tar czvf $1.tar.gz $1; }
tarx() { tar xzvf $1; }
tart() { tar tzvf $1; }
# Grep for language-specific files.
hloc() { slocate -d ~/database/home.db "$@"; }
#qloc() { slocate -d ~/database/quad.db "$@"; }
#qfind() { find /var/quad/mdelliot -type f -name $1 -maxdepth 3; }
# History grep.
hgrep() { history |grep --color=auto "$1"; }
# Grep QuAD issues.
#qgrep() { grep --color=auto "$1" $(find /var/quad/mdelliot -type f -name README -maxdepth 3); }
pygrep() { egrep --color=auto "$@" *.py; }
plgrep() { egrep --color=auto "$@" *.pl *.pm; }

re-comps() {
  # Pain to test
  rm ~/.zcompdump
  # or could do: urxvtcd
  exec zsh
}

#grep() {
#    local EXCLUDE
#    # Check for existence of "exclude" files, even symlinks.
#    test -e ~/.grepexclude && EXCLUDE="--exclude-from=~/.grepexclude"
#    test -e .grepexclude && EXCLUDE="--exclude-from=.grepexclude"
#    # Use color, extended syntax, ignore certain globs.
#    /bin/grep -E $EXCLUDE --color=always "$@"
#}

ltime() {
    for i in atime ctime; do
        echo "($i):"
        ls -l --time=$i "$@"
    done
    echo "(mtime):"
    ls -l "$@"
}

# Run CESR unit test(s).
ct () {
    origcwd=$PWD
    cd $CESRHOME/test
    test -z "$1" && {
        ./rununittests.py
    } || {
        tst=$(echo $1 |sed "s:^:./test_:")
        echo $tst
        eval $tst
    }
    cd $origcwd
}

# Auto unit-testing for Python.  Probably nose obviates this.
pyt() {
    test -z $1 && { echo "missing .py"; return; }
    origpwd=$PWD
    cd ../test
    python ./test_$1
    cd $origpwd
}

# Needed for zsh, but does no harm to have here.
fg() {
    if [[ $# -eq 1 && $1 = - ]]; then
        builtin fg %-
    else
        builtin fg %"$@"
    fi
}

# Needed for zsh, but does no harm to have here.
history() {
    if [[ $# -eq 1 ]]; then
        builtin history | tail -$1
    else
        builtin history
    fi
}

# Show VCS-untracked files.
# Supports hg and git. Must be run from top dir of project.
# Ex: eog $(untracked)
untracked () {
    local cmd dir="."
    test -n "$1" && dir="$1"
    if [ -d ".git" ]; then
        cmd="git st $dir -u --porcelain | cut -f2 -d' '"
    elif [ -d ".hg" ]; then
        cmd="hg st -i $dir | cut -f2 -d' '"
    else
        echo "CWD not a VCS-controlled top-level proj dir."
        return
    fi
    eval "$cmd"
}

# ls for dirs and files only.
#lsd() { ls -d $(find -maxdepth 1 -type d -iname '[a-z]*' |sed 's/^..//'); }
## FIXME: lsf on dir with no files prints dirs since result is empty.
#lsf() {
    #local res
    #res=$( find -maxdepth 1 -type f -iname '[a-z]*' |sed 's/^..//')
    #test -z "$res" && echo 'No files here!' || echo $res
#}

# Initialize a shell (just history for now) for proj work.
i histinit () {
    # Reuse existing from PWD or create new
    [[ -z $1 ]] && HISTFILE=~/.history/$PWD:t || HISTFILE=~/.history/$1
    echo "Set HISTFILE=$HISTFILE"
    if [[ -f $HISTFILE ]] ; then
        fc -RI  # read incremental (often)
        echo 'Loaded prior existing history. Tail:'
        fc -l |tail
    else
        echo 'This is a brand-new history!'
    fi
}

latest() {
    set -x
    local tgt ext cmd util filepath filename response
    # Latest download.
    filepath=$( ls $HOME/Downloads/$(ls -rt $HOME/Downloads/ |tail -1) )
    filename=$(basename "$filepath")
    # Go to archive to perform work.
    pushd $HOME/archive
    case "$filename" in
        #*(*.tar.gz|*.tgz) ) util="tar xzvf" ;;
        *.tar.gz  )
            tgt="$HOME/archive/packages"
            util="tar xzvf '$filename'"
            ;;
        *.tar.bz2 )
            tgt="$HOME/archive/packages"
            util="tar jzvf '$filename'"
            ;;
        (#i)*.(jpg|jpeg|gif|png) )
            tgt="$HOME/archive/images"
            util=""
            ;;
        (#i)*.(pdf|mov|mp4|doc) )
            tgt="$HOME/archive/reference"
            util=""
            ;;
        # Add more here, for zip, etc.
        # Not recognized.
        * ) echo "Don't know what to do with $filename"; return ;;
    esac
    # Set up for optional extraction command.
    cmd="mv $filepath $tgt"
    [[ -n "$util" ]] && cmd+=" ; $util"
    # See if ok to proceed.
    read -k1 "response?> $cmd [Y/n] "
    if [[ ! "$response" =~ "[Nn]" ]] ; then
        cd $tgt
        eval "$cmd"
    else
        echo -e "\naborting"
        return
    fi
    # Put final path into paste buffer.
    #echo "$tgt" |xsel -i
    echo "Sending you to $tgt"
    echo "Now look at $filename and have your way with it."
}

### VIM ##############################################################

# Python vim test and module setup for vim.
vi-py() {
    test -z $1 && { echo "missing .py"; return; }
    if [ -f "../test/test_$1" ];
    then
        origpwd=$PWD
        cd ../test
        vim -c "set makeprg=python\ test_$1" -O2 -geom 161 "$origpwd/$1" "test_$1"
        cd $origpwd
    else
        vim $1
    fi
}

# Vi-Grep
# Edit the file grepped for if found one match.
vi-g() {
    pat=$1
    dir=$2
    file=()
    # Safely read space-separted file names; may be more than one file.
    grep -lr $pat $dir | while read -r f; do file+=$f; done
    if [[ $#file -gt 1 ]]; then
        print "More than 1 result" >&2
        print -l $file
        return 7 # list too long
    elif [[ $#file -lt 1 ]]; then
        print "No results." >&2
        return 61 # no data
    else
        # Awk piece same as: cut -f1 -d: |head -1
        lineno=$(grep -hnr $pat $file |awk -F: '{print $1; exit}')
        v $file +$lineno
    fi
}
vi-docgen() {
    if [[ -z $1 ]]; then
        echo "Generate documnetion (tags) file for vim plugin.\n"
        echo "usage: vimdocgen some/vim/plugin/doc"
        return
    fi
    vim -c ":helptags $1|q"
    echo "${reset_color}Created tags file for viewing documentation for ‘$1:h:t’ plugin."
}
vi-docgenmulti() {
    # cd ~/gitcontainer/vim
    for d in */doc(/); do vimdocgen $d; done
}
vi-maps() {
    print "All possible vim maps to contend with:"
    grep -Eir '^[^ ]*leader>' ~/.vimrc ~/config/vim ~/gitcontainer/vim
}
vi-addons() {
  for d in ~/gitcontainer/vim/*(/); p $d:t
}

######################################################################

# Show a historic file, displayed in color.
gitm-show-file() {
    #GIT_PAGER="pygmentize -l py |less" git show a792cff9e155513f5d37728dbc842484337a89ea:autotest.py
    rev=$1
    fname=$2
    ftype=$fname:e
    GIT_PAGER="pygmentize -l $ftype |less" git show ${rev}:$fname
}

# Demonstrate/test argument-splitting done in arrays et al.
showargs() { for arg do echo "»$arg«"; done; }

# Show all defined functions.
# There’s probably a cleaner built-in way to do this, but I’m not
# finding it. Might consider also showing hidden ‘_’-prefixed funcs.
showfuncs funcshow () { functions |awk '/^[[:alpha:]].*{$/ {print $1}' |$PAGER; }

nose-init() {
    # Nose
    export NOSE_TEST_CONFIG_FILE=$PWD/config.yml
    export NOSE_TEST_CONFIG_FILE_FORMAT=yaml
    export NOSE_NOCAPTURE=1
}

# Inform of presence of git repos.
# Assume no nesting.
gitenter() {
    local i
    # Find all dirs below.
    #${(ws:/:)PWD}      # splitting
    #${(j:/:)dsa[1,2]}  # joining
    ds=( ${(ws:/:)PWD} )  # just for getting length
    for i in {1..$#ds}; do
        d=${PWD[1,(ws:/:)$i]}
        #p $d
        if [[ -d $d/.git ]] then;
            print "You’ve just ENTERED a git repo pointed at:"
            #git config remote.origin.url
            git --git-dir=$d/.git config remote.origin.url
            #awk '/url = / {print $3}' $d/.git/config
        fi
    done
    if [[ -d $OLDPWD/.git ]] ; then
        print "You’ve just EXITED a git repo:"
        git --git-dir=$OLDPWD/.git config remote.origin.url
        #awk '/url = / {print $3}' $OLDPWD/.git/config
    fi
}
#typeset -U chpwd_functions
#chpwd_functions+=gitenter

# Run Maven goals through syntax highlighter.
mvc() { mvn clean   $@ 2>&1 |mvn-hilite.awk }  # delete build output
mvt() { mvn test    $@ 2>&1 |mvn-hilite.awk }  # run unit tests
mvi() { mvn install $@ 2>&1 |mvn-hilite.awk }  # artifact to local repo
#md() { mvn deploy  $@ 2>&1 |mvn-hilite.awk }  # project documentation
mvs() { mvn site    $@ 2>&1 |mvn-hilite.awk }  # project documentation

# Simple (broken) version of https://github.com/kennethreitz/autoenv
autoenv() {
  if [[ -f .env ]]; then
    print 'Found .env; sourcing it!'
    source .env
  fi
}

# http://www.zsh.org/mla/users/2011/msg00527.html
rehash-last-install() { fc -l -1 |grep -q install && { echo rehash-ing; rehash } }
#precmd_functions+=rehash-last-install
#precmd_functions+=autoenv


gw() { grep -E --color $1 /usr/share/dict/words }

gi() { gem install $@; rehash }

# Initialize rbenv.
# Too slow to do for every shell by default so making manual.
#rbi() { eval "$(rbenv init -)" }

# nvm: a little slow to start
ni()  {
  en-py2
  print "Enabling NVM"
  [[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh
  print "Turning off stderr highlighting."
  unset LD_PRELOAD
  print -n "Node "; node -v
  rehash
}
jsi() { ni }
nvi() { ni }

# Firefox addon sdk
ffi() {
  en-py2
  # Have to be in this dir to work??
  cd ~/archive/src/addon-sdk-1.14
  . bin/activate
}

# Create a gemset.
rbg() {
    local gsname=$1 gsfile=.rbenv-gemsets
    if (( $#@ < 1 )); then
        print "usage: $0 <gemsetname>"
        return
    fi
    if [[ -f $gsfile ]]; then
        print -n "Already using gemset: "
        <$gsfile
        print "Delete $gsfile to proceed."
        return
    fi
    # Default to just use active version
    local rver=$(rbenv versions| awk '/\*/ {print $2}')
    print "Creating gemset area."
    rbenv gemset create $rver $gsname
    print "Persistently activating gemset (and global gemset)."
    >$gsfile <<<"$gsname global"
    print -n "Active gemset: "
    rbenv gemset active
}

# mkdir & chdir in one
mcd() { mkdir $1 && cd $1 }

cl() { git clone $1 && cd $1:t:r }

#rg() { rk db:test:prepare; ./bin/guard }

bl() { slocate -d books.udb -ir $1 |s 's:.*torrent/::' }

isgmail() { host $1 |awk '/mail/ {print $7}' |grep -q google }

isprogressive() { identify -verbose $1 |grep -q 'Interlace: JPEG' }
zstyle ':completion:*:*:isprogressive:*' file-patterns '*.jpg'

# cat a json file as pretty json or cson
cjs2() { json2cson $1 |pygmentize -l coffeescript }
zstyle ':completion:*:*:ccs:*' file-patterns '*.json'
cjs() { json_reformat <$1 |coderay -json }
zstyle ':completion:*:*:cjs:*' file-patterns '*.{json,js}'
ccs() { python3 =pygmentize -l coffeescript $1 }

py2en() {
  print "Enabling python2 in path via /var/tmp/bin hack."
  path=(/var/tmp2/bin $path)
  python -V
}

### Change urxvt/xterm bg color
# Depends on colortrans.py to get a hex color from rgb.
bgset() {
  local hex=$(colortrans.py $1 2>/dev/null)
  print "setting bg to $hex"
  # http://www.steike.com/code/xterm-colors/
  print "\e]11;#${hex}\007"
}

# See biggest packages
pacbiggest() {
  pacman -Qi |
    awk '/Name/ { name=$3 } /Size/ { printf "%.3fMB\t%s\n", $4/1024, name }' |
    sort -rh | head -n 20
}

# Rename a file with an infix number/marker, like: foo.1.yml
# Assumptions:
# - file's number must be second-to-last extension.
# - file has extension
# Examples:
# % touch a.b
# % ren a.b
# => mv a.b a.1.b
# % touch f.j.k f.j.1.k f.j.2.k
# % ren f.j.k
# => mv f.j.k f.j.2.k
# % touch p.q p.3.q
# % ren p.q
# => mv p.q p.4.q
ren rev () {
  #set -x
  local newhi=1 fname=$1 ext=$1:e base=$1:r vers latest hi newfname
  [[ ! -f $fname ]]         && { err "Not a file: $fname"; return 1 }
  [[ $fname =~ '\.\d+\.' ]] && { err "Can’t rename file with verno."; return 1 }
  # Find existing versioned files.
  # a.b.c -> a.b.*.c
  # http://www.zsh.org/mla/users/2010/msg00132.html
  if () { setopt localoptions nonomatch nocshnullglob
          [ -f $base.*.$ext([1]) ] }; then
    #newhi=( $base.*.$ext([-1]) )
    vers=( $base.*.$ext )
    #newhi=$(( $#vers + 1 ))  # not safe if missing vers in sequence
    latest=$vers[-1]
    hi=$latest:r:e
    newhi=$(( hi + 1 ))
  fi
  newfname=$base.$newhi.$ext
  [[ -f $newfname ]] && { err "Should not already exist: $newfname"; return 1 }
  print mv $fname $newfname
  mv $fname $newfname
}

# Debugging aid; use with:
# _foo() { compstatus; _foo() { compstatus; compadd ${(f)"$(foo.zsh $words[2])"} }
# compdef _foo foo.zsh
compstatus() { print "words: $words\nCURRENT: $CURRENT\n" |osd_cat -d1 -s1 }

# Shoving here since not working as file in fpath.
#_mm() { compadd ${(f)"$(./completeid.zsh $words[2])"} }
#compdef _mm mmr mmu mmd

# Recent downloads
dl()  { print ~/Downloads/*(.om[0,1])  }
dlx() { print ~/Downloads/*(.om[0,$1]) }

md() { mkdir $1; cd $1 }

command_not_found_handler() {
  # https://wiki.archlinux.org/index.php/Zsh#The_.22command_not_found.22_hook
  # Try "darcs" as test.
  if [[ -x /usr/bin/cnf-lookup ]]; then
    cnf-lookup -c $1 && return
  fi
  # http://www.zsh.org/mla/users/2013/msg00482.html
  local actual=$1.zsh
  shift
  for p in $path; do
    if [[ -x $p/$actual ]]; then
      print "Proxying for actual: $actual"
      $actual $@
      return
    fi
  done
  return 127
}

c() {
  # Also consider vimcat!
  [[ $1:e == zsh ]] && local arg='-l bash'
  #print 0:$0 1:$1 2:$2
  # pygmentize $=arg $1 2>/dev/null || coderay $1 || cat $1
  highlight -O xterm256 $@
}

rsync-mde() {
  if ! mountpoint /mnt/wd; then
    print "wd not mounted?"
    print "try: sudo mount /dev/sdb1 /mnt/wd"
    return 1
  fi
  cd ~
  time rsync -avprP ~/. /mnt/wd/mde-arix |tee ~/log/rsync-mde-arix-`dt`.log
}

# To be run before startx to set up gpg and ssh agents
keychains() {
  # timeout is in minutes
  eval $(keychain --eval --quick --timeout 360 --agents gpg,ssh id_rsa)
}

shoot() {
  # local ss=$PWD/snapshot-`dts`.png
  local ss=~/snaps/snapshot-`dts`.png
  maim -s $ss
  print $ss |xsel -bps
  read -q '?gimp (y/N)> ' && gimp $ss
  print "Save snapshot as: $ss"
}

seconds-since-midnight() {
  # Seconds since midnight
  # http://unix.stackexchange.com/questions/146550/
  zmodload zsh/datetime
  now=$EPOCHSECONDS
  strftime -s today %F $now
  strftime -rs midnight %F $today
  echo $((now - midnight))
}

# pw() { pwd |xsel -b}
# Grab a random clojure file, for starting emacs randomly: e `randfile`&
randfile() { ls src/**/*.clj test/**/*.clj |shuf |sn 1p }

sshm() { ssh -t $1 'ssh $(consul members | grep mesosslave | grep alive | awk "{print \$1}" | head -n 1)' }

ssh-bastionize() {
    /usr/local/bin/gsed -i "s/bastion\.mde-.*\.fc-unstable.co.uk/bastion.mde-$(date '+%Y%m%d').fc-unstable.co.uk/" ~/.ssh/config
}
