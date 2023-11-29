#!/bin/bash
set -e

export MAKE_FLAGS=-j2

. ./download.sh

echo "[*] Downloading"
download

LIBS_DIR=$PWD/libs/linux-x86_64
TARGET_DIR=$PWD/target/linux-x86_64
BUILD_DIR=$PWD/build/linux-x86_64

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR
pushd $BUILD_DIR

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

echo "[*] Building ICU4C (Build)"
pushd icu-host
tar xf ../../tars/$ICU4C_TAR
pushd $ICU4C_NAME/source
./configure
make
make install
popd
popd

echo "[*] Building ICU4C (Host)"
tar xf ../../tars/$ICU4C_TAR
pushd $ICU4C_NAME/source
LDFLAGS=-static ./configure --host x86_64-unknown-linux-musl --prefix=$LIBS_DIR --disable-shared --enable-static --with-cross-build=$BUILD_DIR/icu-host/$ICU4C_NAME/source
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
