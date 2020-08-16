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


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && { source ~/.p10k.zsh; p10k finalize }
zplug "romkatv/powerlevel10k", as:theme


CASE_SENSITIVE="true"
zplug "lib/completion", from:oh-my-zsh # for those sweet [tab] squares
zplug "modules/prompt", from:prezto

#zplug "zsh-users/zsh-history-substring-search"
#zplug "mafredri/zsh-async", from:github, defer:0

# Options: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/highlighters/main/main-highlighter.zsh
# https://github.com/zsh-users/zsh-syntax-highlighting/issues/359#issuecomment-373975223
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets pattern )
# Hmm, just basic colors? rgybmc
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=cyan
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=cyan
#ZSH_HIGHLIGHT_STYLES[assign]=none
ZSH_HIGHLIGHT_STYLES[assign]=fg=blue
zplug "zsh-users/zsh-syntax-highlighting", defer:2


######################################################################
# FUZZY COMPLETION: FZF
# C-t for normal finding
# C-r for history search
# M-c for cd
# https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh
# https://github.com/junegunn/fzf/wiki/Configuring-fuzzy-completion
# Remove default transpose-chars binding that conflicts with fzf
bindkey -r '^T'
# if [[ $ostype = 'Darwin' ]]; then
#     . /usr/local/opt/fzf/shell/key-bindings.zsh
#     . /usr/local/opt/fzf/shell/completion.zsh
# else
#     . /usr/share/fzf/key-bindings.zsh
#     . /usr/share/fzf/completion.zsh
# fi
export FZF_DEFAULT_COMMAND="fzf --preview 'head -100 {}'"
export FZF_COMPLETION_TRIGGER=,
# If you want TAB to do FZF.
# bindkey '^I' fzf-completion
# Guessing this makes normal TAB completion continue to work as usual.
# bindkey '^I' $fzf_default_completion
# export FZF_CTRL_T_OPTS="--preview '(highlight -O xterm256 -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_OPTS="--height 90% --preview '(bat --style=numbers --color=always {} || cat {} || tree -C {}) 2> /dev/null | head -200'"
# export FZF_CTRL_T_OPTS="--preview 'cat {} | head -200'"
# zplug "junegunn/fzf", use:"shell/*.zsh"
zplug junegunn/fzf

zplug zsh-users/zsh-autosuggestions
zplug zsh-users/zsh-completions
zplug hlissner/zsh-autopair, defer:2
# command-not-found

# C-x ;
zplug zsh-users/zaw

zplug "agkozak/zsh-z"

# zplug 'jimhester/per-directory-history'

zplug MicahElliott/97df9ca799e49c0fcc0a981bf021f813, from:gist, as:plugin, use:zbell-long-cmd.zsh

# zplug "akarzim/zsh-docker-aliases"

zplug "k4rthik/git-cal", as:command, frozen:1

zplug "nnao45/zsh-kubectl-completion"

# zplug " Valodim/zsh-curl-completion"

# Not working
# zplug "b4b4r07/emoji-cli"

zplug "~/proj/scad", from:local, use:'*.sh'

zplug check || zplug install
zplug load #--verbose
