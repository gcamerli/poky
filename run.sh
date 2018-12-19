#!/bin/bash
# ./run.sh

# To mount a USB device add the flag --device=/dev/ttyUSB0
docker run -it --rm -h poky -v poky:/home/yocto/poky --name poky gcamerli/poky:latest
