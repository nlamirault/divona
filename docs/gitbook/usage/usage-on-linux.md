# Divona for Linux

This guide walks you through setting up Divona on a Linux workstation

## Prerequisites

Divona requires [Ansible](https://www.ansible.com) **v2.7.0** or newer.

```bash
$ test -d venv || python3 -m venv venv
$ . venv/bin/activate
$ pip3 install ansible==2.7.6
```

Next, clone the repository:

```bash
$ git clone https://github.com/nlamirault/divona.git
```

Configure your hosts using the **inventory** files (in the directory *inventory*)

Example:

```text
[linux]
192.168.1.27 ansible_python_interpreter=/usr/bin/python3     ansible_user=nlamirault

[linux:vars]
user=nicolas

[osx]
192.168.1.18    ansible_user=nicolas

[osx:vars]
user=nicolas
```

Then you can check connection:

```bash
$ make ping host=inventory/hosts
[divona] Check ansible
192.168.1.27 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
192.168.1.18 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

## Usage

**Divona** defines 2 configurations:

* base: configure system, directories, window managers, multimedia, music, ...
* devops: cloud tools, ...

Example:

```bash
$ make setup-local host=inventory/local_arch tags=base
```
