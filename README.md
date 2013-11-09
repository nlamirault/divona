Divona
======

Development environment configuration for Linux.

Configuration
-------------

Check Ansible is working :

    $  ansible -c local -m ping all -i ansible_hosts

Installation
------------

    $ sudo ansible-playbook -c local -i ansible_hosts setup.yml --extra-vars="user=nicolas"


BUG
---


Contact
-------

Nicolas Lamirault <nicolas.lamirault@gmail.com>
