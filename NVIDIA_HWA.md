## Hardware accelerated containers

### Pre-requisites

| OS  |  Cuda version  | NVidia driver version  |
|---|---|---|
| 20.04  | 11.4.2  | **>=470** |
| 24.04  | 12.6.3  | **>=560** |

### Setup

1. Install [nvidia-ctk toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

2. Configure for Docker

    ```
    sudo nvidia-ctk runtime configure --runtime=docker
    sudo systemctl restart docker
    ```

**Ubuntu 24.04 additional steps**

1. Since the VirtualGL setup does not work with Wayland (the default display server for 24.04) need to disable it to force Xorg (restart to take effect).

    ```
    #/etc/gdm3/custom.conf

    WaylandEnable=false
    ```

2. Enable xhost access for Docker:

    ```
    xhost +local:docker
    ```

### Running hardware accelerated containers

1. Build hardware accelerated image versions

    ```bash
    bash ./image-build.sh --target <noetic|jazzy> --nvidia
    ```

2. Rebuild docker compose templates to use hardware-accelerated image versions

    ```bash
	cd remrob-app/remrob-server/compose && python compose_generator.py --nvidia
	```

By default will use X1 display socket for VirtualGL rendering, but if your system uses a different one, then it can be specified with the `--xsocket` flag. e.g.

```bash
python compose_generator.py --nvidia --xsocket X0
```

In Remrob app the hardware-accelerate image versions will automatically take precedence over the base versions (see `remrob-app/remrob-server/config/default.json`)