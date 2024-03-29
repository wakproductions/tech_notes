# Set the ansible key file and test connections

From the directory of the project
`ansible all --key-file ~/.ssh/ansible -i inventory.ini -m ping`
or
`ansible all --key-file ~/.ssh/id_ed25519_tachi_ansible -i inventory.ini -u azureadmin -m ping`

Show the inventory
ansible-inventory -i inventory.ini --list


# Run an apt command as sudo

Equivalent to `sudo apt update`
`ansible all -m apt -a update_cache=true --become --ask-become-pass`

`--become / -b` - does `sudo`
`--ask-become-pass` - prompts for sudo password

Upgrade the distribution - equiv to `sudo apt upgrade-dist`
`ansible all -m apt -a upgrade=dist --become`