if [[ "$OSTYPE" = 'darwin16.0' ]]; then

    path+=$HOME/homebrew/bin

    alias ed='Emacs --daemon'
    alias e='/Application/Emacs.app/Contents/MacOS/bin/emacsclient -c -n'

    alias updatedb='sudo /usr/libexec/locate.updatedb'

    alias ls=gls
    alias date=gdate

else
    : echo "skipping mac setup"
fi
