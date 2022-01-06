#  RPI Docker
RPI image[arm64/v8] built from linux[amd64] with buildx

---
## Getting Started

### Prerequisities

* [buildx](https://docs.docker.com/buildx/working-with-buildx/)

---
## Build 

If manual build wanted

### buildx init

1. For amd64/v8  create buildx platform

ref : https://docs.docker.com/buildx/working-with-buildx/
```shell
docker buildx create --name <NAME> --platform <PLATFORM>
docker buildx use <NAME>
```

2. build
```shell
 docker buildx build --load --platform <PLATFORM> -t <IMG:TAG> .
 # ex)
 docker buildx build --load --platform linux/arm64/v8 -t rpi:4b_ros .
```
### buildx error solving (On aarch64)

- Cannot use sudo on aarch64
    ref : https://github.com/multiarch/alpine/issues/32

```shell
docker run --rm --privileged multiarch/qemu-user-static:register --reset --credential yes
docker buildx rm <NAME>
docker buildx create --name <NEWNAME> --driver docker-container --use
docker buildx inspect --bootstrap
```

---
## Run

### Run Test

```shell
docker run --rm -it --name rpi rpi:4b_ros /bin/bash
```
### Run Shell

1. First run (create shell file)
 - please change -v(volume) locations as wanted!
 
```shell
#!/bin/bash

xhost +local:root

docker run -it -d --name rpi \
    --net=host \
    --privileged \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e QT_X11_NO_MITSHM=1 \
    -e DISPLAY=$DISPLAY \
    -v $HOME/Docker/RPI4b/ros_ws:/home/noetic/catkin_ws/src \
    ijmin/rpi:4b_ros_0
```

2. After 
```shell
docker start rpi 
```

---
## Postrequisities

