#!/bin/bash

ip=$(ifconfig enp3s0 | grep inet | awk '$1=="inet" {print $2}')
# xhost +local:docker
xhost +local:root
# xhost +$ip

docker run -it -d --name playonlinux \
    -h kakao \
    --net=host \
    --privileged \
    --gpus all \
    -v $HOME/Docker/kakao/downs:/home/kakao/카카오톡\ 받은\ 파일 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /dev/shm:/dev/shm \
    -e DISPLAY=$DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -e "GTK_IM_MODULE=ibus" \
    -e "XMODIFIERS=@im=ibus" \
    -e "QT_IM_MODULE=ibus" \
    ijmin/pol:kakaotalk20.0

    # -e NVIDIA_VISIBLE_DEVICES=all \