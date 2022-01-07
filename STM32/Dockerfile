FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu20.04

ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics


ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive && apt-get install -y libncurses5 sudo unzip git build-essential libusb-1.0-0-dev cmake

RUN apt-get autoremove &&\
    apt-get clean &&\
    rm -rf /tmp/*

RUN apt-get update -y

# Add new sudo user
ARG UNAME="stm"
ARG UID=1000
ARG GID=1000
ARG HOME=/home/${UNAME}
RUN useradd -rm -d ${HOME} -s /bin/bash -g root -G sudo,audio,video,plugdev -u ${UID} ${UNAME}
RUN mkdir -p /etc/sudoers.d && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
    chmod 0440 /etc/sudoers.d/${UNAME}

USER ${UNAME}
WORKDIR $HOME

#en.st-stm32cubeide_1.8.0_11526_20211125_0815_amd64.deb_bundle.sh_v1.8.0.zip
#st-stm32cubeide_1.8.0_11526_20211125_0815_amd64.deb_bundle.sh

RUN sudo apt-get update -y
COPY test.zip /home/$UNAME/test.zip
# COPY en.st-stm32cubeide_1.8.0_11526_20211125_0815_amd64.deb_bundle.sh_v1.8.0.zip  ${HOME}/en.st-stm32cubeide_1.8.0_11526_20211125_0815_amd64.deb_bundle.sh_v1.8.0.zip
# RUN unzip en.st-stm32cubeide_1.8.0_11526_20211125_0815_amd64.deb_bundle.sh_v1.8.0.zip
# RUN chmod 755 st-stm32cubeide_1.8.0_11526_20211125_0815_amd64.deb_bundle.sh

# ENV LICENSE_ALREADY_ACCEPTED=1
# ENV STM_FORCE_CONSOLE=0

# RUN sudo sh ./st-stm32cubeide_1.8.0_11526_20211125_0815_amd64.deb_bundle.sh --quiet  --noprogress --nox11 



CMD /bin/bash
