#! /bin/zsh

# Glipper plugin wrapper
#
# Buggy in that it will only allow a single action, so need to make this
# a big case statement.

#arg1=${1?Must provide arg}
#print $0

print Looking at $@
read -q "proceed?clone the repo into ~/archive/src? " || { echo aborting; exit; }

print "Doing a github clone of $1."
sleep 1

repo=${1?Must provide repo}

cd ~/archive/src

git clone $1 # || exit
cd $1:t:r
#ls -l
less README*

sleep 1

print "Firing up a urxvt"
sleep 1
exec /usr/bin/urxvt -geometry 102x94 &
#disown %urxvt

sleep 1
