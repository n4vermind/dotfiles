# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

# theme
ZSH_THEME="mnml"

# plugins
plugins=(
    zsh-completions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# aliases
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias fzf='fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'
alias l='ls -l'
alias ls='lsd'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias cat='bat'
alias q='exit'
alias rzsh='source ~/.zshrc'
