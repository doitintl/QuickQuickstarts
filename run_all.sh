#!/bin/sh

for DIR in $(ls -d */ ) ; do
    pushd $DIR
    echo ".................... $DIR .................."
    source ./deploy.sh
    popd
done
