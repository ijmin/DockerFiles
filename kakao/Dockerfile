FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu20.04

USER root

ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics


ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive 


RUN dpkg --add-architecture i386


RUN apt-get update -y

RUN apt-get install -y wine playonlinux


RUN sed -i 's/encoding = \"ascii\"/encoding = \"utf-8\"/g' /usr/lib/python2.7/site.py


RUN apt-get autoremove &&\
    apt-get clean &&\
    rm -rf /tmp/*

RUN apt-get install --reinstall locales && dpkg-reconfigure locales			 
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install  -y language-pack-ko


RUN locale-gen ko_KR.UTF-8
ENV LANG ko_KR.UTF-8  
ENV LANGUAGE ko_KR.UTF-8 
ENV LC_ALL ko_KR.UTF-8


RUN mkdir -p /usr/share/fonts/NanumFont && \
        cd /usr/share/fonts/ && \
        wget http://cdn.naver.com/naver/NanumFont/fontfiles/NanumFont_TTF_ALL.zip && \
        unzip NanumFont_TTF_ALL.zip -d NanumFont && \
        rm -f NanumFont_TTF_ALL.zip


# Add new sudo user
ARG user=kakao
ARG passwd=kakao
ARG uid=1000
ARG gid=1000
ENV USER=$user
ENV PASSWD=$passwd
ENV UID=$uid
ENV GID=$gid
RUN useradd --create-home -m $USER && \
        echo "$USER:$PASSWD" | chpasswd && \
        usermod --shell /bin/bash $USER && \
        usermod -aG sudo $USER && \
	mkdir -p /etc/sudoers.d && \
        echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USER && \
        chmod 0440 /etc/sudoers.d/$USER && \
        usermod  --uid $UID $USER && \
        groupmod --gid $GID $USER && \
        usermod -aG video $USER

### Switch to root user to install additional software
USER $USER
ENV HOME /home/$USER

COPY KakaoTalk_Setup.exe /home/$USER/KakaoTalk_Setup.exe

CMD playonlinux
