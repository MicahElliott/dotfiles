#! /bin/bash

# FooBar/revisions/00000001
# FooBar/revisions/00000002
# ...
# FooBar/revisions/00000025
# FooBar/revisions/00000026


# cd mywiki/data/pages

outdir=moindump
mkdir $outdir
for d in [A-Z]* ; do
    pagename=$d
    #echo $pagename
    pages=$pagename/revisions/*
    # Get newest file
    latest=$(ls -t $pages |head -1)
    echo "latest: $latest"
    test -f "$latest" && cp $latest $outdir/$pagename.txt
done
