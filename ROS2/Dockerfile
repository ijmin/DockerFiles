FROM nvidia/cudagl:11.4.2-base-ubuntu20.04

# NVIDIA
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics


ENV DEBIAN_FRONTEND=noninteractive 
ARG DEBIAN_FRONTEND=noninteractive


# set locales + etc
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y wget sudo curl gnupg2 lsb-release locales

RUN locale-gen en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# set X11 related
RUN apt-get update &&  apt-get install -y -qq --no-install-recommends \
    libgl1 \
    libxext6 \ 
    libx11-6 \
   && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install curl gnupg2 lsb-release
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

# # Install ROS
# RUN apt-get update && apt-get install curl gnupg2 lsb-release
# RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
# RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# RUN apt-get update && apt-get install -y \
#   build-essential \
#   cmake \
#   git \
#   libbullet-dev \
#   python3-colcon-common-extensions \
#   python3-flake8 \
#   python3-pip \
#   python3-pytest-cov \
#   python3-rosdep \
#   python3-setuptools \
#   python3-vcstool \
#   wget

# # install some pip packages needed for testing
# RUN python3 -m pip install -U \
#   argcomplete \
#   flake8-blind-except \
#   flake8-builtins \
#   flake8-class-newline \
#   flake8-comprehensions \
#   flake8-deprecated \
#   flake8-docstrings \
#   flake8-import-order \
#   flake8-quotes \
#   pytest-repeat \
#   pytest-rerunfailures \
#   pytest
# # install Fast-RTPS dependencies
# RUN apt-get install --no-install-recommends -y \
#   libasio-dev \
#   libtinyxml2-dev
# # install Cyclone DDS dependencies
# RUN apt-get install --no-install-recommends -y \
#   libcunit1-dev

# Add user
ARG UNAME="foxy"
ARG UID=1000
ARG GID=1000
ARG HOME=/home/${UNAME}
RUN useradd -rm -d ${HOME} -s /bin/bash -g root -G sudo,audio,video,plugdev -u ${UID} ${UNAME}
RUN mkdir -p /etc/sudoers.d && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
    chmod 0440 /etc/sudoers.d/${UNAME}

USER ${UNAME}
WORKDIR $HOME


RUN sudo apt-get update 
RUN DEBIAN_FRONTEND=noninteractive sudo apt-get install -y ros-foxy-desktop

RUN sudo apt-get install -y python3-pip
RUN pip3 install -U argcomplete
RUN sudo apt-get install python3-colcon-common-extensions

RUN DEBIAN_FRONTEND=noninteractive && sudo apt-get install -y build-essential \
    libusb-dev libspnav-dev libbluetooth-dev libcwiid-dev libncurses5-dev \
    libgl1-mesa-glx libgl1-mesa-dri mesa-utils \
    qt5-default  x11-apps \
    tmux vim \
    unzip ntp whois tree
RUN sudo apt-get install -y ~nros-foxy-rqt*


# clean up
RUN sudo apt-get autoremove --purge --yes \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/ros/rosdep/sources.list.d/20-default.list

RUN sudo apt-get update

# init colcon_ws workspace
RUN mkdir -p $HOME/dep_ws/src
RUN cd $HOME/dep_ws
RUN rosdep install -i --from-path src --rosdistro foxy -y

RUN cd $HOME
RUN mkdir -p $HOME/colcon_ws/src
RUN /bin/bash -c "source /opt/ros/foxy/setup.bash; cd ~/colcon_ws/;colcon build --symlink-install"


RUN echo "source /opt/ros/foxy/setup.bash" >> $HOME/.bashrc
RUN echo "export ROS_DOMAIN_ID=0" >> $HOME/.bashrc
RUN echo "" >> $HOME/.bashrc
RUN echo "alias cs='cd ~/colcon_ws/src'" >> $HOME/.bashrc
RUN echo "alias cm='cd ~/colcon_ws/ && colcon build --symlink-install'" >> $HOME/.bashrc
RUN echo "alias eb='vi ~/.bashrc'" >> $HOME/.bashrc
RUN echo "alias sb='source ~/.bashrc'" >> $HOME/.bashrc
RUN echo "alias killgazebo='killall -9 gazebo & killall -9 gzserver  & killall -9 gzclient'" >> $HOME/.bashrc