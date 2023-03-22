#!/bin/bash
shopt -s nocaseglob # glob filenames case-insensitively
shopt -s histappend # append history to history file, don't overwrite.
shopt -s checkwinsize # fix line wrap issues

# This allows for more reasonable C-w backspace behavior (stops at /s, etc)
#stty werase undef
bind '\C-w:unix-filename-rubout'

set completion-ignore-case on # ignore case when tab-completing

source ~/.paths
export VISUAL=emacsclient
export EDITOR=emacsclient

# blatantly steal micah's ls aliases because they make SO MUCH SENSE omg.
alias python="python3"
alias py="python3"
alias pip="pip3"
alias lsa='ls -a'
alias lsl='ls -a -l -F'
alias lsli='lsl -i' # lsl+inodes
alias l1='ls -1'
alias llm='lsl -r -t' # lsl+ sort by modified time (lastest at bottom)

# nixos aliases that don't matter elsewhere:
alias open=kde-open5
alias e='emacsclient'

# awesomewm xdg fixes
xdg-mime default emacsclient.desktop text/plain

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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# handle key management through `keychain` because its great
## first set up gpg agent
[ -f ~/.gpg-agent-info ] && source ~/.gpg-agent-info
if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
   export GPG_AGENT_INFO
else
   eval $( gpg-agent --daemon )
fi

## then configure keychain
eval $(keychain --eval --quiet ~/.ssh/{awful-git,github,digitalocean,home-net})
eval $(keychain --gpg2 --agents gpg)

# host specific configurations:
if [[ $(shopt login_shell | cut -f2) == "on" ]]
then
    : # this is a no op cmd in bash, i guess. GOD.

else
    if [ "$HOSTNAME" = "hoyden" ]; then
	printf 'on hoyden, applying nixOS config \n'
	setxkbmap -option "ctrl:nocaps"
	fortune ~/bin/fortunate/invisiblestates/invisiblestates | fold -w 80 -s
    else
	printf 'regular config\n'
    fi

    # this looks like garbage but its just color initation and termination
    export PS1="\t \[\e[34m\]ǰ \[\e[91m\]☭\[\e[0m\] "

    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced

    echo ""
    echo "  /'-./\_                |  $HOSTNAME"
    echo " :    ||,>               |"
    echo "  \.-'||                 |  $0"
    echo -e "\e[31m      ||    BURIED\e[0m       |"
    echo -e "\e[31m      ||        HATCHET\e[0m  |  $OSTYPE"
    echo -e "\e[31m      ||\e[0m                 |"
    echo ""
fi


