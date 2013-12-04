# Divona 

[![Build Status](https://travis-ci.org/nlamirault/divona.png)](https://travis-ci.org/nlamirault/divona)

Development environment configuration for Linux.

## Configuration

Check Ansible is working :

    $  ansible -c local -m ping all -i ansible_hosts

## Installation

* From Git:

        $ git clone https://github.com/nlamirault/divona.git

* From Ubuntu using [PPA](https://launchpad.net/~nlamirault/+archive/divona):

        $ sudo add-apt-repository ppa:nlamirault/divona
		$ sudo apt-get update
		$ sudo apt-get install divona

## Configuration

    $ sudo ansible-playbook -c local -i ansible_hosts setup.yml --extra-vars="user=nicolas"


## BUG


## Contact

Nicolas Lamirault <nicolas.lamirault@gmail.com>
