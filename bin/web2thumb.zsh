#! /bin/zsh

# web2thumb — convert a webpage into shapshot and thumbnail images

url=${1?Must provide url}
hsh=${2?Must provide hash value for name}

big=$hsh-big.jpg
thm=$hsh-thumb.jpg
wkhtmltoimage $url $big

convert $big -resize '100x100!' $thm
identify $thm
