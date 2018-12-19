#!/bin/bash
# ./network.sh

# Create bridge network
docker network create --driver bridge --subnet 172.42.1.0/24 --gateway 172.42.1.1 yocto
