set completion-ignore-case on # ignore case when tab-completing

# find paths inside agares
export AGARES=${AGARES:-"$HOME/.agares"}

# update paths with installed executables:
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/share/python:$PATH
export PATH=/Users/jowj/Library/Python/3.6/bin:$PATH
export PATH=/home/josiah/.local/bin:$PATH
export PATH=/home/josiah/.gem/ruby/2.6.0/bin:$PATH

# blatantly steal micah's ls aliases because they make SO MUCH SENSE omg.
alias python="python3"
alias py="python3"
alias pip="pip3"
alias lsa='ls -a'
alias lsl='ls -a -l'
alias lsli='lsl -i' # lsl+inodes
alias l1='ls -1'

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

# emacs aliases lol
alias social="/Applications/Emacs.app/Contents/MacOS/Emacs -q -l '~/.emacs.d/init-social.el'"

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
# Configure history! Ref:  https://martinheinz.dev/blog/110
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*" # this works
HIST_STAMPS="yyyy-mm-dd"

# setopt EXTENDED_HISTORY      # Write the history file in the ':start:elapsed;command' format. also, this appears to do nothing?
setopt INC_APPEND_HISTORY    # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY         # Share history between all sessions.
setopt HIST_IGNORE_DUPS      # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS  # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE     # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS     # Do not write a duplicate event to the history file.
setopt HIST_VERIFY           # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY        # append to history file (Default)
setopt HIST_NO_STORE         # Don't store history commands
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from each command line being added to the history.

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

# this looks like garbage but its just color initation and termination
PROMPT='%F{green} ǰ %F{red}☭ %f '
# PROMPT='%F{green}%n%f@%F{magenta}%m%f %F{blue}%B%~%b%f %# '
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

if [ -e /Users/josiah.ledbetter/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/josiah.ledbetter/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export PATH="$HOME/.poetry/bin:$PATH"

autoload -Uz compinit
compinit

