Role Name
=========

Playbook to bootstrap wg vpn for my personal use

Requirements
------------

this playbook doesn't handle /creating the machines/. they have to be online and accessible either in my home network or in my cloud setup.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

I don't know what to put here because i don't understand how roles work lmao
	`ansible-playbook -i ../hosts.yml tasks/main.yml -v`
		 
useful for generating mobile device configs: qrencode -t ansiutf8 < /etc/wireguard/mobile.conf

License
-------

BSD

Author Information
------------------

email: me@jowj.net