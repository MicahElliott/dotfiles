# ZPlug


source ~/.zplug/init.zsh

# Though neat, don't really want the git aliases, since magit.
# zplug "plugins/git",   from:oh-my-zsh

# Themes
# zplug dracula/zsh, as:theme
# zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
# zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
# zplug starship/starship, as:theme
# zstyle ':prompt:pure:prompt:success' color green
# PURE_CMD_MAX_EXEC_TIME=10
# zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
# zplug "therealklanni/purity",  from:github, as:theme
# zplug themes/geoffgarside,  from:oh-my-zsh, as:theme
# zplug isqua/bureau,  from:oh-my-zsh, as:theme
# zplug themes/agnoster, from:oh-my-zsh, as:theme
# zplug 'dracula/zsh', as:theme
zplug "romkatv/powerlevel10k", as:theme

zplug "lib/completion", from:oh-my-zsh # for those sweet [tab] squares
zplug "modules/prompt", from:prezto

#zplug "zsh-users/zsh-history-substring-search"
#zplug "mafredri/zsh-async", from:github, defer:0
#zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug zsh-users/zsh-autosuggestions
zplug zsh-users/zsh-completions
zplug hlissner/zsh-autopair, defer:2
# command-not-found

# C-x ;
zplug zsh-users/zaw

zplug "agkozak/zsh-z"

zplug 'jimhester/per-directory-history'

zplug MicahElliott/97df9ca799e49c0fcc0a981bf021f813, from:gist, as:plugin, use:zbell-long-cmd.zsh

zplug "akarzim/zsh-docker-aliases"

zplug "k4rthik/git-cal", as:command, frozen:1

# Not working
# zplug "b4b4r07/emoji-cli"

zplug check || zplug install
zplug load #--verbose
