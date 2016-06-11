# Divona #

[![License Apache 2][badge-license]](LICENSE)
[![GitHub version](https://badge.fury.io/gh/nlamirault%2Fdivona.svg)](https://badge.fury.io/gh/nlamirault%2Fdivona)

Master :
* [![Circle CI](https://circleci.com/gh/nlamirault/divona/tree/master.svg?style=svg)](https://circleci.com/gh/nlamirault/divona/tree/master)

Develop :
* [![Circle CI](https://circleci.com/gh/nlamirault/divona/tree/develop.svg?style=svg)](https://circleci.com/gh/nlamirault/divona/tree/develop)

Development environment configuration for Linux.

## Requirements

* Ansible
* Git


## Configuration

Check Ansible is working :

    $  ansible -c local -m ping all -i ansible/hosts/local_arch


## Installation

    $ git clone https://github.com/nlamirault/divona.git


## Configuration

    $ sudo ansible-playbook -c local -i ansible/hosts/local_arch ansible/divona.yml --extra-vars="user=nicolas"


## Changelog

A changelog is available [here](ChangeLog.md).


## Contact

Nicolas Lamirault <nicolas.lamirault@gmail.com>
