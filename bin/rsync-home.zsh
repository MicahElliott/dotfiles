#! /usr/bin/env zsh

# rsync-home — sync home dir to usb drive

dt=$( date "+%Y%m%d" )

#if [[ ! -d /mnt/usbstick/mde-arix ]]; then
if ! df |grep -q usbstick; then
  print Not mounted. Run this:
  print sudo mount /dev/sdb1 /mnt/usbstick
  exit 1
fi

time rsync -avprP \
  --exclude '*.log' --exclude .config --exclude Dropbox \
  --exclude .cache --exclude 'VirtualBox VMs' --exclude .vagrant.d \
  --exclude .rubies --exclude .node --exclude Desktop --exclude Downloads   \
  --exclude exp \
  --exclude .npm \
  --exclude .gem \
  --exclude .m2 \
  --exclude .keychain \
  --exclude .java \
  --exclude .icons \
  --exclude .dropbox \
  --exclude .gimp \
  --exclude .macromedia \
  --exclude .thumbnails \
  --exclude .thunderbird \
  --exclude .nvm \
  --exclude .opam \
  --exclude .racket \
  --exclude kdenlive \
  --exclude .mozilla \
  --exclude .lein \
  --exclude Dropbox \
  --exclude local \
  --exclude constellation \
  --exclude huge \
  --exclude tmp \
  --exclude scratch \
  --exclude mde/src \
  ~ /mnt/usbstick/mde-`hostname` |tee ~/log/rsync-mde-`hostname`-$dt.log
