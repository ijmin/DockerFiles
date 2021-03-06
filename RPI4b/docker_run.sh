#!/bin/bash

# ip=$(ifconfig enp3s0 | grep inet | awk '$1=="inet" {print $2}')
# xhost +local:docker
xhost +local:root
# xhost +$ip

docker run -it -d --name rpi \
    --net=host \
    --privileged \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e QT_X11_NO_MITSHM=1 \
    -e DISPLAY=$DISPLAY \
    -v $HOME/Docker/DockerVolumes/RPI4b:/home/rpi \
    ijmin/rpi:rosnoetic_0
    

#docker run --rm -it --name rpi rpi:4b_ros /bin/bash