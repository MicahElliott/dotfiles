if [[ $ostype = 'Darwin' ]]; then

    print "Doing MacOS setup."

    path+=$HOME/homebrew/bin

    alias ed='Emacs --daemon'
    alias e='/Application/Emacs.app/Contents/MacOS/bin/emacsclient -c -n'

    alias updatedb='sudo /usr/libexec/locate.updatedb'

    alias ls=gls
    alias date=gdate
    alias dircolors=gdircolors

    # export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$HOME/homebrew/share/zsh-syntax-highlighting-highlighters
    # source $HOME/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

else
    : echo "skipping mac setup"
fi
