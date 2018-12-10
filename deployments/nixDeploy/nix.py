import os
import sys
import argparse
import subprocess
import pdb

reposToAdd = "ppa:nextcloud-devs/client"

aptProgramsToAdd = [
    "powershell",
    "emacs",
    "python3.7",
    "firefox",
    "dropbox",
    "docker",
    "nextcloud-client"
] 
snapProgramsToAdd = [
    "slack",
    "discord",
]

subprocess.run('sudo apt add-repo ' + reposToAdd)
print("adding repos")

subprocess.run('sudo apt update')
print("updating apt")

subprocess.run('sudo apt-get install ' + aptProgramsToAdd)
print("installing apt packages")

subprocess.run('sudo snap install ' + snapProgramsToAdd)
print("installing snap packages")

