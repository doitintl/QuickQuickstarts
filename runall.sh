#!/bin/sh

for DIR in $(ls -d */ ) ; do
    pushd $DIR
    source ./deploy.sh
    popd
done
