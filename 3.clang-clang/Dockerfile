# Build Clang using '1.clang' image
FROM bootsrc:llvm-clang

ARG PKG_SITE
ARG LLVM_VER

ENV VER=$LLVM_VER

USER root

# Protect llvm-clang installation directory.
RUN chown -R root:root /bootsrc/llvm-clang

# Remove llvm build directory.
RUN rm -fr /build/llvm-clang

# Create install destination directory.
USER builder
RUN mkdir -p /bootsrc/clang-clang/clang-clang-$VER

# Create build directory.
RUN mkdir /build/clang-clang
WORKDIR /build/clang-clang
COPY build.sh Dockerfile Makefile ./

# Download LLVM source.
RUN wget -q $PKG_SITE/src/llvm/clang-$VER.src.tar.xz \
    || wget https://github.com/llvm/llvm-project/releases/download/llvmorg-$VER/clang-$VER.src.tar.xz
RUN wget -q $PKG_SITE/src/llvm/clang-$VER.src.tar.xz.sig \
    || wget https://github.com/llvm/llvm-project/releases/download/llvmorg-$VER/clang-$VER.src.tar.xz.sig

# Verify and extract source.
RUN wget -O hans-gpg-key.asc https://releases.llvm.org/$VER/hans-gpg-key.asc
RUN gpg --import hans-gpg-key.asc
RUN gpg --verify clang-$VER.src.tar.xz.sig
RUN tar xf clang-$VER.src.tar.xz --no-same-owner

# Build Clang using Clang.
ENTRYPOINT time ./build.sh
