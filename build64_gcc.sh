#!/usr/bin/env bash

export HOST_TAG=linux-x86_64

export ARCH=aarch64
export CPU=arm64-v8a

export MIN=21
export ANDROID_NDK_PLATFORM=android-21

export PREFIX=$(pwd)/android_output/$CPU
export NDK=/home/ztn/android-ndk-r17c

export MIN_PLATFORM=$NDK/platforms/android-$MIN
export TOOLCHAIN=$NDK/toolchains/$ARCH-linux-android-4.9/prebuilt/$HOST_TAG
export SYSROOT=$NDK/sysroot
export AR=$TOOLCHAIN/bin/$ARCH-linux-android-ar
export AS=$TOOLCHAIN/bin/$ARCH-linux-android-as
export CC=$TOOLCHAIN/bin/$ARCH-linux-android-gcc
export CXX=$TOOLCHAIN/bin/$ARCH-linux-android-g++
export LD=$TOOLCHAIN/bin/$ARCH-linux-android-ld
export NM=$TOOLCHAIN/bin/$ARCH-linux-android-nm
export RANLIB=$TOOLCHAIN/bin/$ARCH-linux-android-ranlib
export STRIP=$TOOLCHAIN/bin/$ARCH-linux-android-strip

FF_EXTRA_CFLAGS=""
OPTIMIZE_CFLAGS="-DANDROID -I$SYSROOT/usr/include/$ARCH-linux-android/"
ADDI_LDFLAGS="-Wl,-rpath-link=$MIN_PLATFORM/arch-arm64/usr/lib -L$MIN_PLATFORM/arch-arm64/usr/lib -nostdlib"

sed  -i  "s/SLIBNAME_WITH_MAJOR='\$(SLIBNAME).\$(LIBMAJOR)'/SLIBNAME_WITH_MAJOR='\$(SLIBPREF)\$(FULLNAME)-\$(LIBMAJOR)\$(SLIBSUF)'/" configure
sed  -i  "s/LIB_INSTALL_EXTRA_CMD='\$\$(RANLIB) \"\$(LIBDIR)\\/\$(LIBNAME)\"'/LIB_INSTALL_EXTRA_CMD='\$\$(RANLIB) \"\$(LIBDIR)\\/\$(LIBNAME)\"'/" configure
sed  -i  "s/SLIB_INSTALL_NAME='\$(SLIBNAME_WITH_VERSION)'/SLIB_INSTALL_NAME='\$(SLIBNAME_WITH_MAJOR)'/" configure
sed  -i  "s/SLIB_INSTALL_LINKS='\$(SLIBNAME_WITH_MAJOR) \$(SLIBNAME)'/SLIB_INSTALL_LINKS='\$(SLIBNAME)'/" configure



./configure \
--prefix=$PREFIX \
--ar=$AR \
--as=$AS \
--cc=$CC \
--cxx=$CXX \
--nm=$NM \
--ranlib=$RANLIB \
--strip=$STRIP \
--sysroot=$SYSROOT \
--arch=$ARCH \
--target-os=android \
--enable-cross-compile \
--disable-asm \
--enable-shared \
--disable-static \
--disable-ffprobe \
--disable-ffplay \
--disable-ffmpeg \
--disable-debug \
--disable-symver \
--disable-stripping \
--extra-cflags="-Os -fpic $OPTIMIZE_CFLAGS" \
--extra-ldflags="$ADDI_LDFLAGS"

# --extra-cflags="$FF_EXTRA_CFLAGS  $FF_CFLAGS" \
# --extra-ldflags="$FF_LDFLAGS"

sed  -i  "s/#define HAVE_TRUNC 0/#define HAVE_TRUNC 1/" config.h
sed  -i  "s/#define HAVE_TRUNCF 0/#define HAVE_TRUNCF 1/" config.h
sed  -i  "s/#define HAVE_RINT 0/#define HAVE_RINT 1/" config.h
sed  -i  "s/#define HAVE_LRINT 0/#define HAVE_LRINT 1/" config.h
sed  -i  "s/#define HAVE_LRINTF 0/#define HAVE_LRINTF 1/" config.h
sed  -i  "s/#define HAVE_ROUND 0/#define HAVE_ROUND 1/" config.h
sed  -i  "s/#define HAVE_ROUNDF 0/#define HAVE_ROUNDF 1/" config.h
sed  -i  "s/#define HAVE_CBRT 0/#define HAVE_CBRT 1/" config.h
sed  -i  "s/#define HAVE_CBRTF 0/#define HAVE_CBRTF 1/" config.h
sed  -i  "s/#define HAVE_COPYSIGN 0/#define HAVE_COPYSIGN 1/" config.h
sed  -i  "s/#define HAVE_ERF 0/#define HAVE_ERF 1/" config.h
sed  -i  "s/#define HAVE_HYPOT 0/#define HAVE_HYPOT 1/" config.h
sed  -i  "s/#define HAVE_ISNAN 0/#define HAVE_ISNAN 1/" config.h
sed  -i  "s/#define HAVE_ISFINITE 0/#define HAVE_ISFINITE 1/" config.h
sed  -i  "s/#define HAVE_INET_ATON 0/#define HAVE_INET_ATON 1/" config.h
sed  -i  "s/#define getenv(x) NULL/\\/\\/ #define getenv(x) NULL/" config.h
