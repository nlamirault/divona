#!/bin/bash
# -*- coding: UTF8 -*-
#
# Unmount Android phone using go-mtpfs :
# 
# $ sudo add-apt-repository ppa:webupd8team/unstable
# $ sudo apt-get update
# $ sudo apt-get install go-mtpfs
#


echo "Unmount Android phone"
fusermount -u /media/MyAndroid

