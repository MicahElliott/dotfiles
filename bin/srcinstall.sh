#! /bin/bash

# This script could use Xdialog.

# Needs an option to enable skipping abort on existing files/dirs.

fail () {
   echo "ERROR: $1"
   exit 1
}

url=${1?"Must provide a URL to tarball"}
tarball=${1##*/}  # foo-1.2.tar.gz

ext=${tarball##*.}
if [ $ext = "gz" ]; then
   taropt="--gzip"
elif [ $ext = "tgz" ]; then
   taropt="--gzip"
elif [ $ext = "bz2" ]; then
   taropt="--bzip2"
fi

builtin cd ${ARCHIVE:-"$HOME/archive"}

echo "Retrieving '$tarball'."
test -a $tarball && fail "Tarball '$tarball' already exists."
wget --non-verbose $url || fail "Command wget failed."

#extractdir=${tarball%%.tar.gz}
extractdir=$(tar -t $taropt -f $tarball |head -1 |sed 's:/::')
test -a $extractdir && fail "Extraction dir '$extractdir' already exists."

builddir="${extractdir}-build"
echo "*** tarball: $tarball"
echo "*** extractdir: $extractdir"
echo "*** builddir: $builddir"

echo "Extracting '$tarball'."
tar -x $taropt -f $tarball || fail "Tarball extraction failed."

mkdir $builddir
builtin cd $builddir
echo $PWD

# Pass --help and determine any enable/disable and with/without opts.
echo "Configuring '$extractdir'."
../$extractdir/configure --quiet || fail "Configure failed."

echo "Building '$extractdir'."
make -s || fail "Build (make) failed."

echo "Installing '$extractdir'."
sudo make -s install || fail "Installation failed."
