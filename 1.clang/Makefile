include ../bootsrc.sh

build-clang: build-image
	docker run -it -u $(USER_ID) --name build-clang \
		-v /bootsrc/clang:/bootsrc/clang \
		bootsrc-clang

build-image:
	-docker rm build-clang
	docker build . -t bootsrc-clang \
		--build-arg PKG_SITE \
		--build-arg LLVM_VER \
		--build-arg LLVM_KEY \
		--build-arg SHA_LLVM \
		--no-cache
