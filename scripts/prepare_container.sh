#!/bin/bash -e

image='deepin/openqa-base'
container='openqa-worker'

function prepare_container(){

    container_id=$(docker ps -a -f name=$container -q)
    if [ -n "$container_id" ]; then
        echo "container ($container) exist, delete it.... "
        docker rm -f $container_id
    fi

    docker run --name $container \
        -v /data/docker/openqa-webui/var_lib_openqa_share:/var/lib/openqa/share \
        -v /data/docker/openqa-worker/etc_openqa:/etc/openqa \
        -d -t $image bash

}

function prepare_hosts(){

    docker cp scripts/container/prepare_hosts.sh $container:/data
    docker exec $container bash -ex /data/prepare_hosts.sh

}

function build(){

    prepare_container
    #prepare_hosts

}

build
