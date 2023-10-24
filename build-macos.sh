#!/bin/bash
set -e

export MAKE_FLAGS=-j2

. ./download.sh

echo "[*] Downloading"
download

for ARCH in arm64 x86_64; do
    LIBS_DIR=$PWD/libs/darwin-$ARCH
    TARGET_DIR=$PWD/target/darwin-$ARCH

    rm -rf build/darwin-$ARCH
    mkdir -p build/darwin-$ARCH
    pushd build/darwin-$ARCH

    echo "[*] Building jansson ($ARCH)"
    tar xf ../../tars/$JANSSON_TAR
    pushd $JANSSON_NAME
    CC="clang -arch $ARCH" ./configure --host $ARCH-apple-darwin --prefix=$LIBS_DIR --disable-shared
    gmake
    gmake install
    popd

    echo "[*] Building libyaml"
    tar xf ../../tars/$LIBYAML_TAR
    pushd $LIBYAML_NAME
    autoreconf -f -i
    CC="clang -arch $ARCH" ./configure --host $ARCH-apple-darwin --prefix=$LIBS_DIR --disable-shared
    make
    make install
    popd

    echo "[*] Building PCRE2 ($ARCH)"
    tar xf ../../tars/$PCRE2_TAR
    pushd $PCRE2_NAME
    CC="clang -arch $ARCH" ./configure --host $ARCH-apple-darwin --prefix=$LIBS_DIR --disable-shared --enable-jit
    gmake
    gmake install
    popd

    echo "[*] Building ctags ($ARCH)"
    tar xf ../../tars/$CTAGS_TAR
    pushd $CTAGS_NAME
    ./autogen.sh
    PKG_CONFIG_PATH=$LIBS_DIR/lib/pkgconfig CC="clang -arch $ARCH" ./configure --host $ARCH-apple-darwin --prefix=$TARGET_DIR
    gmake
    gmake install
    popd

    popd
done;
