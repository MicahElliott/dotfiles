
gitenter() {
    if [[ -d .git ]] then;
        print "You’ve just ENTERED a git repo pointed at:"
        awk '/url = / {print $3}' .git/config
    fi
    if [[ -d $OLDPWD/.git ]] ; then
        print "You’ve just LEFT a git repo:"
        awk '/url = / {print $3}' $OLDPWD/.git/config
    fi
}

typeset -U chpwd_functions
chpwd_functions+=gitenter
