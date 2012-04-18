#! /bin/bash

# NOTE: removed --verbose

#HOME=/home/spd/mdelliot
HOME=/home/mde
targets="micah.elliott.name/moin/ Mail/ .aliases .procmailrc etc/ medrics/ survie/"
targets="micahelliott.com/ Mail .aliases public_html"

echo "rsync'ing mde@micahelliott.com, targets: $targets"

$HOME/bin/rsync-worker.sh mde@micahelliott.com $targets

#for tgt in $targets ; do
   #echo -e "\n\n==> blivet: rsync-ing '$tgt' to ~/kitchen <=="
   #rsync ... mde@micahelliott.com:/home/mde/$tgt $HOME/kitchen/$tgt
#done
