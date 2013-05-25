# only fools wouldn't do this ;-)
export EDITOR="vim"


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


alias l='ls'
alias ll='ls -al --color=auto'
alias -g gp='| grep -i'



# open with
alias -s coffee=vim
alias -s css=vim
alias -s scss=vim

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
bindtc kh "^[[H" beginning-of-line
bindtc kH "^[[F" end-of-line
