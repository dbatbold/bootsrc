include ../bootsrc.sh

build-clang: build-image
	docker run -it -u $(USER_ID) --name build-clang-clang bootsrc-clang-clang
	docker commit build-clang-clang bootsrc:clang-clang

build-image:
	-docker rm build-clang-clang
	docker build . -t bootsrc-clang-clang \
		--build-arg PKG_SITE \
		--build-arg LLVM_VER \
		--no-cache
