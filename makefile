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
	
	# build tinycv
	cd source/os-autoinst/ppmclibs \
	&& perl Makefile.PL \
	&& make \
