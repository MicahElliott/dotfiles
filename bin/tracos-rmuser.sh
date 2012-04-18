usage="$0 USER"
test $# == 1 || { echo $usage; exit 1; }
user=$1

# TODO: Remove user from tracos-users mailing list. <MDE>

userdel $user
htpasswd -D /etc/svn-auth-file $user
