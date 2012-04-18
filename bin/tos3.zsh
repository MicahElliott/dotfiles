#! /bin/zsh

# Back up all of machine’s home area to S3 bucket.
#
# Only back up home *directories*. Support exclusion via rexclude file.
# s3cmd is a bit quirky. Need to use “rexclude” to get working.
#
# NOTE: Need to have trunk version of s3cmd to have support for “reduced
# redundancy”
#
# Would like to use `--delete-removed` option but with separate
# invocation makes each s3cmd delete others’ work.

# Can’t use delete-removed with this approach due to s3cmd not being
# smart enough to deal with other hierarchical things in a bucket.
# IOW, if I back up foo/ in first go, then bar/ in second, it will see
# that bar does not have foo so will delete all of foo.
# Anyway, this approach does not seem necessary since now no-op run
# seems to only take 6m (thought it was much worse). Will need to keep
# an eye on how slow it is as number of files grows.
#
#bucket="s3://mdebackup"
#s3dir="$bucket/$(hostname)/"
#for d in $HOME/*(/) ; do
#    echo -e "\n\nSync-ing $d to S3..."
#    time s3cmd sync $d \
#        --reduced-redundancy \
#        --rexclude-from ~/.s3exclude \
#        $s3dir >log/s3-${d:t}.log
#done

dryrun="--dry-run"
dryrun=""

# For use with machines: stud, mocushla, cloud
usage="$0 home|photos|videos"
[[ -n $1 ]] || { echo $usage; exit 1; }

log="$HOME/log/s3-$1.log"
if   [[ $1 == "home"     ]]; then
    src="$HOME"
    bucket="s3://mde-$(hostname)/"
    acl="--acl-private"
elif [[ $1 == "photos"   ]]; then
    src="/media/LACIE/Photos/"
    bucket="s3://mde-photos/"
    acl="--acl-public"
elif [[ $1 == "videos"   ]]; then
    src="/media/LACIE/Videos/"
    bucket="s3://mde-videos/"
    acl="--acl-public"
else
    echo $usage; exit 1;
fi

echo "In 5s will sync $src to S3’s $bucket ..."
sleep 5
echo "Going for it! Log tee-ing to $log"

# Run unbuffered so output of big files comes without excessive delay.
time python -u =s3cmd sync \
    $dryrun $acl --reduced-redundancy --delete-removed \
    --rexclude-from ~/.s3exclude --rexclude '/\..*' \
    $src $bucket > $log
