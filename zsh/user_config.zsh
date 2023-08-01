source $ZSH/oh-my-zsh.sh
source "$HOME/p10k-lean.zsh"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='lvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


if command -v rga &> /dev/null && command -v fzf &> /dev/null
then
  rga-fzf() {
    RG_PREFIX="rga --files-with-matches"
    local file
    file="$(
      FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
        fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
          --phony -q "$1" \
          --bind "change:reload:$RG_PREFIX {q}" \
          --preview-window="70%:wrap"
    )" &&
    echo "opening $file" &&
    xdg-open "$file"
  }
fi
