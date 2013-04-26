# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

#use traditionnal byte order for sort operations
# if [[ -z $LC_ALL ]]
# then
#   export LC_ALL=C
# fi

#add support to display utf8 in the terminal
if [[ -z $LC_ALL ]]
then
  export LC_ALL=en_US.UTF-8
fi



# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi


EDITOR=vim
export SVN_EDITOR=vim

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

    ;;
*)
    ;;
esac

TRAILING_IP=$(ifconfig | grep addr: | head -n 1 | cut -c 31-33)
PROMPT_COMMAND='echo -ne "\033]0;$TRAILING_IP|${HOSTNAME}: ${PWD/$HOME/~}\007"'

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"



# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -F'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


if [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
fi


#ibus problem
export XIM_PROGRAM=/usr/bin/ibus-daemon


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


# set up JAVA_HOME variable
JAVA_HOME=/usr/lib/jvm/default-java
export JAVA_HOME
PATH=$PATH:$JAVA_HOME/bin:
export PATH
CLASSPATH=$JAVA_HOME/lib/:.
export CLASSPATH

# add some wine program to the path
PATH=$PATH:$HOME/.wine/drive_c/Program\ Files/Tracker\ Software/PDF\ Viewer


#set up oracle 11xe environment variables
#. /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh


#got from : https://wiki.ubuntu.com/Spec/EnhancedBash
#Make sure all terminals save history
#shopt -s histappend
#PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
#Increase history size
#export HISTSIZE=1000
#export HISTFILESIZE=1000
#Use GREP color features by default
export GREP_OPTIONS='--color=auto'


#define some more verbose variable for the colors
TXTBLACK="\[\033[30m\]"
TXTRED="\[\033[31m\]"
TXTGREEN="\[\033[32m\]"
TXTORANGE="\[\033[33m\]"
TXTBLUE="\[\033[34m\]"
TXTMAGENTA="\[\033[35m\]"
TXTCYAN="\[\033[36m\]"
TXTWHITE="\[\033[37m\]"

BGBLACK="\[\033[40m\]"
BGRED="\[\033[41m\]"
BGGREEN="\[\033[42m\]"
BGORANGE="\[\033[43m\]"
BGBLUE="\[\033[44m\]"
BGMAGENTA="\[\033[45m\]"
BGCYAN="\[\033[46m\]"
BGWHITE="\[\033[47m\]"

BOLD="\[\033[01m\]"
UNDERLINE="\[\033[04m\]"
BLINK="\[\033[05m\]"
OVERLINE="\[\033[07m\]"

RESETSTYLE="\[\033[00m\]"


if [ "`id -u`" -eq 0 ]; then
#I'm root

PS1="\
${TXTCYAN}<\
${TXTGREEN}\
\A\
${TXTCYAN}>\
[${TXTRED}\
\u\
${RESETSTYLE}\
@\
${TXTRED}\h\
${RESETSTYLE}:\w\
${TXTCYAN}]${RESETSTYLE}#"

else

PS1="\
${TXTCYAN}<\
${TXTGREEN}\
\A\
${TXTCYAN}>\
[${TXTORANGE}\
\u\
${RESETSTYLE}\
@\
${TXTGREEN}\h\
${RESETSTYLE}:\w\
${TXTCYAN}]${RESETSTYLE}$"

fi

umask 002

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

#for jsctags tool
export NODE_PATH=/usr/local/lib/jsctags/:$NODE_PATH

export PERL_LOCAL_LIB_ROOT="/home/greg/perl5";
export PERL_MB_OPT="--install_base /home/greg/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/greg/perl5";
export PERL5LIB="/home/greg/perl5/lib/perl5/x86_64-linux-gnu-thread-multi:/home/greg/perl5/lib/perl5";
export PATH="/home/greg/perl5/bin:$PATH";




