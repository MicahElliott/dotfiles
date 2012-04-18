#! /bin/bash

# NOTE: removed --verbose

#targets="micah.elliott.name/moin Mail .aliases .procmailrc etc"
targets="gcash/ foo"

echo "rsync'ing shed1, targets: $targets"

$HOME/bin/rsync-worker.sh shed1 $targets
