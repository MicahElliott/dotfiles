#! /bin/zsh

# pinpop — show popularity of a pinboard url

url=${1?Must provide url}
#http://screensiz.es/
#https://pinboard.in/url:e43057898a2dc6fbbcbf9dc55b7298118d1ce005/

purl1='https://username:password@api.pinboard.in/v1/posts/get?format=json&url='
purl2='https://pinboard.in/url:'

#hash=$(curl -s "$purl1$url" |jshon -e 'posts' -a -e 'hash' |sed 's/"//g')

#elinks -no-numbering -no-references -dump-width 200 -dump "$purl2$hash" |sed -nr 8p

curl -L -si -A "Mozilla/5.0" -d "url=$url" 'https://pinboard.in/url/' |elinks -no-numbering -dump |grep -P '^ +\d{1,5} bookmarks'
