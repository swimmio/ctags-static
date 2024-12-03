#!/bin/bash
set -e

export MAKE_FLAGS=-j2

. ./download.sh

echo "[*] Downloading"
download

LIBS_DIR=$PWD/libs/windows-x86_64
TARGET_DIR=$PWD/target/windows-x86_64

rm -rf build/windows-x86_64
mkdir -p build/windows-x86_64
pushd build/windows-x86_64

echo "[*] Building ctags"
7z x ../../tars/$CTAGS_TAR -so | 7z x -si -ttar 
pushd $CTAGS_NAME
./autogen.sh
./configure --prefix=$TARGET_DIR --disable-external-sort --enable-static
make
make install
popd

popd
