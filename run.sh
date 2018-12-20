#!/bin/bash
# ./run.sh

# To mount a USB device add the flag --device=/dev/ttyUSB0
docker run -it --rm -h poky --network yocto \
	-v poky:/home/yocto/poky \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=unix$DISPLAY \	
	--cap-add=NET_ADMIN \
	--device=/dev/net/tun \
	--name poky gcamerli/poky:latest
