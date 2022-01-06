#  ROS2 Docker
ubuntu20.04 + cuda11.4.2(nvidia) + ROS2 Foxy

## Getting Started

### Prerequisities

* [nvidia-docker](https://github.com/NVIDIA/nvidia-docker)

## Build 

If manual build wanted
#### Docker build 

```shell
docker build -t $USER/$rep:$tag .
```

## Run

#### Docker Run

1. First run (create shell file)
 - please change -v(volume) locations as wanted!
 
```shell
#!/bin/bash
xhost +local:root

docker run -it -d --name foxy \
    --gpus all \
    --privileged \
    --net=host \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e QT_X11_NO_MITSHM=1 \
    -e DISPLAY=$DISPLAY \
    -v $HOME/Docker/ROS/ros2_ws:/home/foxy/colcon_ws/src \
    ijmin/ros:foxy_0
```
2. After 
```shell
docker start foxy 
```

## Postrequisities

