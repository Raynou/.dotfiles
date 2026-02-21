#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# Custom variable
export WORKSPACE='~/workspace'
#export REPOS='$WORKSPACE/repositories' fix this
export REPOS='~/workspace/repositories'

# Aliases
alias ..='cd ..'
alias v='nvim'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# Start ssh-agent
eval "$(ssh-agent -s)"

# Starship
eval "$(starship init bash)"
. "$HOME/.cargo/env"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/raynou/.lmstudio/bin"
# End of LM Studio CLI section

