#! /bin/zsh

# dnfs — save the list of manually installed packages, for backup restore

# These are good considerations as packages deserving votes.
# Keep dnfs.lst in dotfiles.
# Should be run from crontab.

print 'Query the explicitly installed packages to save in dnfs.lst'
dnf repoquery --userinstalled --qf "%{name}\n" >| ~/dnfs.lst

print 'Get a list of everything in .local/bin to save in egets.lst'
print -l ~/.local/bin/*(:t) >| ~/egets.lst
