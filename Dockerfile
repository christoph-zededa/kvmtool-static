FROM fedora:latest

ENV DEBIAN_FRONTEND noninteractive

ADD https://github.com/kvmtool/kvmtool.git /usr/src/kvmtool

WORKDIR /usr/src/kvmtool

RUN dnf -y update
RUN dnf -y install make gcc glibc-devel glibc-static
RUN make -j$(nproc)
RUN rm -vf lkvm vm
RUN make CFLAGS="-static" LDFLAGS="-static"

ADD https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.9.5.tar.xz /usr/src
WORKDIR /usr/src
RUN tar xvf linux-6.9.5.tar.xz
WORKDIR /usr/src/linux-6.9.5

RUN dnf -y install flex bison bc diffutils elfutils-libelf-devel perl openssl-devel
RUN ARCH=x86_64 make defconfig
RUN ARCH=x86_64 make kvm_guest.config
RUN make -j$(nproc) bzImage

RUN dnf -y install golang
RUN mkdir -vp /usr/src/init
WORKDIR /usr/src/init
COPY init.go .
RUN ARCH=x86_64 go build -o init init.go
