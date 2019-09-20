######################################################################
# Vendor
#
# Activation of other scripts beyond my control.
######################################################################

# Load RVM into a shell session.
##[[ -f "$HOME/.rvm/scripts/rvm" ]] &&
##    . "$HOME/.rvm/scripts/rvm"

# [[ -f "$HOME/local/bin/virtualenvwrapper.sh" ]] &&
#     . "$HOME/local/bin/virtualenvwrapper.sh"


#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/mc mc

. /usr/local/opt/asdf/asdf.sh
. /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash
