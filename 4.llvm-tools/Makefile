include ../bootsrc.sh

build-llvm-tools: build-image
	docker run -it -u $(USER_ID) --name build-llvm-tools bootsrc-llvm-tools
	docker commit build-llvm-tools bootsrc:llvm-tools

build-image:
	-docker rm build-llvm-tools
	docker build . -t bootsrc-llvm-tools \
		--build-arg PKG_SITE \
		--build-arg LLVM_VER \
		--no-cache
