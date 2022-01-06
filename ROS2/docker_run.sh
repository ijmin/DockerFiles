#!/bin/bash

# ip=$(ifconfig enp3s0 | grep inet | awk '$1=="inet" {print $2}')
# xhost +local:docker
xhost +local:root
# xhost +$ip

docker run -it -d --name foxy \
    --gpus all \
    --net=host \
    --privileged \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e QT_X11_NO_MITSHM=1 \
    -e DISPLAY=$DISPLAY \
    -v $HOME/Docker/ROS2/ros2_ws:/home/foxy/colcon_ws/src \
    ijmin/ros:foxy_0
    
    # -e NVIDIA_VISIBLE_DEVICES=all \