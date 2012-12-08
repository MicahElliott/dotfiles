#! /bin/zsh

# callcentric — ping callcentric to check status of phone registration
#
# Probably should be placed in a crontab and send email or some such
# notification message.

[[ -r ~/.passwords ]] && . ~/.passwords
if [[ -z $CALLCENTRIC_USERNAME ]]; then
    print "You need to set CALLCENTRIC_* envars."
    exit 78 # EX_CONFIG
fi

### Just a test of king comment.

username=$CALLCENTRIC_USERNAME
password=$CALLCENTRIC_PASSWORD

#cookie=$TMPDIR/callcentric.cookie
cookie=$(mktemp -p /tmp) || exit
statusfile=/tmp/callcentric.status

#if [[ -f $cookie ]]; then
# echo "Reusing cookie: $cookie"
#else
    echo "Generating cookie…"
    curl -s --insecure --cookie-jar $cookie \
        'https://www.callcentric.com/login' -d "l_login=$username" \
        -d "l_passwd=$password" -d 'go=login'
    # Mysterious seemingly unnecessary POST params.
    #-d 'x=39' -d 'y=14'
##fi

echo "Grabbing phone status…"
curl -s --cookie $cookie \
    https://my.callcentric.com/get_reg_stat.php |
    grep -iq 'is registered'
registered=$?

echo "Deleting cookie."
rm $cookie

typeset -A msg
if [[ $registered != 0 ]]; then
    #report "$msg" "$status"
    msg=('PROBLEM' 'Phone not registered.')
    echo ${(kv)msg}
    notify-send ${(kv)msg} --icon ~/artwork/misc/phone-red.png
    echo 69 > $statusfile
    exit 69 # EX_UNAVAILABLE
else
    msg=('YAY' 'Phone is registered.')
    echo ${(kv)msg}
    notify-send ${(kv)msg} --icon ~/artwork/misc/phone-green.png
    echo 0 > $statusfile
fi
