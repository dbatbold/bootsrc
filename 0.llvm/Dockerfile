# Build LLVM using GCC without the sub projects.
FROM archlinux/base

ARG PKG_SITE
ARG LLVM_VER

ENV VER=$LLVM_VER
ENV GITHUB=https://github.com/llvm/llvm-project/releases/download/llvmorg-$VER

# Install build dependencies.
RUN echo "Server = $PKG_SITE/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist
RUN echo 'Server = https://mirrors.dotsrc.org/archlinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist
RUN pacman -Sy
RUN pacman -Su --noconfirm
RUN pacman -S --noconfirm \
        gcc git wget gnupg grep tar vim tree cmake ninja which \
        unzip zip python diffutils
RUN printf "pass\npass\n" | passwd

# Add user.
RUN useradd -m -d /build builder

# Create install directory.
RUN mkdir /bootsrc
RUN chown builder /bootsrc

# Download LLVM source.
USER builder
RUN mkdir /build/llvm
WORKDIR /build/llvm
ADD build.sh Dockerfile Makefile ./
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
