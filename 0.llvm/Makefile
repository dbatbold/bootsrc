include ../bootsrc.sh

build-llvm: build-image
	docker run -it -u $(USER_ID) --name build-llvm \
		-v /bootsrc/llvm:/bootsrc/llvm \
		bootsrc-llvm

build-image:
	-docker rm build-llvm
	docker build . -t bootsrc-llvm \
		--build-arg PKG_SITE \
		--build-arg LLVM_KEY \
		--build-arg LLVM_VER \
		--no-cache
