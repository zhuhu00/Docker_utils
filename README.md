# docker_utils
一些经常使用的docker镜像及构建步骤
 - On MACbook：TBA

## log
- Add realsense-sdk and realsense-ros 

# Requirements
- Nvidia GPU
- [Docker](https://docs.docker.com/engine/install/ubuntu/)
- [Nvidia Docker](https://github.com/NVIDIA/nvidia-docker)
- [Docker Compose](https://github.com/docker/compose)

# Docker demo
- Ubuntu18-ROS : 
- Ubuntu20-ROS :
- [**cuda110-ros-ubuntu20**](./docker-cuda110-ros-ubuntu20)
- [**cuda102-ros-ubuntu18**](./docker-cuda102-ros-ubuntu18)
- ubuntu16-ros : 
- [**cuda100-ros-ubuntu16**](./docker-cuda100-ros-ubuntu16)

# How to use
Follow this [tutorial(如何优雅的使用Docker？)](https://zhuanlan.zhihu.com/p/482118286). After preparing these documents: `Dockerfile`, `docker-compose.yml`, `.env`, `ros_entrypoint.sh` and so on in the `docker` folder of your project . Using the following command:

```bash
cd docker
docker-compose build
docker-compose up
```

# Some issues
![](https://raw.githubusercontent.com/zhuhu00/img/master/2022-04-08-17-05-47.png)
```xhost +```

# Some Repositories
- [faster-lio](https://github.com/gaoxiang12/faster-lio)
- [LARVIO](https://github.com/zhuhu00/LARVIO)


# Other materials
1. [docker-tutorial](https://github.com/twtrubiks/docker-tutorial)

