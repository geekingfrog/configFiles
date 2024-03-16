export EDITOR="lvim"

export TERM="xterm-256color"
export XDG_CONFIG_HOME="${HOME}/.config"

# -X leaves file contents on the screen when less exits
# -F makes less quit if the entire output can be displayed on one screen
# -R display ANSI color escape sequences in raw form
# -S disable line wrapping
export LESS="-XFRS"

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
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias -g uuidre=".{8}-.{4}-.{4}-.{4}-.{12}"

# some git alias
alias gst='git status -sb'

# # cat with colors (require pygmentize, a python program)
# alias ccat='pygmentize -O style=monokai -f console256 -g '

# from:
# https://unix.stackexchange.com/questions/480121/simple-command-line-calculator
# usage:  c 1+1
c() { printf "%s\n" "$*" | bc }

# share history between shells
setopt share_history

HISTFILE=~/.history
HISTSIZE=50000
SAVEHIST=50000

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

bindkey  backward-kill-line

# # disable system beep
# if [ -s "/usr/bin/xset" ] && [ ! -z ${DISPLAY}]; then
#   /usr/bin/xset b off
# fi


# add stuff to the path
pathadd "${HOME}/.local/bin"


# don't install npm module globally
# see https://stackoverflow.com/questions/10081293/install-npm-into-home-directory-with-distribution-nodejs-package-ubuntu
NPM_PACKAGES="$HOME/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
pathadd "${NPM_PACKAGES}/bin"

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

# disable pager for aws cli
export AWS_PAGER=""


if which pipx > /dev/null 2>&1; then
  eval "$(register-python-argcomplete pipx)"
fi


# conflict with graphicsmagick
unalias gm

# Desktop env setup
if [ -f ~/.desktop.zsh ]
then
  source ~/.desktop.zsh
fi

# asdf_dir="${asdf_dir:-$HOME/.asdf}"
#
# if [[ -d $asdf_dir ]]; then
#   source $asdf_dir/asdf.sh
#   source $asdf_dir/completions/asdf.bash
# fi

if [[ ! -e "${ZSH_CUSTOM}/plugins/pipenv/_pipenv" ]];
then
  if which pipenv > /dev/null 2>&1; then
    mkdir -p "${ZSH_CUSTOM}/plugins/pipenv"
    pipenv --completion > "${ZSH_CUSTOM}/plugins/pipenv/_pipenv"
  fi
fi


if [[ ! -e "${ZSH_CUSTOM}/plugins/poetry/_poetry" ]];
then
  if which poetry > /dev/null 2>&1; then
    mkdir -p "${ZSH_CUSTOM}/plugins/poetry"
    poetry completions zsh > "${ZSH_CUSTOM}/plugins/poetry/_poetry"
  fi
fi

# Remove some more alias comming from the git plugin
unalias gg
unalias gga
unalias ggpull
unalias ggpur
unalias ggpush
unalias ggsup


# setup ctrl-n to use fzf for tab completion
# the repo is cloned as a submodule of the config file repo
source ~/configFiles/fzf-tab-completion/zsh/fzf-zsh-completion.sh
bindkey '^N' fzf_completion
# restore the original <tab> completion overriden by the previous lines
bindkey '^I' expand-or-complete

# smarter cd if on the path:
if which zoxide > /dev/null 2>&1; then
  # must be done after compinit
  eval "$(zoxide init zsh)"
fi

if which fd > /dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND="fd --type f"
fi

# # Map CTRL-Q to fzf-style completion based on a cache file
# # This file is generated by a bash script living alongside this file
# # (refresh-aws-cache.sh)
# omnifzf="${ZSH_CUSTOM}/omnifzf.zsh"
# if [[ -e "$omnifzf" ]];
# then
#   source "$omnifzf"
# fi
# unset omnifzf

# alias docker=podman

# make bat theme match the terminal colors
# to list all themes: bat --lith-themes
export BAT_THEME="gruvbox-light"


# with a light colorscheme, jq uses a color for `null` which makes it invisible
# Fix this through env var, according to:
# https://unix.stackexchange.com/questions/485145/jq-colorize-selected-field-of-json-file
# the default is
# JQ_COLORS=1;30:0;39:0;39:0;39:0;32:1;39:1;39
export JQ_COLORS="1;39:0;39:0;39:0;39:0;32:1;39:1;39"

alias cal='cal -m'

# adding vim-iced script for clojure repl
export PATH="$PATH:/home/greg/.local/share/lunarvim/site/pack/lazy/opt/vim-iced/bin"

gimmeasdf() {
  source "$HOME/.asdf/asdf.sh"
  # append completions to fpath
  fpath=(${ASDF_DIR}/completions $fpath)
  # initialise completions with ZSH's compinit
  autoload -Uz compinit && compinit
}

# perl config, automatically generated by cpan config tool
PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
