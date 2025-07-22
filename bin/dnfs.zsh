#! /bin/zsh

# dnfs — save the list of manually installed packages, for backup restore

# These are good considerations as packages deserving votes.
# Keep dnfs.lst in dotfiles.
# Should be run from crontab.

# Query the explicitly installed packages
dnf repoquery --userinstalled --qf "%{name}\n" >| dnfs.lst
