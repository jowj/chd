# agares
### agares was a demon who taught those who summoned him foreign languages, but only vulgar words. it must be true because i read it on the internet

## purpose:
automate syncing and configuration of machines in my inventory so that i don't have config drift

## subprojects:
* sync powershell $profile and automate updates
* windows device config:
    * automatically deploy and configure software that i use everywhere (password managers, sync services, text editors, etc)
    * set windows settings to be actually useable
    * set windows privacy settings
    * remove bloatware
* sync emacs config
* sync keyboard config for infinity ergodox

### deployments
i currently am setting all my deployments to live within agares. i use agares as a submodule within my colove project in order to fascilitate deploys from within a container. this allows me to accomplish a few things that are important to my workflow, but are likely not super important to a lot of other people.

#### mojobot
ansible-playbook -i hosts.yml mojo.yml --ask-vault-pass (pass in ansible vault pw)
- if you end up wanting to deploy this somewhere you'll need to update the hosts.yml file to include your targets
- the ansible-vault file includes my slackbot token. You'll need to update that.
