#!/bin/bash

# glob filenames case-insensitively
shopt -s nocaseglob

# append history to history file, don't overwrite.
shopt -s histappend

# fix line wrap issues
shopt -s checkwinsize

# find paths inside agares
export AGARES=${AGARES:-"$HOME/.agares"}

# blatantly steal micah's ls aliases because they make SO MUCH SENSE omg.
alias lsa='ls -a'
alias lsl='ls -a -l'
alias lsli='lsl -i' # lsl+inodes
alias l1='ls -1'
alias llm='lsl -r -t' # lsl+ sort by modified time (lastest at bottom)

# blatantly steal micah's colorized man pages
# See: http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
# see: https://github.com/mrled/dhd/blob/800544cae0cc2f4e2b85b5dafae59babf75677fe/hbase/.bashrc
man() {
    env \
        LESS_TERMCAP_md=$'\e[1;36m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[1;40;92m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[1;32m' \
            man "$@"
}

# history control variables
export HISTCONTROL=ignoreboth
export HISTSIZE="INFINITE"
export HISTFILESIZE=5000
export HISTCONTROL="ignorespace"
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "



# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

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

export PS1="\t:\[$(tput sgr0)\]\[\033[38;5;93m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;6m\][\w]:\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

tmux attach &> /dev/null

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

if [[ ! $TERM =~ screen ]]; then
    exec tmux
fi
