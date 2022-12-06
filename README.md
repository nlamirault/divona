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

## Usage

```shell
❯  make
                  D I V O N A
------------------------------------------------------------------

Usage: make <target>

Development
  clean                      Cleanup
  validate                   Execute git-hooks
  license                    Check license (ACTION=xxx : fix or check)

Ansible
  ansible-init               Bootstrap Ansible
  ansible-deps               Install dependencies
  ansible-ping               Check Ansible installation (ENV=xxx)
  ansible-debug              Retrieve informations from hosts (ENV=xxx)
  ansible-run                Execute Ansible playbook (ENV=xxx)
  ansible-dryrun             Execute Ansible playbook (ENV=xxx)
```

## Linux

### Ansible

Install Ansible using pip or your package manager. For Archlinux:

```shell
pacman -Sy ansible
```

### Setup Linux Workstation

```shell
make ansible-run ENV=linux
```

## OSX

### Install homebrew

See http://brew.sh/

```shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Install ansible

```shell
brew install git python ansible
```

### Setup OSX Workstation

```shell
make ansible-run ENV=mac
```

## Windows

`TODO`

## Contact

Nicolas Lamirault <nicolas.lamirault@gmail.com>
