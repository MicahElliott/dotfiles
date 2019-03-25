if [[ "$OSTYPE" = 'darwin16.0' ]]; then

    print "Doing MacOS setup."

    path+=$HOME/homebrew/bin

    alias ed='Emacs --daemon'
    alias e='/Application/Emacs.app/Contents/MacOS/bin/emacsclient -c -n'

    alias updatedb='sudo /usr/libexec/locate.updatedb'

    alias ls=gls
    alias date=gdate
    alias dircolors=gdircolors

else
    : echo "skipping mac setup"
fi
