include ../bootsrc.sh

build-llvm-clang: build-image
	docker run -it -u $(USER_ID) --name build-llvm-clang bootsrc-llvm-clang
	docker commit build-llvm-clang bootsrc:llvm-clang

build-image:
	-docker rm build-llvm-clang
	docker build . -t bootsrc-llvm-clang \
		--build-arg PKG_SITE \
		--build-arg LLVM_VER \
		--no-cache
