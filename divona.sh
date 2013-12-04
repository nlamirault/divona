#!/bin/bash
# -*- coding: UTF8 -*-

if [ $# -ne 1 ]
then
    echo "$0 <username>"
    exit 1
fi

DIVONA_HOME=`pwd`
echo "--------------------------------------"
echo "----- Configuration with Ansible -----"
echo "--------------------------------------"
cd ansible
echo "Check valid hosts"
ansible -c local -m ping all -i ansible_hosts

echo "Configure"
sudo ansible-playbook -c local -i ansible_hosts setup.yml --extra-vars="user=$1"
