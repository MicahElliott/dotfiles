#! /bin/bash

# Working Copy Check (wccheck)
#
# Copyright (C) 2007 Micah Elliott <mde@micahelliott.com>
# Licensed under the terms subversion ships under or GPLv2.
#
# Inspect a list of local Working Copies to determine if some
# attention needs to be given to any of them due to (forgotten) local
# or (unnoticed) remote activity.  Should be called from your
# crontab(s) to send you mail notification.
#
# Put the following lines into your crontab on any machine(s) you
# work on (crontab -e):
#   
#   MAILTO=you@example.com
#   ...
#   # Run every night at 7:00 PM.
#   00 19 * * * wccheck.sh
#
# The idea is that you are a busy developer working on a number of
# projects at a time, and it's tough to keep track of the recent
# activity on all of them.  So it's nice to get an email reminder when
# you have made some change to one or more of your WCs (which you have
# forgotten to check in).  Likewise, you might want to know whenever
# any of these WCs have become stale, needing an update.  This is
# useful since it's often not practical to set up server-side hooks
# for every repo you are interested in.
#
# NOTE: The output is carefully silent if no changes are detected.
# This way cron will not mail you unless there are changes.

# Do you manage your $HOME with svn??  (I use a subdir with symlinks).
HOMEREPO="$HOME/mdesvn"
# Where you check out your WCs.
SANDBOX="$HOME/sandbox"
# List of WCs to check (add any others here).
REPOS="$HOMEREPO $SANDBOX/*"
# cron uses a limited path, so add any necessary.
PATH=/usr/bin:/bin:$HOME/svnlocal/bin

for r in $REPOS; do
    if [ ! -d $r ]; then
        echo "Oops: $r is not a directory!  Quitting."
        exit 1
    fi
    cd $r
    # Pay attention to any staleness except items not under VC.
    local_changes=$(  svn status    |egrep '^[^ \?]' )
    if [ -n "$local_changes" ]; then
        echo "You've made local changes to your WC $r"
        echo -e "$local_changes\n"
    fi
    remote_changes=$( svn status -u |egrep '\*' )
    if [ -n "$remote_changes" ]; then
        echo "You need to update your WC $r"
        echo -e "$remote_changes\n"
    fi
done
