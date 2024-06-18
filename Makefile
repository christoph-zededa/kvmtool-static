run: lkvm bzImage init
	./lkvm run  --kernel bzImage --9p ./,root -m 2G -p "root=root init=/init"

lvkm: Dockerfile
	docker build -t kvmtools .
	$(eval ID := $(shell docker create kvmtools 2>/dev/null))
	sleep 5
	docker cp ${ID}:/usr/src/kvmtool/lkvm .
	docker rm ${ID}

bzImage: Dockerfile
	docker build -t kvmtools .
	$(eval ID := $(shell docker create kvmtools 2>/dev/null))
	sleep 5
	docker cp ${ID}:/usr/src/linux-6.9.5/arch/x86/boot/bzImage .
	docker rm ${ID}

init: Dockerfile init.go
	docker build -t kvmtools .
	$(eval ID := $(shell docker create kvmtools 2>/dev/null))
	sleep 5
	docker cp -a ${ID}:/usr/src/init/init .
	docker rm ${ID}
