#!/bin/bash
export TMPDIR=/tmp
#设置NDK路径
NDK=C:/Users/huany/AppData/Local/Android/Sdk/ndk/23.1.7779620

SYSROOT=${NDK}/platforms/android-21/arch-arm64/
TOOLCHAIN=${NDK}/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64
CPU=aarch64
PREFIX=$(pwd)/android/$CPU
ADDI_CFLAGS="-march=armv8-a"

function build_one
{
    ./configure \
        --prefix=$PREFIX \
        --enable-shared \
        --disable-static \
        --disable-doc \
        --disable-ffmpeg \
        --disable-ffplay \
        --disable-ffprobe \
        --disable-ffserver \
        --disable-doc \
        --disable-symver \
        --enable-small \
        --cross-prefix=$TOOLCHAIN/bin/aarch64-linux-android- \
        --target-os=android \
        --arch=aarch64 \
        --enable-cross-compile \
        --sysroot=$SYSROOT \
        --extra-cflags="-Os -fpic $ADDI_CFLAGS" \
        --extra-ldflags="$ADDI_LDFLAGS" \
        $ADDITIONAL_CONFIGURE_FLAG
        make clean
        make -j8
        make install
}
build_one