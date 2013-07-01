#!/bin/bash
#
# Title           : movies.sh
# Version         : 0.1.0
# Copyright       : Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# ------------------------------------------------------

#
# v0.1.0 - 06/29/2013
# - Move and renames movie files
# - Init script.
#


IFS="
"

#movies=`find . -type f -a -name "*.avi"`
#for movie in $movies
#do
#    mv $movie .
#done

movies=`find . -type f -a -name "*.avi"`
for movie in $movies
do
    echo "Movie:  $movie"
    dest=`basename $movie|sed -e "s/\[www.Cpasbien.me\] //g" -e "s/\FRENCH\.LD\HDTV\.XvidD//g" -e "s/^ //g"`
    echo $dest
    mv $movie $dest
done
