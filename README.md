# Divona #

Master :
* [![Circle CI](https://circleci.com/gh/nlamirault/divona/tree/master.svg?style=svg)](https://circleci.com/gh/nlamirault/divona/tree/master)

Develop :
* [![Circle CI](https://circleci.com/gh/nlamirault/divona/tree/develop.svg?style=svg)](https://circleci.com/gh/nlamirault/divona/tree/develop)

Automated installation using [Ansible](https://www.ansible.com/). Support Linux, OSX and Windows.

## Requirements

* Ansible
* Git

Tools:
- Linux: we use distribution packaging ([apt](https://wiki.debian.org/Apt) or [pacman](https://wiki.archlinux.org/index.php/pacman))
- OSX: [homebrew](http://brew.sh/)
- Windows: [chocolatey](https://chocolatey.org)


## Installation

    $ git clone https://github.com/nlamirault/divona.git


## Usage

* Help:

        $ make
        ==== divona [1.0.0] ====
        clean                : Cleanup
        default              : Default environment
        dev                  : Development environment
        init                 : Install requirements
        iot                  : Internet Of Things
        ping                 : Check Ansible installation

* Check Ansible is working :

        $ make ping host=ansible/hosts/xxxxx

* Configure the default environment:

        $ make default host=ansible/hosts/xxxx user=yyyy

* Configure the development environment:

        $ make dev host=ansible/hosts/xxxx user=yyyy

* Configure the Internet of Things environment:

        $ make iot host=ansible/hosts/xxxx user=yyyy


## Changelog

A changelog is available [here](ChangeLog.md).


## Contact

Nicolas Lamirault <nicolas.lamirault@gmail.com>
