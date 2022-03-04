#!/bin/bash
set -e

# setup ros environment
echo "ROS workspace: /root/catkin_ws"
source "/opt/ros/kinetic/setup.bash"
source "/root/catkin_ws/devel/setup.bash"

echo "compile caffe-segnet"
# cd /root/caffe-segnet
# [ ! -d "build" ] && mkdir build 
# cd build
# cmake .. -DCMAKE_BUILD_TYPE=Release  -DCMAKE_INSTALL_PREFIX=/usr/local
# make -j${nproc} && make install


echo "Build DSSLAM"
# cd /root/catkin_ws/src/DS-SLAM
# bash DS_SLAM_BUILD.sh

exec "$@"