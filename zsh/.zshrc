# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
unsetopt beep nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/Raynou/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# The following lines were added by the user
alias ls='ls --color=auto'
alias grep='grep --color=auto'
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# Load my mouse profile
CONF_FILE="$HOME/.config/mouse_profile.conf"
if [ -f CONF_FILE ]; then
  PROFILE="$(<"$CONF_FILE")"
  DEV="$(ratbagctl list | awk -F: 'NF{print $1; exit}')"
  ratbagctl "$DEV" profile active set "$PROFILE"
fi

# Custom variable
export WORKSPACE='~/workspace'
# Exports REPOS='$WORKSPACE/repositories' fix this
export REPOS='~/workspace/repositories'
# Opens in tmux popup if on tmux, otherwise use --height mode
export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border top'
# Sets default editor as neovim
export VISUAL=nvim
# Loads bin folder to path
export PATH="$HOME/bin:$PATH"

# Custom functions

function join_container() {
    name="$(docker ps --format '{{.Names}}' |\
    awk '{print $1}' |\
    fzf)"
    docker exec -it $name /bin/bash
}

function start_container() {
    while getopts "a" opt; do
        case $opt in
          a) ATTACHED=true;;
        esac
    done
    name="$(docker ps -a --format '{{.Status}}:{{.Names}}'|\
    awk -F ':' '{ if($1 ~ "^Exited") print $2 }' |\
    fzf)"
    if [ "${ATTACHED}" == true ]; then
        docker start -a "${name}"
    else
        docker start "${name}"
    fi
}

# Aliases
alias ..='cd ..'
alias v='nvim'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias ls='lsd'
alias ll='lsd -la'
alias t='tree'
alias td='tree -d'
alias dotfiles='git --git-dir=${HOME}/.dotfiles/ --work-tree=$HOME'
alias jc='join_container'
alias sc='start_container'
alias c='code'
alias f='ranger'
alias icat='kitten icat'

# Start ssh-agent
# eval "$(ssh-agent -s)" # Disable because is unsafe use it

# Starship
eval "$(starship init zsh)"
# End of the lines added by the user

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
