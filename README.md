# Pre-requisites

- Server running Ubuntu 20.04 or 24.04
- Docker (>=27.5.0) & Docker Compose

| OS  | Supported ROS containers |
|---|---|
| Ubuntu 20.04 Focal Fossa  | ROS Noetic  |
| Ubuntu 24.04 Noble Numbat  | ROS Noetic<br>ROS2 Jazzy   |

## Installation with Ansible

## Ubuntu 20.04

```bash
sudo apt install ansible
./install.sh
```

## Ubuntu 24.04

1. Run install script

    ```bash
    sudo apt install ansible
    ./install.sh
    ```

2. Disable unified cgroup architecture (restart to take effect).
    ```
    # /etc/default/grub

    GRUB_CMDLINE_LINUX_DEFAULT="quiet splash systemd.unified_cgroup_hierarchy=0"
    ```

# (optional) Hardware accelerated containers

## Pre-requisites

| OS  |  Cuda version  | NVidia driver version  |
|---|---|---|
| 20.04  | 11.4.2  | **>=470** |
| 24.04  | 12.6.3  | **>=560** |

## Setup

1. Install nvidia-ctk toolkit

    ```
    sudo apt install nvidia-container-toolkit
    ```

2. Configure for Docker
    ```
    sudo nvidia-ctk runtime configure --runtime=docker
    sudo systemctl restart docker
    ```

### Ubuntu 24.04 additional steps
1. Since the VirtualGL setup does not work with Wayland (the default display server for 24.04) need to disable it to force Xorg (restart to take effect).
    ```
    #/etc/gdm3/custom.conf

    WaylandEnable=false
    ```
2. Enable xhost access for Docker:
    ```
    xhost +local:docker
    ```

## Running hardware accelerated containers

1. Build hardware accelerated images

    ```bash
    bash ./image-build.sh --nvidia
    ```

2. ...