import os
import sys
import argparse
import subprocess
import pdb

add_Repos_Args = [
    "sudo",
    "add-apt-repository",
    "ppa:nextcloud-devs/client"
]

download_Powershell_Keys = [
    "wget",
    "-q",
    "https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb"
]

add_Powershell_Keys = [
    "sudo",
    "dpkg",
    "-i",
    "packages-microsoft-prod.deb"
]

update_Apt_Repos = [
    "sudo",
    "apt",
    "update"
]

add_Apt_Programs = [
    "sudo",
    "apt-get",
    "install",
    "-y",
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

print("adding repos")
subprocess.run(add_Repos_Args,shell=True)

print("download powershell key")
subprocess.run(download_Powershell_Keys)

print("add powershell key")
subprocess.run(add_Powershell_Keys)

print("updating apt")
subprocess.run(update_Apt_Repos)

print("installing apt packages")
subprocess.run(add_Apt_Programs)

#print("installing snap packages")
#subprocess.run('sudo snap install ' + snapProgramsToAdd)

# post processing for firefox userChrome.css
# cp userChrome.css to the profile directory > chrome > userChrome.css
create_Firefox_Chrome_Folder = [
    "mkdir",
    "-p",
    "~/.mozilla/firefox/*.default/chrome/"
]

configure_Firefox = [
    "cp"
    "~/Documents/projects/agares/applicationConfiguration/firefox/userChrome.css",
    "~/.mozilla/firefox/*.default/chrome/userChrome.css"
]

subprocess.run(create_Firefox_Chrome_Folder)
subprocess.run(configure_Firefox)
