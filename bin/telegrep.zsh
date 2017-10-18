#! /usr/bin/zsh

# telegrep.zsh settings_panel membean/production/current/log/production.log

remotes=( ${(s.:.)TG_REMOTES} )
pattern=${1?provide pattern}
file=${2?provide remote file}
ctx=2  # grep context lines

# if [[ -z $TG_REMOTES || -z $ANSIBLE_INVENTORY ]]; then
if [[ -z $TG_REMOTES ]]; then
    print "Export remotes to grep in env var TG_REMOTES (and ANSIBLE_INVENTORY)" 1>&2
    print "Ex: export TG_REMOTES=qlapp32:qlapp33" 1>&2
    exit 1
fi

# Avoid matching sub-second timestamps for student IDs
pattern="[^.]$pattern"

for r in $remotes; do
    print -- "\n\n----\n$r"
    ssh $=ANSIBLE_SSH_ARGS $r "zgrep -i -C$ctx '$pattern' $file"
done # | sort -n

# for r in $remotes; do ssh $r "zgrep -i '$pattern' $file"; done | sort -n
