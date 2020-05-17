# Build Clang using '0.llvm' image
FROM bootsrc:llvm

ARG PKG_SITE
ARG LLVM_VER

ENV VER=$LLVM_VER
ENV GITHUB=https://github.com/llvm/llvm-project/releases/download/llvmorg-$VER

USER root

# Protect llvm installation directory.
RUN chown -R root:root /bootsrc/llvm

# Remove llvm build directory.
RUN rm -fr /build/llvm

# Create install destination directory.
USER builder
RUN mkdir -p /bootsrc/clang/clang-$VER

# Create build directory.
RUN mkdir /build/clang
WORKDIR /build/clang
COPY build.sh Dockerfile Makefile ./

# Download LLVM source.
RUN wget -q $PKG_SITE/src/llvm/clang-$VER.src.tar.xz \
            || wget -q $GITHUB/clang-$VER.src.tar.xz
RUN wget -q $PKG_SITE/src/llvm/clang-$VER.src.tar.xz.sig \
            || wget -q $GITHUB/clang-$VER.src.tar.xz.sig

# Verify and extract source.
RUN wget -O hans-gpg-key.asc https://releases.llvm.org/$VER/hans-gpg-key.asc
RUN gpg --import hans-gpg-key.asc
RUN gpg --verify clang-$VER.src.tar.xz.sig
RUN tar xf clang-$VER.src.tar.xz --no-same-owner

# Build Clang using GCC.
ENTRYPOINT time ./build.sh
