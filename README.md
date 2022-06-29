# Docker_utils
一些经常使用的docker镜像及构建步骤

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
- Ubuntu18-ros-gui: 无GPU，包含ros所需的库，以及可以使用浏览器或者vnc进行访问的docker镜像，来源于[AlexGeControl](https://github.com/AlexGeControl/Sensor-Fusion-for-Localization-Courseware)


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
需要先安装`socat`和`xquartz`，用`brew install xxx`就可以。
之后需要配置`xquartz`，打开命令：`open -a Xquartz`使得其能够通过网络连接，在设置->安全性->勾选上允许从网络客户端连接。之后关闭Xquartz，接着命令行中输入：
```bash
# 配置socat，命令没有输出，也不能中断，保持运行即可。
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"

# 之后输入：
ifconfig en0
# 看ip地址上是什么，之后修改启动容器时的DISPLAY
export DISPLAY=192.168.0.106:0
# 可以直接在docker-compose.yaml文件修改
```
之后就能成功运行镜像了，不过还有一些问题。

- `rviz`启动不起来，
- `rosdep update`没办法更新，一直超时，很奇怪。



# Some Docker Repository Packages 
| Packages | Docker-Envs | Build status | Usage |
|----------|------|--------------|-------|
| [Faster-lio](https://github.com/gaoxiang12/faster-lio) | cuda110-ros-ubuntu20 | pass | [Usage](https://github.com/zhuhu00/faster-lio) |
| [LARVIO](https://github.com/zhuhu00/LARVIO) | cuda102-ros-ubuntu18 |  pass | [Usage](https://github.com/zhuhu00/LARVIO) |
| [SuMa]() |      | TODO | Usage |
| [SuMa++]() |      | TODO | Usage |

# Other materials
1. [docker-tutorial](https://github.com/twtrubiks/docker-tutorial)
2. [实现Mac主机上的Docker容器中的图形界面显示（运行GUI应用）](https://www.cnblogs.com/noluye/p/11405358.html)
