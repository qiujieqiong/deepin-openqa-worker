#!/bin/bash -e


function prepare_host_ip(){

    ip=$(/sbin/ip route|awk '/default/ { print  $3}')
    echo "$ip HOST_IP" >> /etc/hosts

}

function prepare(){

    prepare_host_ip

}

prepare
