lvkm: Dockerfile
	docker build -t kvmtools .
	$(eval ID := $(shell docker create kvmtools 2>/dev/null))
	sleep 5
	docker cp ${ID}:/usr/src/kvmtool/lkvm .
	docker cp ${ID}:/usr/src/linux-6.9.5/arch/x86/boot/bzImage .
	docker rm ${ID}
