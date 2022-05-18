# version 0.1
# hu zhu, zhuhu00@foxmail.com, SUSTech, 02.28.2022
FROM zhuhu/cuda100-ros-ubuntu16:0.2

# ===================Add some new packages to your envs============
# 修改terminal颜色
RUN echo -e "\nPS1='\[\e[1;35m\]\u@\h:\[\e[0m\]\[\e[1;33m\]\w\[\e[1;35m\]\[\e[0m\]\[\e[1;34m\]\$ \[\e[0m\]'" >> /root/.bashrc
RUN cat /root/.bashrc

WORKDIR /root/catkin_ws/src
# # Load ROS environment at each run
COPY ./ros_entrypoint.sh /
RUN chmod 755 /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]