#!/bin/bash

# ip=$(ifconfig enp3s0 | grep inet | awk '$1=="inet" {print $2}')
# xhost +local:docker
xhost +local:root
# xhost +$ip

docker run -it -d --name stm \
    --net=host \
    --privileged \
    --device=/dev/ttyACM0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e QT_X11_NO_MITSHM=1 \
    -e DISPLAY=$DISPLAY \
    -v $HOME/Docker/DockerVolumes/STM32/STM32CubeIDE:/home/stm/STM32CubeIDE \
    -v $HOME/Docker/DockerVolumes/STM32/STM32CubeMonitor:/home/stm/STM32CubeMonitor \
    ijmin/stm32cube:ide_1.8.0
    
# ttyACM
# docker exec -it stm /opt/st/stm32cubeide_1.8.0/stm32cubeide
# docker exec -it stm stm32cubemonitor