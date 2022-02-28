# docker_utils
一些经常使用的docker镜像及构建步骤

# Requirements
- Nvidia GPU
- [Docker](https://docs.docker.com/engine/install/ubuntu/)
- [Nvidia Docker](https://github.com/NVIDIA/nvidia-docker)
- [Docker Compose](https://github.com/docker/compose)

# Docker demo
- Ubuntu18-ROS :
- Ubuntu20-ROS :
- cuda110-ros-ubuntu20 : 
- cuda102-ros-ubuntu18 : 
- ubuntu16-ros : 
- cuda100-ros-ubuntu16 :

# How to use
Follow this [tutorial(如何优雅的使用Docker？)](TBA). After preparing these documents: `Dockerfile`, `docker-compose.yml`, `.env`, `ros_entrypoint.sh` and so on in the `docker` folder of your project . Using the following command:

```bash
cd docker
docker-compose build
docker-compose up
```

# Some Repositories
- [faster-lio](https://github.com/gaoxiang12/faster-lio)
- [LARVIO](https://github.com/zhuhu00/LARVIO)


# Other materials
1. [docker-tutorial](https://github.com/twtrubiks/docker-tutorial)
2. 