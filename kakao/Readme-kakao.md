#  Pol Docker
PlayonLinux + kakaotalk + ubuntu20.04 + opengl(nvidia)

## Getting Started

### Prerequisities

* [nvidia-docker](https://github.com/NVIDIA/nvidia-docker)
* [Kakaotalk](https://www.kakaocorp.com/page/service/service/KakaoTalk?lang=ko)
* Ubuntu + ibus(key input method)
  - different input method --> need to change shell file on docker run


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
 - please change key input method as wanted!

```shell
#!/bin/bash
xhost +local:root

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
```
2. After 
```shell
docker start playonlinux 
```

## Postrequisities

#### Install kakaotalk
- ref : https://tolovefeels.tistory.com/65
1. tools → wine version → 5.0.2(x86)
2. install → non-listed → wine 5.0.2 → 32bit →window 10 →gdiplus, gecko, mono28 →exe install →shortcut add

#### 한글 중복(after kakaotalk install) 
- ref : https://hamonikr.org/used_hamonikr/82280
1. configure -> wine -> registry editor
2. HKEY_CURRENT_USER\Software\Wine -> new key "X11 Driver" add
3. X11 Driver -> new string "inputStyle" + data "root" add
4. restart container
