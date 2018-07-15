import os
import sys
import argparse
import subprocess
import pdb

# brew cask install powershell
# Install brew if we don't have it

installBrew = [
    """ if test ! $(which brew); then
        echo "Installing homebrew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi """
]

subprocess.run(installBrew)
subprocess.run('brew update')
subprocess.run('brew tap caskroom/cask')

macPrograms = [
    "powershell",
    "git",
    "vscode",
    "emacs64",
    "python2",
    "python3",
    "docker",
    "slack",
    "discord",
    "keybase",
    "spotify",
    "1password",
    "firefox",
    "dropbox",
    "conemu",
    "virtualbox"
]
subprocess.run('brew install ' + macPrograms)