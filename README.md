# Divona

* Master: [![pipeline status](https://gitlab.com/nicolas-lamirault/divona/badges/master/pipeline.svg)](https://gitlab.com/nicolas-lamirault/divona/commits/master)

* Develop: [![pipeline status](https://gitlab.com/nicolas-lamirault/divona/badges/develop/pipeline.svg)](https://gitlab.com/nicolas-lamirault/divona/commits/develop)

Automated installation using [Ansible](https://www.ansible.com/). Supported operating system:

- [x] ArchLinux
- [x] Debian, Ubuntu
- [x] Centos
- [x] OSX
- [x] Windows.
- [x] FreeBSD
- [x] NetBSD
- [x] OpenBSD

## Tools

- Arch Linux: [pacman](https://wiki.archlinux.org/index.php/pacman)
- Debian : [apt](https://wiki.debian.org/Apt)
- Centos: [yum](http://yum.baseurl.org/)
- OSX: [homebrew](http://brew.sh/) and [Cask](https://caskroom.github.io)
- Windows: [chocolatey](https://chocolatey.org)
- FreeBSD: [pkgng](https://wiki.freebsd.org/pkgng)
- NetBSD: [pkgin](https://man.openbsd.org/pkg_add)
- OpenBSD: [pkg_add](https://man.openbsd.org/pkg_add)


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

        $ make
        ==== divona [1.1.0] ====
        apply                : Which type to apply
        clean                : Cleanup
        docker-build         : Build a Docker image
        docker-publish       : Publish the Divona image
        docker-run           : Run Ansible using a Docker image
        init                 : Install requirements
        lint                 : Check ansible style
        ping                 : Check Ansible installation

* Check ansible is working :

        $ make ping host=ansible/hosts/xxxxx

* Apply a configuration using **which**, **host** and **user** :

        $ make apply which=ansible/divona.yml host=ansible/hosts/xxxx user=yyyy

* You could increase verbosity with `DEBUG` environment variable :

        $ DEBUG="-vvvv" make default host=ansible/hosts/xxxx user=yyyy

## Development

It's possible to test the `ansible` playbooks using `docker` or `vagrant`.

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
