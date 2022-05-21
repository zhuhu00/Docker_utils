# Copyright (C) 2021, Hu Zhu, SUSTech
# email: zhuhu00@foxmail.com

FROM ubuntu:18.04

# ============以下内容在镜像中已有==zhuhu/cuda110-ros-ubuntu18:0.1=======
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# 将sh改为bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && apt-get install -y tzdata


RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        sudo \
        lxde \
        xrdp \
        ibus \
        ibus-mozc \
        language-pack-ja-base \
        language-pack-ja \
        fonts-noto-cjk \
        fonts-noto-color-emoji \
        supervisor \
        gosu \
        build-essential \
        curl \
        less \
        apt-utils \
        tzdata \
        git \
        tmux \
        bash-completion \
        command-not-found \
        libglib2.0-0 \
        gstreamer1.0-plugins-* \
        libgstreamer1.0-* \
        libgstreamer-plugins-*1.0-* \
        vim \
        emacs \
        ssh \
        rsync \
        python3-pip \
        sed \
        ca-certificates \
        wget \
        lsb-release \
        gnupg\
        libssl-dev\
        curl

# Install cmake
# RUN apt-get purge -y cmake \
#     && cd /tmp \
#     && wget -c https://github.com/Kitware/CMake/releases/download/v3.18.1/cmake-3.18.1.tar.gz \
#     && tar -xzvf cmake-3.18.1.tar.gz \
#     && cd cmake-3.18.1 \
#     && ./bootstrap && make && make install\
#     && rm cmake-3.18.1 -rf 

# update pip
RUN curl -kL https://bootstrap.pypa.io/pip/2.7/get-pip.py | python  \
    && curl -kL https://bootstrap.pypa.io/pip/3.6/get-pip.py | python3 



# Add ROS repository
# RUN /bin/bash -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
RUN  /bin/bash -c '. /etc/lsb-release && echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list'  \
    && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -\
    && apt update && apt install -f && apt-get install -y ros-melodic-desktop-full

# Keys for ROS repository
    # apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && \
# Install ROS-Base packages

# Install ROS bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    python-rosinstall-generator \
    python-wstool

# Set up rosdep
RUN rosdep init
# RUN sudo rosdep fix-permissions 
# RUN rosdep update
RUN echo -e "\nsource /opt/ros/melodic/setup.bash" >> /root/.bashrc


# 安装其他从源码安装的库
RUN mkdir ~/code_lib

RUN apt install -y libglew-dev

#Pangolin
RUN cd ~/code_lib
RUN git clone https://github.com/stevenlovegrove/Pangolin.git \
    && cd Pangolin \
    && mkdir build && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=Release \
    && make -j 3 \
    && make install \
    && cd ~

RUN apt install -y libgoogle-glog-dev libgflags-dev


# Ceres install
RUN cd ~/code_lib
RUN wget -c http://ceres-solver.org/ceres-solver-1.14.0.tar.gz -O ~/code_lib/ceres.tar.gz \
    && cd ~/code_lib \
    && tar zxf ceres.tar.gz \
    && pwd && ls\
    && cd ceres-solver-1.14.0 \
    && mkdir build \
    && cd build\
    && cmake .. -DCMAKE_BUILD_TYPE=Release  \
    && make -j4   \
    && make install \ 
    && cd ~


# 安装其他相关软件
# Tools
RUN apt update && \
    apt install -y vim tmux terminator lxterminal

RUN sudo apt install -y pkg-config libegl1-mesa-dev libwayland-dev libxkbcommon-dev wayland-protocols \
    ros-melodic-octomap \ 
    ros-melodic-hector-trajectory-server

# 需要的其他库
RUN sudo apt install -y libpcl-dev libyaml-cpp-dev

# # miniconda 为了搭建pytorch环境
# RUN wget -c https://repo.anaconda.com/miniconda/Miniconda3-py37_4.11.0-Linux-x86_64.sh -O ~/miniconda.sh \
#     && /bin/bash ~/miniconda.sh -b -p /opt/conda \
#     && rm ~/miniconda.sh

# COPY condarc /tmp
# RUN cat /tmp/condarc >> ~/.bashrc && source ~/.bashrc && source /etc/profile

# 必须使用这句,才能换python环境
# ENV PATH /opt/conda/bin:$PATH 
# RUN python --version && pip -V
# 修改terminal颜色
RUN echo -e "\nPS1='\[\e[1;35m\]\u@\h:\[\e[0m\]\[\e[1;33m\]\w\[\e[1;35m\]\[\e[0m\]\[\e[1;34m\]\$ \[\e[0m\]'" >> /root/.bashrc

#  ===========分割线====添加backward-cpp=START=========
RUN apt install -y libdw-dev&&\
    wget https://raw.githubusercontent.com/bombela/backward-cpp/master/backward.hpp&&\
    sudo mv backward.hpp /usr/include
#  ===========分割线====添加backward-cpp=END==========

# Realsense sdk and ros package
# realsense-sdk
# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
# RUN add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u
# RUN apt-get install -y librealsense2-dkms librealsense2-utils librealsense2-dev

# Realsense ROS
# RUN cd ~/code_lib &&\
#     mkdir -p ~/code_lib/catkin_realsense/src&&\
#     cd ~/code_lib/catkin_realsense/src &&\
#     git clone -b 2.3.2 https://github.com/IntelRealSense/realsense-ros.git &&\
#     cd ..&&\
#     /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make clean && catkin_make -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release"&&\
#     echo -e "\nsource ~/code_lib/catkin_realsense/devel/setup.bash" >> ~/.bashrc&&\
#     echo -e "\nsource /opt/ros/noetic/setup.bash" >> /root/.bashrc


#  ===========分割线====以上为zhuhu/cuda110-ubuntu-ros的内容==========

#  ===========以下为自己可以添加的内容
# 以上构建成了docker镜像,可在官网拉取
# 根据不同的环境,可以在这里安装对应的依赖
# RUN pip install tensorflow-gpu==1.15.2
# RUN conda install pytorch==1.7.1 torchvision==0.8.2 torchaudio==0.7.2 cudatoolkit=10.2 -c pytorch

# 创建ros空间, create catkin workspace
RUN mkdir -p /root/catkin_ws/src
# WORKDIR /root/catkin_ws
# RUN bash -c "source /opt/ros/melodic/setup.bash && \
#              catkin_make -DCMAKE_BUILD_TYPE=Release"

# Load ROS environment at docker exec bash
# RUN echo -e "\nsource /opt/ros/melodic/setup.bash" >> /root/.bashrc
# RUN echo -e "\nsource /root/catkin_ws/devel/setup.bash" >> /root/.bashrc
##############################################

# # Build
# RUN /bin/bash -c "source /opt/ros/melodic/setup.bash && catkin_make -DCMAKE_BUILD_TYPE=Release"

RUN apt install -y xterm

# # Load ROS environment at each run
COPY ./ros_entrypoint.sh /
RUN chmod 755 /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]

WORKDIR /root/catkin_ws/src
