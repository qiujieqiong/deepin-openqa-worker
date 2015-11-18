# deepin-openqa-worker
**Description**: this project is the backend of the openQA server running on https://openqa.deepin.io  
Thanks to [os-autoinst](https://github.com/os-autoinst) for providing such a good frame.

## Dependencies
docker 1.8+ ([Docker Installation](http://docs.docker.com/engine/installation/))  
docker image: deepin/openqa-base ( [openQA-base](https://github.com/choldrim/deepin-openqa-base-runner) )
openQA webui server (a local or remote openQA webui environment is needed [openQA-webui](https://github.com/choldrim/deepin-openqa-webui))


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
make build
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
After running `openqa-webui-stop`, the container won't be removed from you machine.  
If you don't use it any more, just run `docker rm -f deepin/openqa-webui` to remove it.

