# Builds LLVM subprojects.
FROM bootsrc:clang-clang

ARG PKG_SITE
ARG LLVM_VER

ENV VER=$LLVM_VER
ENV GITHUB=https://github.com/llvm/llvm-project/releases/download/llvmorg-$VER

USER root

#RUN pacman --noconfirm -S make

# Protect clang installation directory.
RUN chown -R root:root /bootsrc/clang-clang

# Remove clang-clang build directory used in the previous stage.
RUN rm -fr /build/clang-clang

# Create install directory.
USER builder
RUN mkdir -p /bootsrc/llvm-tools/llvm-tools-$VER

# Create build directory.
RUN mkdir /build/llvm-tools
WORKDIR /build/llvm-tools
COPY build.sh Dockerfile Makefile ./

# Download LLVM source files.
RUN wget -q $PKG_SITE/src/llvm/compiler-rt-$VER.src.tar.xz \
            || wget -q $GITHUB/compiler-rt-$VER.src.tar.xz
RUN wget -q $PKG_SITE/src/llvm/compiler-rt-$VER.src.tar.xz.sig \
            || wget -q $GITHUB/compiler-rt-$VER.src.tar.xz.sig

RUN wget -q $PKG_SITE/src/llvm/lld-$VER.src.tar.xz \
            || wget -q $GITHUB/lld-$VER.src.tar.xz
RUN wget -q $PKG_SITE/src/llvm/lld-$VER.src.tar.xz.sig \
            || wget -q $GITHUB/lld-$VER.src.tar.xz.sig

RUN wget -q $PKG_SITE/src/llvm/lldb-$VER.src.tar.xz \
            || wget -q $GITHUB/lldb-$VER.src.tar.xz
RUN wget -q $PKG_SITE/src/llvm/lldb-$VER.src.tar.xz.sig \
            || wget -q $GITHUB/lldb-$VER.src.tar.xz.sig

RUN wget -q $PKG_SITE/src/llvm/libunwind-$VER.src.tar.xz \
            || wget -q $GITHUB/libunwind-$VER.src.tar.xz
RUN wget -q $PKG_SITE/src/llvm/libunwind-$VER.src.tar.xz.sig \
            || wget -q $GITHUB/libunwind-$VER.src.tar.xz.sig

RUN wget -q $PKG_SITE/src/llvm/libcxx-$VER.src.tar.xz \
            || wget -q $GITHUB/libcxx-$VER.src.tar.xz
RUN wget -q $PKG_SITE/src/llvm/libcxx-$VER.src.tar.xz.sig \
            || wget -q $GITHUB/libcxx-$VER.src.tar.xz.sig

RUN wget -q $PKG_SITE/src/llvm/libcxxabi-$VER.src.tar.xz \
            || wget -q $GITHUB/libcxxabi-$VER.src.tar.xz
RUN wget -q $PKG_SITE/src/llvm/libcxxabi-$VER.src.tar.xz.sig \
            || wget -q $GITHUB/libcxxabi-$VER.src.tar.xz.sig

RUN wget -q $PKG_SITE/src/llvm/clang-tools-extra-$VER.src.tar.xz \
            || wget -q $GITHUB/clang-tools-extra-$VER.src.tar.xz
RUN wget -q $PKG_SITE/src/llvm/clang-tools-extra-$VER.src.tar.xz.sig \
            || wget -q $GITHUB/clang-tools-extra-$VER.src.tar.xz.sig

# Verify and extract source files.
RUN wget -O hans-gpg-key.asc https://releases.llvm.org/$VER/hans-gpg-key.asc
RUN gpg --import hans-gpg-key.asc
RUN gpg --verify compiler-rt-$VER.src.tar.xz.sig
RUN gpg --verify lld-$VER.src.tar.xz.sig
RUN gpg --verify lldb-$VER.src.tar.xz.sig
RUN gpg --verify libunwind-$VER.src.tar.xz.sig
RUN gpg --verify libcxx-$VER.src.tar.xz.sig
RUN gpg --verify libcxxabi-$VER.src.tar.xz.sig
RUN gpg --verify clang-tools-extra-$VER.src.tar.xz.sig

RUN tar xf compiler-rt-$VER.src.tar.xz --no-same-owner
RUN tar xf lld-$VER.src.tar.xz --no-same-owner
RUN tar xf lldb-$VER.src.tar.xz --no-same-owner
RUN tar xf libunwind-$VER.src.tar.xz --no-same-owner
RUN tar xf libcxx-$VER.src.tar.xz --no-same-owner
RUN tar xf libcxxabi-$VER.src.tar.xz --no-same-owner
RUN tar xf clang-tools-extra-$VER.src.tar.xz --no-same-owner

# Build LLVM tools.
ENTRYPOINT time ./build.sh || bash
