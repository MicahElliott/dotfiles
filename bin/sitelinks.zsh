#! /bin/zsh

# DESCRIPTION

site=${1?Must provide site}

links=( $(curl -s $site/sitemap.xml |grep "http://$site" |sed -r -e 's/.*http/http/' -e 's/<\/loc>//') )


for l in $links; do
    #print "hi $l"
    print "Generating $l"
    ~/archive/src/cutycapt/CutyCapt/CutyCapt --url=$l --delay=1000 --min-width=960 --out=snaps/$l:t.png
done

