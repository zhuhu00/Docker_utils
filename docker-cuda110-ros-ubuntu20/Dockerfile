# Copyright (C) 2021, Hu Zhu, SUSTech
# email: zhuhu00@foxmail.com

FROM nvidia/cudagl:11.0-devel-ubuntu20.04

# ============以下内容在镜像中已有==zhuhu/cuda110-ros-ubuntu20:0.1=======
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

RUN apt update \
    &&  apt install -f \
    && apt install -y  libglew-dev \
        libcanberra-gtk-module \
        libxkbcommon-dev \
        libgoogle-glog-dev \
        caffe-cpu \
        libsnappy-dev \
        libatlas-base-dev \
        build-essential \
        liblmdb-dev  \
        libleveldb-dev \
        automake \
        autotools-dev \
        bison \
        byacc \
        curl \
        git \
        zip \
        unzip \
        wget \
        python3-dev \
        python3-pip  \
        libeigen3-dev \
        libboost-all-dev \
        protobuf-compiler \
        libprotobuf-dev \
        libhdf5-dev \
        libopencv-dev \
        python3-opencv \
        lsb-core  \
        openssh-server  \
        libssl-dev \
        libevent-dev \
        g++ \
        gdb \
        sudo \
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
RUN curl -kL https://bootstrap.pypa.io/pip/3.6/get-pip.py | python3 

# Add ROS repository
RUN /bin/bash -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
# Keys for ROS repository
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -\
# Install ROS-Base packages
    && apt-get update && apt install -f 
    
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y ros-noetic-desktop-full

# Install ROS bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python3-rosdep \
    python3-rosinstall \
    python3-vcstools \
    python3-rosinstall-generator \
    python3-wstool


# Set up rosdep
RUN rosdep init
RUN rosdep update

# 安装其他从源码安装的库
RUN mkdir ~/code_lib

#Pangolin
RUN cd ~/code_lib
RUN git clone https://github.com/stevenlovegrove/Pangolin.git \
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

# 安装其他相关软件
# Tools
RUN apt update && \
    apt install -y vim tmux xterm lxterminal

RUN sudo apt install -y pkg-config libegl1-mesa-dev libwayland-dev libxkbcommon-dev wayland-protocols \
    ros-noetic-octomap \ 
    ros-noetic-hector-trajectory-server

# 需要的其他库
RUN sudo apt install libpcl-dev libyaml-cpp-dev

# miniconda 为了搭建pytorch环境
RUN wget -c https://repo.anaconda.com/miniconda/Miniconda3-py37_4.11.0-Linux-x86_64.sh -O ~/miniconda.sh \
    && /bin/bash ~/miniconda.sh -b -p /opt/conda \
    && rm ~/miniconda.sh

COPY condarc /tmp
RUN cat /tmp/condarc >> ~/.bashrc && source ~/.bashrc && source /etc/profile

# 必须使用这句,才能换python环境
ENV PATH /opt/conda/bin:$PATH 
RUN python --version && pip -V
# 修改terminal颜色
RUN echo -e "\nPS1='\[\e[1;35m\]\u@\h:\[\e[0m\]\[\e[1;33m\]\w\[\e[1;35m\]\[\e[0m\]\[\e[1;34m\]\$ \[\e[0m\]'" >> /root/.bashrc

#  ===========分割线====以上为cuda102-ubuntu-ros的内容==========

#  ===========以下为自己可以添加的内容
# 以上构建成了docker镜像,可在官网拉取
# 根据不同的环境,可以在这里安装对应的依赖
RUN pip install protobuf==3.17.3 colorama
# RUN pip install tensorflow-gpu==1.15.2
# RUN conda install pytorch==1.7.1 torchvision==0.8.2 torchaudio==0.7.2 cudatoolkit=10.2 -c pytorch
RUN conda install -c conda-forge addict rospkg pycocotools
RUN pip install alfred-py scipy==1.7.0 pillow opencv-python


RUN pip install empy

# 创建ros空间, create catkin workspace
RUN mkdir -p /root/catkin_ws/src
WORKDIR /root/catkin_ws
RUN bash -c "source /opt/ros/noetic/setup.bash && \
             catkin_make -DCMAKE_BUILD_TYPE=Release"

# Load ROS environment at docker exec bash
RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc
##############################################

# # Build
# RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/usr/bin/python3"
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make -DCMAKE_BUILD_TYPE=Release"


# # Load ROS environment at each run
COPY ./ros_entrypoint.sh /
RUN chmod 755 /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]

WORKDIR /root/catkin_ws/src
