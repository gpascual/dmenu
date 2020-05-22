#!/usr/bin/env sh

# create source tarball
tar cf sources.tar ../../

# update tarball checksums
updpkgsums

# build package with cleaning option
makepkg -c

rm sources.tar