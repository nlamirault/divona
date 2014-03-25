#!/bin/bash

if [ $# -ne 2 ]
then
    echo "$0 <username> <hosts>"
    exit 1
fi

DIVONA_HOME=`pwd`
echo "--------------------------------------"
echo "----- Configuration with Ansible -----"
echo "--------------------------------------"
#cd ansible
echo "Check valid hosts"
ansible -c local -m ping all -i ansible/ansible_hosts

echo "Configure"
sudo ansible-playbook -c local -i $2 ansible/setup.yml --extra-vars="user=$1"
