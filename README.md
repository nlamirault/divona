# Divona

![divona](logo.png)

* Master: [![pipeline status](https://gitlab.com/nicolas-lamirault/divona/badges/master/pipeline.svg)](https://gitlab.com/nicolas-lamirault/divona/commits/master)

* Develop: [![pipeline status](https://gitlab.com/nicolas-lamirault/divona/badges/develop/pipeline.svg)](https://gitlab.com/nicolas-lamirault/divona/commits/develop)

Automated installation. Tools supported:

* [x] [Ansible](https://www.ansible.com).

Supported operating system:

* [x] Arch Linux: [pacman](https://wiki.archlinux.org/index.php/pacman)
* [x] Debian : [apt](https://wiki.debian.org/Apt)
* [x] Centos: [yum](http://yum.baseurl.org/)
* [x] OSX: [homebrew](http://brew.sh/) and [Cask](https://caskroom.github.io)
* [x] Windows: [chocolatey](https://chocolatey.org)
* [x] FreeBSD: [pkgng](https://wiki.freebsd.org/pkgng)
* [x] NetBSD: [pkgin](https://man.openbsd.org/pkg_add)
* [x] OpenBSD: [pkg_add](https://man.openbsd.org/pkg_add)


## Installation

### Linux

* Clone repository and install `pip`:

        $ git clone https://github.com/nlamirault/divona.git
        $ python get-pip.py

* Install `ansible`:

        $ sudo pip install ansible==2.4.0.0
        $ sudo pip install ansible-lint==3.4.17

### OSX

* Clone repository and install `pip`:

        $ git clone https://github.com/nlamirault/divona.git
        $ python get-pip.py

* Install `ansible`:

        $ sudo pip install ansible==2.4.0.0
        $ sudo pip install ansible-lint==3.4.17

* Install `homebrew`:

        $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## Usage

* Help:

        $ ==== divona [2.0.0] ====
        apply                : Which type to apply
        clean                : Cleanup
        docker-build         : Build a Docker image
        docker-debug         : Run a bash from a Docker image
        docker-publish       : Publish the Divona image
        docker-run           : Run Ansible using a Docker image
        init                 : Install requirements
        lint                 : Check ansible style
        ping                 : Check Ansible installation


### Ansible

Help:

        $ make
        ==== divona [2.0.0] ====
        clean                : Cleanup
        docker-build         : Build a Docker image (image=xxx)
        docker-debug         : Run a bash from a Docker image (image=xxx)
        docker-publish       : Publish the Divona image (image=xxx)
        docker-run           : Run Ansible using a Docker image (image=xxx playbook=xxx)
        init                 : Install requirements
        lint                 : Check ansible style
        ping                 : Check Ansible installation (host=xxx)
        setup-local          : Setup using Ansible (host=xxx user=yyyy tags=xxx,xx,xx)
        setup                : Setup using Ansible (host=xxx user=yyyy tags=xxx,xx,xx)


* Check ansible is working :

        $ make ping host=inventory/xxxxx

* Apply a configuration:

        $ make setup-local host=inventory/local_arch user=nlamirault tags=base

* You could increase verbosity with `DEBUG` environment variable :

        $ DEBUG="-vvvv" make setup-local host=inventory/local_arch user=nlamirault tags=base


## Development

It's possible to test the `ansible` playbooks using `docker` or `vagrant`.

### Molecule

* Setup Molecule:

        $ python3 -m venv venv
        $ source venv/bin/activate
        $ pip3 install molecule docker-py pytest==3.9.3

* Execute all tasks:

        $ molecule test

Or :

* Check yaml syntax: `molecule lint`
* Check ansible syntax: `molecule syntax`
* Create docker instance: `molecule create`
* Execute the playbook: `molecule converge`
* Execute unit tests: `molecule verify`

### Docker

Build the image :

    $ make docker-build image=debian (or arch, ...)

Run the playbooks :

    $ make docker-run playbook=divona.yml image=debian (or arch, ...)

### Vagrant

* [Arch Linux](vms/ArchLinux)
* [Ubuntu](vms/Ubuntu)
* [CentOS](vms/CentOS)
* [FreeBSD](vms/FreeBSD)
* [OpenBSD](vms/OpenBSD)
* [NetBSD](vms/NetBSD)
* [OSX](vms/OSX)
* [Windows](vms/Windows)


## Changelog

A changelog is available [here](ChangeLog.md).


## Contact

Nicolas Lamirault <nicolas.lamirault@gmail.com>


[Ansible]: http://www.ansible.com
[Git]: http://git-scm.com
