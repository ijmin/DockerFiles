FROM arm64v8/ros:noetic

 
USER root
# ARG DEBIAN_FRONTEND=noninteractive

# set locales + etc
RUN apt-get update

RUN apt-get install -y \
  libusb-dev \
  libspnav-dev \
  libbluetooth-dev \
  libcwiid-dev \
  build-essential \
  cmake \
  git \
  python3-pip \
  wget

# clean up first
RUN apt-get autoremove --purge --yes \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/ros/rosdep/sources.list.d/20-default.list

# packages 설치
RUN rosdep init
RUN apt-get update 

# ARG ARCH=aarch64
# COPY --from=qemu /usr/bin/qemu-${ARCH}-static /usr/bin

# Add user
ARG UNAME="rpi"
ARG UID=1000
ARG GID=1000
ARG HOME=/home/${UNAME}
RUN useradd -rm -d ${HOME} -s /bin/bash -g root -G sudo,audio,video,plugdev -u ${UID} ${UNAME}
RUN mkdir -p /etc/sudoers.d && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
    chmod 0440 /etc/sudoers.d/${UNAME} 

USER ${UNAME}
WORKDIR $HOME


# # 생성된 USER 계정으로 실행
RUN sudo rosdep fix-permissions 
RUN rosdep update


# # init catkin workspace
RUN mkdir -p $HOME/catkin_ws/src
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash; cd catkin_ws/src; catkin_init_workspace; catkin_make -C ${HOME}/catkin_ws"


# # node들을 실행할때 필요한 환경변수들은 미리 초기화 한다.

RUN echo "alias eb='vi ~/.bashrc'" >> $HOME/.bashrc
RUN echo "alias sb='source ~/.bashrc'" >> $HOME/.bashrc
RUN echo "" >> $HOME/.bashrc
RUN echo "source /opt/ros/noetic/setup.bash" >> $HOME/.bashrc
RUN echo "source $HOME/catkin_ws/devel/setup.bash" >> $HOME/.bashrc
RUN echo "alias cw='cd ~/catkin_ws'" >> $HOME/.bashrc
RUN echo "alias cs='cd ~/catkin_ws/src'" >> $HOME/.bashrc
RUN echo "alias cm='catkin_make -C ~/catkin_ws/'" >> $HOME/.bashrc
RUN echo "" >> $HOME/.bashrc
RUN echo "export ROS_HOSTNAME=localhost" >> $HOME/.bashrc
RUN echo "export ROS_MASTER_URI=http://localhost:11311" >> $HOME/.bashrc
RUN echo "" >> $HOME/.bashrc
RUN echo "# export ROS_HOSTNAME=10.42.0.243" >> $HOME/.bashrc
RUN echo "# export ROS_MASTER_URI=http://10.42.0.1:11311" >> $HOME/.bashrc
RUN echo "" >> $HOME/.bashrc

#docker buildx build --platform linux/arm64/v8 -t rpi:4b_ros .
#docker buildx build --load --platform linux/arm64/v8 -t rpi:4b_ros .
