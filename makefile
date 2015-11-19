all: ready build

build:
	bash -ex scripts/prepare_container.sh
	bash -ex scripts/prepare_worker.sh

ready:
	# build
	cd source/os-autoinst \
	&& autoreconf -f -i \
	&& ./configure \
	&& make

install:
	cp -r bin/* /usr/bin
