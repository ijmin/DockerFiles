#  STM32 Docker
* only for devel environment! not installed 
ubuntu20.04 + cuda11.4.2(nvidia) 


### Prerequisities

* [stm32cubeide](https://www.st.com/en/development-tools/stm32cubeide.html)

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
 - please change --device locations as wanted!
 
```shell
#!/bin/bash

xhost +local:root

docker run -it -d --name stm \
    --net=host \
    --privileged \
    --device=/dev/ttyACM0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e QT_X11_NO_MITSHM=1 \
    -e DISPLAY=$DISPLAY \
    -v $HOME/Docker/STM32/workspace:/home/stm \
    ijmin/stm32cube:0.0
```
2. After 
```shell
docker start stm
```

## Postrequisities

Need to install cudeide inside container