#! /usr/bin/env zsh

# curltest — produce meaningful exit status based on getting 200 OK on HEAD

url=${1?Must provide arg}

es=$(curl -s -I $url |grep 'HTTP/1.1' |awk '{print $2}')

(( es == 200 )) && exit 0 || exit 1
