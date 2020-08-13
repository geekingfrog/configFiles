# only fools wouldn't do this ;-)
export EDITOR="vim"

export TERM="xterm-256color"
export XDG_CONFIG_HOME="${HOME}/.config"

# to rename multiple files at once
# http://www.mfasold.net/blog/2008/11/moving-or-renaming-multiple-files/
autoload -U zmv
alias mmv='noglob zmv -W'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias ll='ls -al --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
else # mac, apparently --color=auto is not required (and not supported)
  alias ll='ls -al'
fi


alias l='ls'
alias -g gp='| grep -E -i'
alias ,q='exit'
alias ack='ack-grep'
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias pt="curl -F c=@- https://ptpb.pw/"
alias -g uuidre=".{8}-.{4}-.{4}-.{4}-.{12}"

# some git alias
alias gst='git status -sb'

alias bower='noglob bower'

# # cat with colors (require pygmentize, a python program)
# alias ccat='pygmentize -O style=monokai -f console256 -g '

# from:
# https://unix.stackexchange.com/questions/480121/simple-command-line-calculator
# usage:  c 1+1
c() { printf "%s\n" "$*" | bc }

HISTFILE=~/.history

# search history beginning with given substring with pgup and pgdown
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

# Ignore some common commands for the history
HISTORY_IGNORE="(ls|ll|cd|pwd|z|bg|fg|history)"

# http://www.zsh.org/mla/users/2000/msg00722.html
# usage: bindtc <cap> <fallback> <zsh-command>
bindtc ()
{
  local keyval=$(echotc "$1" 2>&-)
  bindkey "${keyval:-$2}" "$3"
}

# Bindings for PGUP and PGDN
bindtc kP "^[[I" history-beginning-search-backward
bindtc kN "^[[G" history-beginning-search-forward

# # disable system beep
# if [ -s "/usr/bin/xset" ] && [ ! -z ${DISPLAY}]; then
#   /usr/bin/xset b off
# fi


# add stuff to the path

# export PATH="${HOME}/.cargo/bin:${HOME}/.local/bin:${PATH}"
pathadd "${HOME}/.cargo/bin"
pathadd "${HOME}/.local/bin"


# # fix path for pip install --user under macos
# if [ $( uname ) = "Darwin" ];
# then
#   export PYTHONUSERBASE=~/.local/
# fi
# export PATH="$PATH:$HOME/.local/bin"

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

if which stack > /dev/null 2>&1; then
  eval "$(stack --bash-completion-script stack)"
fi

# the aws plugin for oh-my-zsh looks for the aws_completer under /usr/bin
# which breaks for non sudo install of the cli
if which aws_completer > /dev/null 2>&1; then
  complete -C "$(which aws_completer)" aws
fi

# conflict with graphicsmagick
unalias gm

if [ -f /usr/share/fzf/key-bindings.zsh ]
then
  source /usr/share/fzf/key-bindings.zsh
fi

# for debian
if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]
then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

# Desktop env setup
if [ -f ~/.desktop.zsh ]
then
  source ~/.desktop.zsh
fi

export JAVA_HOME="$HOME/dev/java/java-10-oracle-linux/"

asdf_dir="${asdf_dir:-$HOME/.asdf}"

if [[ -d $asdf_dir ]]; then
  source $asdf_dir/asdf.sh
  source $asdf_dir/completions/asdf.bash
fi

if which pipenv > /dev/null 2>&1; then
  # hideous hack to prevent the completion script to call compinit
  eval "$(pipenv --completion | sed 's/autoload.*//')"
  export WORKON_HOME="${HOME}/.local/share/virtualenvs/"
fi

if which gsto > /dev/null 2>&1; then
  eval "$(gsto --bash-completion-script $(which gsto))"
fi

# Remove some more alias comming from the git plugin
unalias gg
unalias gga
unalias ggpull
unalias ggpur
unalias ggpush
unalias ggsup
