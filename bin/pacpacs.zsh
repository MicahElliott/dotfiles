#! /bin/zsh

# pacpacs — save the list of manually installed packages, for backup restore

# These are good considerations as packages deserving votes.
# Should keep pacpacs.lst in dotfiles.
# Should be run from crontab.

# Query the explicitly installed packages; includes AUR.
sudo pacman -Qe >|~/pacpacs.lst
