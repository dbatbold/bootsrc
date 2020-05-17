#!/bin/sh

echo "Building LLVM sub projects"

DEST=/bootsrc/llvm-tools/llvm-tools-$VER   # Install destination
LLVM_CONFIG=/bootsrc/llvm-clang/llvm-clang-$VER/bin/llvm-config

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

################################################################################
# Build libcxxabi.

echo "Make build directory"
mkdir build-libcxxabi && cd build-libcxxabi

echo "Configure libcxxabi source"
CC=clang \
CXX=clang++ \
cmake -G Ninja \
        -DCMAKE_INSTALL_PREFIX=$DEST/libcxxabi \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DLLVM_CONFIG_PATH=$LLVM_CONFIG \
	-DLIBCXXABI_LIBCXX_PATH=$PWD/../libcxx-$VER.src \
        ../libcxxabi-$VER.src

echo
echo "Compile libcxxabi source"
time ninja

echo
echo "Test the build and ignore unit test results"
time ninja check-all || true

echo
echo "Install libcxxabi binaries"
ninja install
cd ..

################################################################################
# Build libcxx.

echo "Make build directory"
mkdir build-libcxx && cd build-libcxx

echo "Configure libcxx source"
CC=clang \
CXX=clang++ \
cmake -G Ninja \
        -DCMAKE_INSTALL_PREFIX=$DEST/libcxx \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DLLVM_CONFIG_PATH=$LLVM_CONFIG \
        ../libcxx-$VER.src

echo
echo "Compile libcxx source"
time ninja

echo
echo "Test the build and ignore unit test results"
time ninja check-all || true

echo
echo "Install libcxx binaries"
ninja install
cd ..

################################################################################
# Build compiler-rt.

echo "Make build directory"
mkdir build-compiler-rt && cd build-compiler-rt

echo "Configure compiler-rt source"
CC=clang \
CXX=clang++ \
cmake -G Ninja \
        -DCMAKE_INSTALL_PREFIX=$DEST/compiler-rt \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DLLVM_CONFIG_PATH=$LLVM_CONFIG \
        ../compiler-rt-$VER.src

echo
echo "Compile compiler-rt source"
time ninja

echo
echo "Test the build and ignore unit test results"
time ninja check-all || true

echo
echo "Install compiler-rt binaries"
ninja install
cd ..

################################################################################
# Build lld linker.

echo "Make build directory"
mkdir build-lld && cd build-lld

echo "Configure lld source"
CC=clang \
CXX=clang++ \
cmake -G Ninja \
        -DCMAKE_INSTALL_PREFIX=$DEST/lld \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DLLVM_CONFIG_PATH=$LLVM_CONFIG \
        ../lld-$VER.src

echo
echo "Compile lld source"
time ninja

echo
echo "Test the build and ignore unit test results"
time ninja check-all || true

echo
echo "Install lld binaries"
ninja install
cd ..

################################################################################
# # Build lldb linker.
# 
# echo "Make build directory"
# mkdir build-lldb && cd build-lldb
# 
# echo "Configure lldb source"
# CC=clang \
# CXX=clang++ \
# cmake -G Ninja \
#         -DCMAKE_INSTALL_PREFIX=$DEST/lldb \
#         -DCMAKE_BUILD_TYPE=MinSizeRel \
#         -DLLVM_CONFIG_PATH=$LLVM_CONFIG \
#         ../lldb-$VER.src
# 
# echo
# echo "Compile lldb source"
# time ninja
# 
# echo
# echo "Test the build and ignore unit test results"
# time ninja check-all || true
# 
# echo
# echo "Install lldb binaries"
# ninja install
# cd ..

################################################################################
# Build libunwind.

echo "Make build directory"
mkdir build-libunwind && cd build-libunwind

echo "Configure libunwind source"
CC=clang \
CXX=clang++ \
cmake -G Ninja \
        -DCMAKE_INSTALL_PREFIX=$DEST/libunwind \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DLLVM_CONFIG_PATH=$LLVM_CONFIG \
        ../libunwind-$VER.src

echo
echo "Compile libunwind source"
time ninja

echo
echo "Test the build and ignore unit test results"
time ninja check-all || true

echo
echo "Install libunwind binaries"
ninja install

################################################################################
# # Build clang-tools-extra.
# 
# echo "Make build directory"
# mkdir build-clang-tools-extra && cd build-clang-tools-extra
# 
# echo "Configure clang-tools-extra source"
# CC=clang \
# CXX=clang++ \
# cmake -G Ninja \
#         -DCMAKE_INSTALL_PREFIX=$DEST/clang-tools-extra \
#         -DCMAKE_BUILD_TYPE=MinSizeRel \
#         -DLLVM_CONFIG_PATH=$LLVM_CONFIG \
#         ../clang-tools-extra-$VER.src
# 
# echo
# echo "Compile clang-tools-extra source"
# time ninja
# 
# echo
# echo "Test the build and ignore unit test results"
# time ninja check-all || true
# 
# echo
# echo "Install clang-tools-extra binaries"
# ninja install

echo
echo "Package binaries"
cp -vi ../Dockerfile ../build.sh $DEST
(cd $DEST && tree -fish --dirsfirst >files)
tar czf llvm-tools-$VER-x86_64.tar.gz $DEST
mv -v llvm-tools-$VER-x86_64.tar.gz $DEST/../
