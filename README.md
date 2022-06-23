# CaRePi_lite

[CaRePi](https://github.com/shmn7iii/CaRePi) の軽量版

## Setup

Spec: Ubuntu 20.04

```bash
# Docker

$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh

# option: rootless mode

$ dockerd-rootless-setuptool.sh install

# Docker Compose

$ sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
```

```bash
$ git clone --recursive https://github.com/shmn7iii/CaRePi_lite.git
```

### 1. Setup Reader

[carepi_reader/config.ini](/CaRePi_reader/config.ini)

```
[CaRePi]
api_url = http://localhost:3000/session
service_code = 0x010B
block_code = 0
usb_bus_device = xxx:xxx:xxx
slack_bot_token = SLACK_BOT_TOKEN
slack_channel = SLACK_CHANNEL
```

### 2. Setup Lite API

```bash
$ docker-compose up -d
$ docker-compose exec rails bin/setup
```

### 3. Setup systemd

```bash
$ sudo cp ./carepi_lite.service /etc/systemd/system/carepi_lite.service
$ sudo cp ./carepi_reader.service /etc/systemd/system/carepi_reader.service

$ sudo systemctl daemon-reload
$ sudo systemctl enable carepi_lite
$ sudo systemctl enable carepi_reader

$ sudo systemctl start carepi_lite
$ sudo systemctl start carepi_reader
```
