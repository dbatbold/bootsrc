# Build LLVM using Clang without any sub projects.
FROM archlinux/base

ARG PKG_SITE
ARG LLVM_VER
ARG LLVM_KEY
ARG SHA_LLVM
ARG SHA_CLANG

ENV VER=$LLVM_VER

# Install build dependencies.
RUN echo "Server = $PKG_SITE/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist
RUN echo 'Server = https://mirrors.dotsrc.org/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
RUN pacman -Sy
RUN pacman -S --noconfirm \
        git wget gnupg grep tar vim tree cmake ninja which \
        unzip zip python diffutils binutils gcc
RUN printf "pass\npass\n" | passwd

# Add user.
RUN useradd -m -d /build builder
WORKDIR /build

# Install LLVM built by '0.llvm'
RUN wget -q $PKG_SITE/bootsrc/packages/llvm/llvm-$VER-x86_64.tar.gz
RUN echo "$SHA_LLVM  llvm-$VER-x86_64.tar.gz" | sha256sum -c
RUN tar xf llvm-$VER-x86_64.tar.gz -C /

# Install Clang built by '1.clang'
RUN wget -q $PKG_SITE/bootsrc/packages/clang/clang-$VER-x86_64.tar.gz
RUN echo "$SHA_CLANG  clang-$VER-x86_64.tar.gz" | sha256sum -c
RUN tar xf clang-$VER-x86_64.tar.gz -C /

# Create install directory.
RUN mkdir -p /bootsrc/llvm-clang/llvm-clang-$VER
RUN chown builder /build /bootsrc/llvm-clang/llvm-clang-$VER

# Download LLVM source.
USER builder
COPY build.sh Dockerfile Makefile ./
RUN wget -q $PKG_SITE/src/llvm/llvm-$VER.src.tar.xz \
    || wget -q https://github.com/llvm/llvm-project/releases/download/llvmorg-$VER/llvm-$VER.src.tar.xz
RUN wget -q $PKG_SITE/src/llvm/llvm-$VER.src.tar.xz.sig \
    || wget -q https://github.com/llvm/llvm-project/releases/download/llvmorg-$VER/llvm-$VER.src.tar.xz.sig

# Verify and extract source.
RUN gpg --recv $LLVM_KEY
RUN gpg --verify llvm-$VER.src.tar.xz.sig
RUN tar xf llvm-$VER.src.tar.xz --no-same-owner

# Build Clang.
ENTRYPOINT time ./build.sh
