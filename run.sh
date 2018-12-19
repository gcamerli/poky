#!/bin/bash
# ./run.sh

# To mount a USB device add the flag --device=/dev/ttyUSB0
docker run -it --rm -h poky --network yocto \
	-v poky:/home/yocto/poky \
	--cap-add=NET_ADMIN \
	--device=/dev/net/tun \
	--name poky poky:latest
