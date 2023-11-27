#!/bin/bash
set -e

export MAKE_FLAGS=-j2

. ./download.sh

echo "[*] Downloading"
download

LIBS_DIR=$PWD/libs/linux-x86_64
TARGET_DIR=$PWD/target/linux-x86_64

rm -rf build/linux-x86_64
mkdir -p build/linux-x86_64
pushd build/linux-x86_64

echo "[*] Building jansson"
tar xf ../../tars/$JANSSON_TAR
pushd $JANSSON_NAME
LDFLAGS=-static ./configure --host x86_64-unknown-linux-musl --prefix=$LIBS_DIR --disable-shared
make
make install
popd

echo "[*] Building PCRE2"
tar xf ../../tars/$PCRE2_TAR
pushd $PCRE2_NAME
LDFLAGS=-static ./configure --host x86_64-unknown-linux-musl --prefix=$LIBS_DIR --disable-shared --enable-jit
make
make install
popd

echo "[*] Building ICU4C"
tar xf ../../tars/$ICU4C_TAR
pushd $ICU4C_NAME/source
LDFLAGS=-static ./configure --host x86_64-unknown-linux-musl --prefix=$LIBS_DIR --disable-shared --enable-static
make
make install
popd

echo "[*] Building libxml2"
tar xf ../../tars/$LIBXML2_TAR
pushd $LIBXML2_NAME
PKG_CONFIG_PATH=$LIBS_DIR/lib/pkgconfig LDFLAGS=-static ./configure --host x86_64-unknown-linux-musl --prefix=$LIBS_DIR --disable-shared --enable-static --without-python --without-zlib --without-lzma
make
make install
popd

echo "[*] Building libyaml"
tar xf ../../tars/$LIBYAML_TAR
pushd $LIBYAML_NAME
LDFLAGS=-static ./configure --host x86_64-unknown-linux-musl --prefix=$LIBS_DIR --disable-shared
make
make install
popd

echo "[*] Building ctags"
tar xf ../../tars/$CTAGS_TAR
pushd $CTAGS_NAME
./autogen.sh
PKG_CONFIG_PATH=$LIBS_DIR/lib/pkgconfig LDFLAGS=-static ./configure --host x86_64-unknown-linux-musl --prefix=$TARGET_DIR
make
make install
popd

popd
