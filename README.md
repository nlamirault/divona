# Divona 

[![wercker status](https://app.wercker.com/status/c7d97c1954dfa32673abfcc7dae1ffc9 "wercker status")](https://app.wercker.com/project/bykey/c7d97c1954dfa32673abfcc7dae1ffc9)
[![Build Status](https://drone.io/github.com/nlamirault/divona/status.png)](https://drone.io/github.com/nlamirault/divona/latest)

Development environment configuration for Linux.

## Requirements

* Ansible
* Git


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

## Changelog

A changelog is available [here](ChangeLog.md).

## Contact

Nicolas Lamirault <nicolas.lamirault@gmail.com>
