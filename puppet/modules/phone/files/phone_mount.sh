#!/bin/bash
# -*- coding: UTF8 -*-
#
# Mount Android phone using go-mtpfs :
# 
# $ sudo add-apt-repository ppa:webupd8team/unstable
# $ sudo apt-get update
# $ sudo apt-get install go-mtpfs
#


echo "Mount Android phone"
go-mtpfs /media/MyAndroid

