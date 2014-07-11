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
echo "Check local host"
ansible -c local -m ping all -i ansible/hosts/$2

echo "Configure"
ansible-playbook -i ansible/hosts/$2 ansible/divona.yml --extra-vars="user=$1"
