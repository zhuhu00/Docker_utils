# version 0.1
# hu zhu, zhuhu00@foxmail.com, SUSTech, 02.28.2022
FROM nvidia/cudagl:10.0-devel-ubuntu16.04

# ============以下内容在镜像已有=zhuhu/cuda100-ros-ubuntu16========
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# 将sh改为bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# RVIZ的使用及其他图形化应用的使用
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# Setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && apt-get install -y tzdata

# Install the Nvidia cuDNN library missing in the parent image.
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcudnn7=7.6.5.32-1+cuda10.0 \
    libcudnn7-dev=7.6.5.32-1+cuda10.0 \
    && apt-mark hold libcudnn7 \
    && rm -rf /var/lib/apt/lists/*

# Install tools for development
RUN apt-get update && \
    apt-get install -y software-properties-common \
    vim\
    tmux\
    xterm\
    lxterminal\
    openssh-server  \
    xclip\
    graphviz\
    sudo \
    byobu \
    gdb \
    htop \
    wget \
    git \
    curl \
    zip \
    unzip \
    g++ \
    libevent-dev \
    bison \
    byacc \
    autotools-dev \
    automake \
    libgdbm-dev \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    autoconf \
    bison \
    libyaml-dev \
    dirmngr \
    gnupg \
    git \
    libxkbcommon-dev \
    libgoogle-glog-dev \
    libeigen3-dev \
    libopencv-dev \
    python-dev\
    python3-dev\
    python-pip\
    python3-pip\
    python3-opencv \
    libcanberra-gtk-module \
    libsnappy-dev \
    # libboost-all-dev \
    libprotobuf-dev \
    libhdf5-dev \
    libglew-dev\
    build-essential \
    libffi-dev \
    libncurses5-dev \
    libssl-dev \
    libreadline-dev \
    perltidy \
    zlib1g-dev && \
    apt install -f \
    && rm -rf /var/lib/apt/lists/*

# Install cmake
RUN apt-get purge -y cmake \
    && cd /tmp \
    && wget -c https://github.com/Kitware/CMake/releases/download/v3.18.1/cmake-3.18.1.tar.gz \
    && tar -xzvf cmake-3.18.1.tar.gz \
    && cd cmake-3.18.1 \
    && ./bootstrap && make && make install \
    && rm cmake-3.18.1 -rf 

## update pip
RUN curl -kL https://bootstrap.pypa.io/pip/2.7/get-pip.py | python  \
    && curl -kL https://bootstrap.pypa.io/pip/3.5/get-pip.py | python3 

# Install ROS-Base packages
RUN bash -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add - \
    && apt-get update && apt install -f && apt-get install -y ros-kinetic-desktop-full

# Install ROS bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    python-rosinstall-generator \
    python-wstool

# Set up rosdep
RUN rosdep init
RUN rosdep update
RUN echo -e "\nsource /opt/ros/kinetic/setup.bash" >> /root/.bashrc

# 安装其他从源码安装的库
WORKDIR /root/code_lib

#Pangolin
RUN cd ~/code_lib
RUN git clone -b v0.5 https://github.com/stevenlovegrove/Pangolin.git \
    && cd Pangolin \
    && mkdir build && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=Release \
    && make -j 3 \
    && make install \
    && cd ~

# Ceres install
RUN cd ~/code_lib
RUN wget -c http://ceres-solver.org/ceres-solver-2.0.0.tar.gz -O ~/code_lib/ceres.tar.gz \
    && cd ~/code_lib \
    && tar zxf ceres.tar.gz \
    && pwd && ls\
    && cd ceres-solver-2.0.0 \
    && mkdir build \
    && cd build\
    && cmake .. -DCMAKE_BUILD_TYPE=Release  \
    && make -j4   \
    && make install \ 
    && cd ~

WORKDIR /root
# 安装其他相关软件
# Tools
RUN sudo apt install -y pkg-config libegl1-mesa-dev libwayland-dev  \
    ros-kinetic-octomap* \ 
    ros-kinetic-hector-trajectory-server

# 修改terminal颜色
RUN echo -e "\nPS1='\[\e[1;35m\]\u@\h:\[\e[0m\]\[\e[1;33m\]\w\[\e[1;35m\]\[\e[0m\]\[\e[1;34m\]\$ \[\e[0m\]'" >> /root/.bashrc
RUN cat /root/.bashrc

#  ===========分割线====以上为cuda100-ros-ubuntu16的内容==========

RUN cd ~/code_lib && git clone https://github.com/yubaoliu/caffe-segnet.git 

WORKDIR /root/catkin_ws/src
# # Load ROS environment at each run
COPY ./ros_entrypoint.sh /
RUN chmod 755 /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]