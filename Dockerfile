FROM fedora:latest

ENV DEBIAN_FRONTEND noninteractive

ADD https://github.com/kvmtool/kvmtool.git /usr/src/kvmtool

WORKDIR /usr/src/kvmtool

RUN dnf -y update
RUN dnf -y install make gcc glibc-devel glibc-static
RUN make -j16
RUN rm -vf lkvm vm
RUN make CFLAGS="-static" LDFLAGS="-static"

ADD https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.9.5.tar.xz /usr/src
WORKDIR /usr/src
RUN tar xvf linux-6.9.5.tar.xz
WORKDIR /usr/src/linux-6.9.5


RUN dnf -y install flex bison bc diffutils
RUN make allnoconfig
RUN make kvm_guest.config
RUN make -j16 bzImage

#RUN apt-get update
#RUN apt-get -y dist-upgrade
#
#RUN apt-get -y install build-essential
#RUN apt-get -y install vim
