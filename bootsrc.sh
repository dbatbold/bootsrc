# Site URL that serves binary built by bootsrc.
# The site can also be used for caching Archlinux packages for faster build.
export PKG_SITE=http://zero-file

# User ID with write access to /bootsrc directory.
export USER_ID=1000

# LLVM version.
export LLVM_VER=10.0.0

# RSA key that singed LLVM source.
export LLVM_KEY=B6C8F98282B944E3B0D5C2530FC3042E345AD05D

# SHA256 hash of LLVM binary built by '0.llvm' stage.
export SHA_LLVM=764375201737cf061a4c4a7cdb1f259de2a807e9be4c4996214fe6a9ff8cb294

# SHA256 hash of Clang binary build by '1.clang' stage.
export SHA_CLANG=590dfab768d6022b14a9f10f2bdcab8f7834fab30874af9d82233526f4cdb0e5
