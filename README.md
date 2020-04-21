## bootsrc

The project is a collection of build scripts for bootstrapping LLVM compiler for building other open source projects written in C and C++.

- `0.llvm`  builds LLVM using GCC compiler without any subprojects
- `1.clang` builds Clang using GCC compiler with `0.llvm`
- `2.llvm-clang` builds LLVM using Clang built by `1.clang` stage
- `3.clang-clang` builds Clang using Clang built by `1.clang` stage

```
# Build LLVM using GCC compiler.
$ make -C 0.llvm

# Build Clang using GCC and LLVM binary built by the previous stage.
$ make -C 1.clang

# Build LLVM using Clang binary built by the previous stage.
$ make -C 2.llvm-clang

# Build Clang using Clang binary built by the previous stage.
$ make -C 3.clang-clang
```

The following binary packages will be created in the `bootsrc:clang-clang` image.
```
/bootsrc/llvm/llvm-10.0.0-x86_64.tar.gz
/bootsrc/clang/clang-10.0.0-x86_64.tar.gz
/bootsrc/llvm-clang/llvm-clang-10.0.0-x86_64.tar.gz
/bootsrc/clang-clang/clang-clang-10.0.0-x86_64.tar.gz
```
