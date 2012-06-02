######################################################################
# Functions
######################################################################

# These should mostly be separated out into separate files for each
# func. Some could also be scripts. Mostly these should be functions
# if they affect the environment in some way.

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

re-aliases() {
    . $my_zshdir/aliases.sh
    . $my_zshdir/aliases.zsh
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
t () {
    test -z $1 && { echo "missing .py"; return; }
    origpwd=$PWD
    cd ../test
    python ./test_$1
    cd $origpwd
}

# Python vim test and module setup for vim.
vpy() {
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
lsd() { ls -d $(find -maxdepth 1 -type d -iname '[a-z]*' |sed 's/^..//'); }
# FIXME: lsf on dir with no files prints dirs since result is empty.
lsf() {
    local res
    res=$( find -maxdepth 1 -type f -iname '[a-z]*' |sed 's/^..//')
    test -z "$res" && echo 'No files here!' || echo $res
}

# Initialize a shell (just history for now) for proj work.
i histinit () {
    if [[ -z $1 ]] ; then
        HISTFILE=~/.history/$(basename $PWD)
    else
        HISTFILE=~/.history/$1
    fi
    echo "Set HISTFILE=$HISTFILE"
    if [[ -f $HISTFILE ]] ; then
        fc -RI
        echo "Loaded prior existing history."
        history
    else
        echo "This is a brand-spankin' new history!"
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

# Vi-Grep
# Edit the file grepped for if found one match.
vig() {
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

vimdocgen() {
    if [[ -z $1 ]]; then
        echo "Generate documnetion (tags) file for vim plugin.\n"
        echo "usage: vimdocgen some/vim/plugin/doc"
        return
    fi
    vim -c ":helptags $1|q"
    echo "${reset_color}Created tags file for viewing documentation for ‘$1:h:t’ plugin."
}

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
typeset -U chpwd_functions
chpwd_functions+=gitenter

# Run Maven goals through syntax highlighter.
mc() { mvn clean   $@ 2>&1 |mvn-hilite.awk }  # delete build output
mt() { mvn test    $@ 2>&1 |mvn-hilite.awk }  # run unit tests
mi() { mvn install $@ 2>&1 |mvn-hilite.awk }  # artifact to local repo
md() { mvn deploy  $@ 2>&1 |mvn-hilite.awk }  # project documentation
ms() { mvn site    $@ 2>&1 |mvn-hilite.awk }  # project documentation

# http://www.zsh.org/mla/users/2011/msg00527.html
rehash-last-install() { fc -l -1 |grep -q install && { echo rehash-ing; rehash } }
precmd_functions+=rehash-last-install


vi-maps() {
    print "All possible vim maps to contend with:"
    grep -Eir '^[^"]*leader>' ~/.vimrc ~/config/vim ~/gitcontainer/vim
}

gw() { grep -E --color $1 /usr/share/dict/words }

gi() { gem install $@; rbenv rehash; rehash }
