# Zsh-specific aliases (not supported by bash)

#print "in aliases.zsh"

# Programs to auto-run per extension.
# So just putting "foo.txt" on CLI will expand to "vim foo.txt"
alias -s txt=vim
alias -s mkd=vim
alias -s csv=vim
alias -s html=vim
alias -s haml=vim
alias -s vim=vim
alias -s sass=vim
alias -s scss=vim
alias -s png=eog
alias -s jpg=eog
alias -s flv=vlc
alias -s mp4=vlc
alias -s webm=chromium-browser
alias -s xcf=gimp
alias -s gz='tar xzvf'
alias -s bz2='tar jzvf'
alias -s pdf=evince
alias -s deb='sudo dpkg -i'

alias -s feature='cucumber'

# Places to cd
# Actually, these behave better using cdpath (see options.zsh)
#alias -g mb=~/proj/Membean

# I can't seem to get ESC-h working for run-help, so this'll have to do.
alias h=run-help

alias de='vared dirstack'

### Globals
alias -g C='| wc -l'  # grep foo ~/.zsh/* C
