# deepin-openqa-worker
**Description**: this project is the backend of the openQA server running on https://openqa.deepin.io  
**Thanks**: Thanks to [os-autoinst](https://github.com/os-autoinst) group for providing such a good automated testing framework.

## Dependencies
docker 1.8+ ([Docker Installation](http://docs.docker.com/engine/installation/))  
docker image: deepin/openqa-base ([openQA-base](https://github.com/choldrim/deepin-openqa-base-runner))  
local or remote openQA server ([openQA-webui](https://github.com/choldrim/deepin-openqa-webui))


## Installation
#### 0. environment preparation
(1) prepare an on-service state openQA webui server
reference  [openQA-webui](https://github.com/choldrim/deepin-openqa-webui)

(2) prepare the `/data` dir for the default workspace  
```shell
sudo mkdir -p /data
sudo chmod 777 /data
```

#### 1. clone the code
```shell
git clone --recursive https://github.com/choldrim/deepin-openqa-worker
```

#### 2. prepare the worker container
```shell
cd deepin-openqa-worker
make ready  # reconfig & build source code
make build  # build container
```

#### 3. cp the tools to your PATH
```shell
sudo make install
```

#### 4. update the configures for your environment
there are two files needed to be checked before the worker startup  
```shell
/data/docker/openqa-worker/etc_openqa/client.conf
/data/docker/openqa-worker/etc_openqa/workers.conf
```
If your openQA server IP is `172.17.42.1`,  
keep the `client.conf` file containing:
```ini
[172.17.42.1]
key = 1234567890ABCDEG
secret = 1234567890ABCDEG
```

and `workers.conf` file shuld contain:
```ini
[0]
WORKER_CLASS = qemu_x86_64
HOST = http://172.17.42.1
```

## Usage
#### 1. start worker
```shell
openqa-worker-start   # after running this, your machine will start the deepin/openqa-worker container
```

#### 2. stop worker
```shell
openqa-worker-stop
```

## Uninstall
If you don't use it any more, just run `docker rm -f deepin/openqa-worker` to remove it.

### Relative
[openQA](https://github.com/os-autoinst/openQA)  
[os-autoinst](https://github.com/os-autoinst/os-autoinst)  
[deepin-openqa-base-runner](https://github.com/choldrim/deepin-openqa-base-runner)  
[deepin-openqa-webui](https://github.com/choldrim/deepin-openqa-webui)  
[deepin-openqa-worker](https://github.com/choldrim/deepin-openqa-worker)  
[deepin-openqa-task-trigger](https://github.com/choldrim/deepin-openqa-task-trigger)  
