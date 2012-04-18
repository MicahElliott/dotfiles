#! /bin/bash

# NOTE: This script is probably no longer necessary on bigd thanks
# /var/LACIE being replicated to USB disks.  But blivet still needs it
# to send things to micahelliott.com for backup.

# USAGE: msync Mail/ public_html/ ...

targets="${@:?'must provide at least one target'}"
runhost=$(hostname)
archivehost="mde@micahelliott.com"
archivepath="/var/LACIE/backup"
tgtdir="$archivepath/$runhost"

#echo $targets
date

for tgt in $targets ; do

    echo -e "\n\n==> $runhost: rsync-ing '$tgt' to $archivehost:$tgtdir <=="

    rsync \
        --verbose \
        --delete \
        --update \
        --archive \
        --recursive \
        --compress \
        --rsh=ssh \
        --delete \
        --exclude='trash-*' \
        --exclude='spam*' \
        --exclude='cron*' \
        --exclude='.svn*' \
    $tgt $archivehost:$tgtdir

    echo -e "\n\nExit Status: $?"

done

echo -e "\n\n"
date
