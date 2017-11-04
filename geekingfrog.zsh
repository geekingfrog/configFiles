# only fools wouldn't do this ;-)
export EDITOR="vim"

export TERM="xterm-256color"

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

# some git alias
alias gst='git status -sb'

alias bower='noglob bower'

# cat with colors (require pygmentize, a python program)
alias ccat='pygmentize -O style=monokai -f console256 -g '

# open with
alias -s coffee=vim
alias -s css=vim
alias -s scss=vim

# images are opened with eye of gnome
alias -s png=eog
alias -s jpg=eog

# faster todo
# export PATH=$PATH:~/bin:~/bin/todotxt:~/.local/bin
alias todo='~/bin/todotxt/todo.sh'
alias t='~/bin/todotxt/todo.sh'

# history setup
# HISTSIZE=1000
# SAVEHIST=1000
HISTFILE=~/.history

# search history beginning with given substring with pgup and pgdown
# [[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
# [[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

# http://www.zsh.org/mla/users/2000/msg00722.html
# usage: bindtc <cap> <fallback> <zsh-command>
bindtc ()
{
	local keyval=$(echotc "$1" 2>&-)
	bindkey "${keyval:-$2}" "$3"
}

# Bindings for PGUP, PGDN, HOME, END
bindtc kP "^[[I" history-beginning-search-backward
bindtc kN "^[[G" history-beginning-search-forward
# bindtc kh "^[[H" beginning-of-line
# bindtc kH "^[[F" end-of-line

# disable system beep
[[ -s "/usr/bin/xset" ]] && /usr/bin/xset b off

# load nvm
# [[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh"

if type firefox-developer > /dev/null; then
  alias firefox='firefox-developer'
fi

if type ss >/dev/null; then
  SSH_AUTH_SOCK=`ss -xl | grep -o '/run/user/1000/keyring.*/ssh'`
  [ -z "$SSH_AUTH_SOCK" ] && SSH_AUTH_SOCK=`ss -xl | grep -o '/tmp/keyring-.*/ssh'`
  [ -z "$SSH_AUTH_SOCK" ] && SSH_AUTH_SOCK=`ss -xl | grep -o '/run/user/greg/keyring.*/ssh'`
  [ -z "$SSH_AUTH_SOCK" ] || export SSH_AUTH_SOCK
fi

# add stuff to the path

# # rvm
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# export PATH=$PATH:~/bin:~/.local/bin

# export PATH=$PATH:/home/greg/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/greg/.rvm/bin

# fix path for pip install --user under macos
if [ $( uname ) = "Darwin" ];
then
  export PYTHONUSERBASE=~/.local/
fi
# export PATH="$PATH:$HOME/.local/bin"

if which stack > /dev/null 2>&1; then
  eval "$(stack --bash-completion-script stack)"
fi

# conflict with graphicsmagick
unalias gm

# disable cowsay with ansible
export ANSIBLE_NOCOWS=1

if [ -f /usr/share/fzf/key-bindings.zsh ]
then
  source /usr/share/fzf/key-bindings.zsh
fi

# Youview dev env setup
if [ -f ~/.youview.zsh ]
then
  source ~/.youview.zsh
fi
