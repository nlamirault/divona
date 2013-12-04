#!/bin/bash
# -*- coding: UTF8 -*-

DIVONA_HOME=`pwd`
echo "--------------------------------------"
echo "----- Configuration with Ansible -----"
echo "--------------------------------------"
ansible -c local -m ping all -i ansible_hosts
