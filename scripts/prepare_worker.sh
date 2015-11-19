#!/bin/bash -e

container='openqa-worker'

function prepare_webui(){

    tar zcf openQA.tar.gz -C source/openQA .
    docker exec $container mkdir -p /data/openQA
    cat openQA.tar.gz | docker cp - $container:/data/openQA
    rm -f openQA.tar.gz

}

function prepare_worker(){

    tar zcf os-autoinst.tar.gz -C source/os-autoinst .
    docker exec $container mkdir -p /usr/lib/os-autoinst
    cat os-autoinst.tar.gz | docker cp - $container:/usr/lib/os-autoinst
    rm -f os-autoinst.tar.gz

}

function prepare_source(){

    prepare_webui
    prepare_worker

}

function install_webui(){

    docker exec $container make -C /data/openQA install

}

function install_os_autoinst(){

    # build and install ppmclibs
    docker exec $container bash -c "cd /usr/lib/os-autoinst/ppmclibs \
        && perl Makefile.PL && make && make install"

}

function install(){

    install_webui
    install_os_autoinst

}

function install_tools(){

    tar zcf openQA-tools.tar.gz -C openQA-tools .
    cat openQA-tools.tar.gz | docker cp - $container:/usr/bin
    rm -f openQA-tools.tar.gz

}

function replace(){

    tar zcf replace.tar.gz -C replace .
    cat replace.tar.gz | docker cp - $container:/
    rm -f replace.tar.gz

}

function build(){

    prepare_source
    install
    install_tools
    replace

}

build
