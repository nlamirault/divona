# Divona #

Master :
* [![Circle CI](https://circleci.com/gh/nlamirault/divona/tree/master.svg?style=svg)](https://circleci.com/gh/nlamirault/divona/tree/master)

Develop :
* [![Circle CI](https://circleci.com/gh/nlamirault/divona/tree/develop.svg?style=svg)](https://circleci.com/gh/nlamirault/divona/tree/develop)

Automated installation using [Ansible](https://www.ansible.com/). Supported operating system:

- [x] ArchLinux
- [x] Debian based
- [x] Centos
- [x] OSX
- [x] Windows.
- [x] FreeBSD
- [x] NetBSD
- [x] OpenBSD

## Tools

- Archlinux: [pacman](https://wiki.archlinux.org/index.php/pacman)
- Debian : [apt](https://wiki.debian.org/Apt)
- Centos: [yum](http://yum.baseurl.org/)
- OSX: [homebrew](http://brew.sh/) and [Cask](https://caskroom.github.io)
- Windows: [chocolatey](https://chocolatey.org)
- FreeBSD: [pkgng](https://wiki.freebsd.org/pkgng)
- NetBSD: [pkgin](https://man.openbsd.org/pkg_add)
- OpenBSD: [pkg_add](https://man.openbsd.org/pkg_add)


## Installation

### Linux

* Clone repository and install Pip:

        $ git clone https://github.com/nlamirault/divona.git
        $ python get-pip.py

* Install Ansible:

        $ pip install ansible

### OSX

* Clone repository and install Pip:

        $ git clone https://github.com/nlamirault/divona.git
        $ python get-pip.py

* Install Ansible:

        $ pip install ansible

* Install homebrew:

        $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


### Windows

    UNKNOWN


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



## Development

It's possible to test the `Ansible` playbooks using `docker` or `vagrant`.

### Docker

Build the image :

    $ make docker-build image=jessie (or arch, ...)

Run the playbooks :

    $ make docker-run image=jessie (or arch, ...)

### Vagrant




## Changelog

A changelog is available [here](ChangeLog.md).


## Contact

Nicolas Lamirault <nicolas.lamirault@gmail.com>
