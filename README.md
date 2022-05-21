# Docker_utils
一些经常使用的docker镜像及构建步骤
 - On MACbook(M1)：TBA

## log
- Add realsense-sdk and realsense-ros 
- Add Macbook M1 example, but it still has some issues.

# Requirements
- Nvidia GPU
- [Docker](https://docs.docker.com/engine/install/ubuntu/)
- [Nvidia Docker](https://github.com/NVIDIA/nvidia-docker)
- [Docker Compose](https://github.com/docker/compose)

# Docker demo
- [**cuda110-ros-ubuntu20**](./docker-cuda110-ros-ubuntu20)
- [**cuda102-ros-ubuntu18**](./docker-cuda102-ros-ubuntu18) 
- [**cuda100-ros-ubuntu16**](./docker-cuda100-ros-ubuntu16)
- [**docker-mac-m1**](./docker-mac-m1)


# How to use
Follow this [tutorial (如何优雅的使用Docker？)](https://zhuanlan.zhihu.com/p/482118286). After preparing these documents: `Dockerfile`, `docker-compose.yml`, `.env`, `ros_entrypoint.sh` and so on in the `docker` folder of your project . Using the following command:

```bash
cd docker
docker-compose build
docker-compose up
```

# Some issues
![](https://raw.githubusercontent.com/zhuhu00/img/master/2022-04-08-17-05-47.png)
```xhost +```

## Macbook M1 
一样的编译镜像方法，不过`rviz`启动不起来，`rosdep update`没办法更新，一直超时，很奇怪。

# Some Docker Repository Packages 
| Packages | Docker-Envs | Build status | Usage |
|----------|------|--------------|-------|
| [Faster-lio](https://github.com/gaoxiang12/faster-lio) | cuda110-ros-ubuntu20 | pass | [Usage](https://github.com/zhuhu00/faster-lio) |
| [LARVIO](https://github.com/zhuhu00/LARVIO) | cuda102-ros-ubuntu18 |  pass | [Usage](https://github.com/zhuhu00/LARVIO) |
| [SuMa]() |      | TODO | Usage |
| [SuMa++]() |      | TODO | Usage |

# Other materials
1. [docker-tutorial](https://github.com/twtrubiks/docker-tutorial)

