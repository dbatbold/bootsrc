include ../bootsrc.sh

build-llvm-clang: build-image
	docker run -it -u $(USER_ID) --name build-llvm-clang \
		-v /bootsrc/llvm-clang:/bootsrc/llvm-clang \
		bootsrc-llvm-clang

build-image:
	-docker rm build-llvm-clang
	docker build . -t bootsrc-llvm-clang \
		--build-arg PKG_SITE \
		--build-arg LLVM_VER \
		--build-arg LLVM_KEY \
		--build-arg SHA_LLVM \
		--build-arg SHA_CLANG \
		--no-cache
