#!/bin/sh

echo "Building LLVM $VER using Clang without subprojects"

DEST=/bootsrc/llvm-clang/llvm-clang-$VER   # Install destination

set -x  # print commands
set -e  # exit on error

export PATH=/bootsrc/clang/clang-$VER/bin:$PATH

echo "Check build dependencies"
which ar bzip2 bunzip2 chmod cat cp date echo egrep \
    find grep gzip gunzip install mkdir mv ranlib rm \
    sed sh tar test unzip zip cmake clang clang++ python cmp \
    diff tree

echo "Cleanup destination directory"
mkdir -vp $DEST || true
test -n $("ls -A $DEST 2>/dev/null") && rm -fr $DEST/*
date >$DEST/duration

echo "Make build directory"
mkdir build && cd build

echo "Configure source"
CC=clang \
CXX=clang++ \
cmake -G Ninja \
        -DCMAKE_INSTALL_PREFIX=$DEST \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DLLVM_CONFIG_PATH=/bootsrc/llvm/llvm-$VER/bin/llvm-config \
        ../llvm-$VER.src

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
tar czf llvm-clang-$VER-x86_64.tar.gz $DEST
mv -v llvm-clang-$VER-x86_64.tar.gz $DEST/../
