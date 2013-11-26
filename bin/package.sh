#!/bin/bash
#
# Build Debian package for PPA : nlamirault/divona
# Copyright (c) Nicolas Lamirault <nicolas.lamirault@gmail.com>
# --------------------------------------------------------------

#!/bin/bash

git_version() {
    pushd ./ > /dev/null
    cd $1
    local tag=`git tag |tail -n 1`
    echo ${tag#*-}
    popd > /dev/null
}

current="`pwd`"
SOURCE_DIR=$current
VERSION=`git_version $SOURCE_DIR`
CODENAME=`lsb_release -cs`
KEY=`gpg --list-key|sed -n -r -e 's/^pub   [A-Z,0-9]{5}\/([A-Z,0-9]{8}).*/\1/p'|head -n 1`

usage() {
    echo "Usage: `basename $0` [-v $VERSION] [-i] [-c $CODENAME]"
    printf "\t -v : Upstream version\n"
    printf "\t -i : Index version\n"
    printf "\t -c : Distribution's codename [ raring | quantal | precise | lucid ]\n"
    exit 1
}

check_release_note() {
    local f=$1
    echo '
Release note:
====================
'
cat $f
echo '
====================
'
    printf "Is the release note correct? [y/n]"
    read correct
    [ "$correct" == "y" ]
    return $?
}

while getopts 's:v:i:c:' o &>> /dev/null; do
    case "$o" in
	v)
            VERSION="$OPTARG";;
	i)
            INC="$OPTARG";;
	c)
            CODENAME="$OPTARG";;
	*)
            usage;;
    esac
done

if [ "$INC" == "" ]; then
    usage
fi

if [ "$VERSION" != "0.0.0" ] ; then
	TAG=divona-$VERSION
	TAR=$TAG.tar.gz
else
	TAG=master
	TAR=divona-$TAG.tar.gz
fi

pushd ./ > /dev/null

#cd $current/
t=debian/changelog.template
f=debian/changelog
[ -f $f ] && rm $f

if [ ! -f $f ]; then
	cp -f $t $f
	sed -i -e "s/#DATE#/`date --rfc-2822`/g" $f
	sed -i -e "s/#VER#/$VERSION/g" $f
	sed -i -e "s/#INC#/$INC/g" $f
	sed -i -e "s/#CODENAME#/$CODENAME/g" $f

	if [ -f $current/release.note ]; then
		check_release_note $current/release.note && COMMIT_MSG=`cat $current/release.note`
	fi
	if [ -z "$COMMIT_MSG" ]; then
		printf "Please enter the Release Note: "
		read COMMIT_MSG
	fi
	sed -i -e "s/#COMMIT-MSG#/${COMMIT_MSG}/" $f
	check_release_note $f || exit
	echo $COMMIT_MSG > $current/release.note
fi

popd > /dev/null
if [ ! -f $TAR ]; then
    echo $TAR
	pushd ./ > /dev/null
    cd $SOURCE_DIR
    echo `pwd`
    git pull
    git checkout $TAG
	popd > /dev/null
    tar zcvf $TAR . --exclude ".git*" --exclude "*.log" && \
   	ln -sf $TAR divona_$VERSION.orig.tar.gz
fi

printf "Start to build source package? [y/n]"
read correct
[ "$correct" != "y" ] && exit

pushd ./ > /dev/null
cd $current/
debuild -S -k$KEY

printf "Upload to PPA? [y/n]"
read correct
[ "$correct" != "y" ] && exit

popd > /dev/null
dput ppa:nlamirault/divona ../divona_${VERSION}-${INC}~${CODENAME}_source.changes
