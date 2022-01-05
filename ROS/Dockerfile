FROM nvidia/cudagl:11.4.2-base-ubuntu20.04

# NVIDIA
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics


ENV DEBIAN_FRONTEND=noninteractive 
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y wget sudo curl gnupg2 lsb-release locales

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# rosdep는 ROOT권한으로 실행하는걸 권장하지 않는다
ARG UNAME="noetic"
ARG UID=1000
ARG GID=1000
ARG HOME=/home/${UNAME}
RUN useradd -rm -d ${HOME} -s /bin/bash -g root -G sudo,audio,video,plugdev -u ${UID} ${UNAME}
RUN mkdir -p /etc/sudoers.d && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
    chmod 0440 /etc/sudoers.d/${UNAME}

USER ${UNAME}
WORKDIR $HOME

RUN sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

RUN sudo apt-get update 
RUN DEBIAN_FRONTEND=noninteractive && sudo apt-get install -y ros-noetic-desktop

RUN DEBIAN_FRONTEND=noninteractive && sudo apt-get install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential \
    libusb-dev libspnav-dev libbluetooth-dev libcwiid-dev libncurses5-dev \
    libgl1-mesa-glx libgl1-mesa-dri mesa-utils \
    qt5-default  x11-apps \
    tmux vim \
    unzip locales ntp whois tree \
    python3-pip python3-tk python3-rosdep 
    # python-pip \

# clean up
RUN sudo apt-get autoremove --purge --yes \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/ros/rosdep/sources.list.d/20-default.list

# ROS관련 DEPENDENCIES & LIBRAIES 설치
RUN rosdep init

# 생성된 USER 계정으로 실행
RUN sudo rosdep fix-permissions 

RUN rosdep update

# init catkin workspace
RUN mkdir -p $HOME/catkin_ws/src
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash; cd catkin_ws/src; catkin_init_workspace; catkin_make -C ${HOME}/catkin_ws"

RUN sudo apt-get update
# RUN sudo apt-get install -y ros-noetic-rviz*
# RUN sudo apt-get install -y ros-noetic-rqt*

# node들을 실행할때 필요한 환경변수들은 미리 초기화 한다.
RUN echo "source /opt/ros/noetic/setup.bash" >> $HOME/.bashrc
RUN echo "source $HOME/catkin_ws/devel/setup.bash" >> $HOME/.bashrc
RUN echo "export ROS_HOSTNAME=localhost" >> $HOME/.bashrc
RUN echo "export ROS_MASTER_URI=http://localhost:11311" >> $HOME/.bashrc
RUN echo "# export ROS_HOSTNAME=$(hostname -I | awk '{print $1}')" >> $HOME/.bashrc
RUN echo "# export ROS_MASTER_URI=http://$(hostname -I | awk '{print $1}'):11311" >> $HOME/.bashrc
RUN echo "alias cw='cd ~/catkin_ws'" >> $HOME/.bashrc
RUN echo "alias cs='cd ~/catkin_ws/src'" >> $HOME/.bashrc
RUN echo "alias cm='catkin_make -C ~/catkin_ws/'" >> $HOME/.bashrc
RUN echo "alias eb='vi ~/.bashrc'" >> $HOME/.bashrc
RUN echo "alias sb='source ~/.bashrc'" >> $HOME/.bashrc
