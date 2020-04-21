#!/bin/sh

echo "Building Clang $VER using GCC"

DEST=/bootsrc/clang/clang-$VER   # Install destination path

set -x  # print commands
set -e  # exit on error

echo "Check build dependencies"
which ar bzip2 bunzip2 chmod cat cp date echo egrep \
    find grep gzip gunzip install mkdir mv ranlib rm \
    sed sh tar test unzip zip cmake gcc g++ python cmp \
    diff tree

echo "Cleanup destination directory"
mkdir -vp $DEST || true
test -n $("ls -A $DEST 2>/dev/null") && rm -fr $DEST/*
date >$DEST/duration

echo "Change to build directory"
mkdir build && cd build

echo "Configure source"
CC=gcc \
CXX=g++ \
cmake -G Ninja \
        -DCMAKE_PREFIX_PATH=/bootsrc/llvm/llvm-$VER \
        -DCMAKE_INSTALL_PREFIX=$DEST \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        ../clang-$VER.src

echo
echo "Compile source"
time ninja

echo
echo "Test the build and ignore unit test results"
time ninja check-all || true
date >>$DEST/duration

echo
echo "Install binaries"
ninja install

echo
echo "Package binaries"
cp -vi ../Dockerfile ../build.sh $DEST
(cd $DEST && tree -fish --dirsfirst >files)
tar czf clang-$VER-x86_64.tar.gz $DEST
mv -v clang-$VER-x86_64.tar.gz $DEST/../
