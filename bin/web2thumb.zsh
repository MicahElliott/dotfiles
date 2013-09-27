#! /bin/zsh

# web2thumb — convert a webpage into shapshot and thumbnail images

url=${1?Must provide url}
hsh=${2?Must provide hash value for name}

big=$hsh-big.jpg
thm=$hsh-thumb.jpg

print "Generating page snapshot"
wkhtmltoimage $url $big

print "Shrinking dimensions and file size"
convert $big -resize '100x100!' -quality 30 $thm
identify $thm

print "Generating uuencoded string file"
# Store the uu in redis?
uuencode -m $thm $hsh >$thm.uu

# Convert a favicon.
# http://www.imagemagick.org/discourse-server/viewtopic.php?f=2&t=16562
#convert favicon.ico -resize '16x16!' -flatten -colors 256 fav2.jpg

