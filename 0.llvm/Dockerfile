# Build LLVM using GCC without the sub projects.
FROM archlinux/base

ARG PKG_SITE
ARG LLVM_KEY
ARG LLVM_VER

ENV VER=$LLVM_VER

# Install build dependencies.
RUN echo "Server = $PKG_SITE/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist
RUN echo 'Server = https://mirrors.dotsrc.org/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
RUN pacman -Sy
RUN pacman -S --noconfirm \
        gcc git wget gnupg grep tar vim tree cmake ninja which \
        unzip zip python diffutils
RUN printf "pass\npass\n" | passwd

# Add user.
RUN useradd -d /build builder
WORKDIR /build

# Create install directory.
RUN mkdir -p /bootsrc/llvm/llvm-$VER
RUN chown builder /build /bootsrc/llvm/llvm-$VER

# Download LLVM source.
USER builder
ADD build.sh Dockerfile Makefile /build/
RUN wget -q $PKG_SITE/src/llvm/llvm-$VER.src.tar.xz \
    || wget -q https://github.com/llvm/llvm-project/releases/download/llvmorg-$VER/llvm-$VER.src.tar.xz
RUN wget -q $PKG_SITE/src/llvm/llvm-$VER.src.tar.xz.sig \
    || wget -q https://github.com/llvm/llvm-project/releases/download/llvmorg-$VER/llvm-$VER.src.tar.xz.sig

# Verify and extract source.
RUN gpg --recv $LLVM_KEY
RUN gpg --verify llvm-$VER.src.tar.xz.sig
RUN tar xf llvm-$VER.src.tar.xz --no-same-owner

# Build LLVM.
ENTRYPOINT time ./build.sh
