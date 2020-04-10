## bootsrc

The project is a collection of build scripts for bootsrapping LLVM compiler for building other open source projects written in C and C++.

- `0.llvm`  builds LLVM using GCC compiler without any subprojects.
- `1.clang` builds Clang using GCC compiler with '0.llvm'
- `2.llvm-clang` builds LLVM using Clang built by '1.clang'

```
# Build LLVM using GCC compiler.
$ source bootsrc.sh
$ mkdir -p /bootsrc/llvm
$ chown $USER_ID /bootsrc/llvm
$ cd 0.llvm
$ make

# Upload /bootsrc/llvm/llvm-10.0.0-x86_64.tar.gz
# to PKG_SITE/bootsrc/packages/llvm/ and update SHA_LLVM.

# Build Clang using GCC and LLVM binary built by above stage.
$ source bootsrc.sh
$ mkdir -p /bootsrc/clang
$ chown $USER_ID /bootsrc/clang
$ cd 1.clang
$ make

# Upload /bootsrc/clang/clang-10.0.0-x86_64.tar.gz
# to PKG_SITE/bootsrc/packages/clang/ and update SHA_CLANG.

# Build LLVM using Clang binary built by above stage.
$ source bootsrc.sh
$ mkdir -p /bootsrc/llvm-clang
$ chown $USER_ID /bootsrc/llvm-clang
$ cd 2.llvm-clang
$ make

# This creates LLVM binary built by Clang:
# /bootsrc/llvm-clang/llvm-clang-10.0.0-x86_64.tar.gz
```
