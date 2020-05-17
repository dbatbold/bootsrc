# Build LLVM using Clang without any subprojects.
FROM bootsrc:clang

ARG PKG_SITE
ARG LLVM_VER

ENV VER=$LLVM_VER
ENV GITHUB=https://github.com/llvm/llvm-project/releases/download/llvmorg-$VER

USER root

# Protect clang installation directory.
RUN chown -R root:root /bootsrc/clang

# Remove llvm build directory.
RUN rm -fr /build/llvm

# Remove clang build directory.
RUN rm -fr /build/clang

# Create install directory.
USER builder
RUN mkdir -p /bootsrc/llvm-clang/llvm-clang-$VER

# Create build directory.
RUN mkdir /build/llvm-clang
WORKDIR /build/llvm-clang
COPY build.sh Dockerfile Makefile ./

# Download LLVM source.
RUN wget -q $PKG_SITE/src/llvm/llvm-$VER.src.tar.xz \
            || wget -q $GITHUB/llvm-$VER.src.tar.xz
RUN wget -q $PKG_SITE/src/llvm/llvm-$VER.src.tar.xz.sig \
            || wget -q $GITHUB/llvm-$VER.src.tar.xz.sig

# Verify and extract source.
RUN wget -O hans-gpg-key.asc https://releases.llvm.org/$VER/hans-gpg-key.asc
RUN gpg --import hans-gpg-key.asc
RUN gpg --verify llvm-$VER.src.tar.xz.sig
RUN tar xf llvm-$VER.src.tar.xz --no-same-owner

# Build LLVM.
ENTRYPOINT time ./build.sh
