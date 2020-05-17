## bootsrc

The project is a collection of build scripts for bootstrapping LLVM compiler for building other open source projects written in C and C++.

- `0.llvm`  builds LLVM using GCC compiler without any subprojects
- `1.clang` builds Clang using GCC compiler using `0.llvm` image
- `2.llvm-clang` builds LLVM using Clang built by `1.clang` stage
- `3.clang-clang` builds Clang using Clang built by `1.clang` stage
- `4.llvm-tools` builds LLVM subprojects using Clang built by `3.clang-clang` stage

```
# Build LLVM using GCC compiler.
$ make -C 0.llvm

# Build Clang using GCC and LLVM binary built by the previous stage.
$ make -C 1.clang

# Build LLVM using Clang binary built by the previous stage.
$ make -C 2.llvm-clang

# Build Clang using Clang binary built by the previous stage.
$ make -C 3.clang-clang

# Build LLVM subprojects using Clang binary built by the previous stage.
$ make -C 4.llvm-tools

# Copy packages from build container to local filesystem.
$ docker cp build-llvm-clang:/bootsrc/llvm-clang/llvm-clang-10.0.0-x86_64.tar.gz .
$ docker cp build-clang-clang:/bootsrc/clang-clang/clang-clang-10.0.0-x86_64.tar.gz .
$ docker cp build-llvm-tools:/bootsrc/llvm-tools/llvm-tools-10.0.0-x86_64.tar.gz .

# Install LLVM and Clang locally. (run as root)
$ tar xf llvm-clang-10.0.0-x86_64.tar.gz --no-same-onwer -C /
$ tar xf clang-clang-10.0.0-x86_64.tar.gz --no-same-onwer -C /
$ tar xf llvm-tools-10.0.0-x86_64.tar.gz --no-same-onwer -C /
$ ln -s /bootsrc/clang-clang/clang-clang-10.0.0/bin/clang /usr/local/bin/
$ ln -s /bootsrc/clang-clang/clang-clang-10.0.0/bin/clang++ /usr/local/bin/
```
