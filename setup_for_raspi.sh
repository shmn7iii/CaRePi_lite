#!/bin/bash

cd ~
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git vim python3 python3-pip alsa-base alsa-utils


# docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo apt-get install -y uidmap
dockerd-rootless-setuptool.sh install
echo 'export PATH=/usr/bin:$PATH' > ~/.bashrc
echo 'export DOCKER_HOST=unix:///run/user/1000/docker.sock' > ~/.bashrc
source ~/.bashrc
sudo setcap cap_net_bind_service=ep $HOME/bin/rootlesskit
sudo echo 'net.ipv4.ip_unprivileged_port_start=0' > sudo /etc/sysctl.conf
sudo sysctl --system


# CaRePi Lite
cd ~
git clone --recursive https://github.com/shmn7iii/CaRePi_lite.git


# Configure
echo -n "SLACK_BOT_TOKEN: "
read SLACK_BOT_TOKEN

echo -n "SLACK_APP_TOKEN: "
read SLACK_APP_TOKEN

echo -n "SLACK_CHANNEL: "
read SLACK_CHANNEL

sed -i -e "/api_url/c api_url = http://localhost/session" ~/CaRePi_lite/CaRePi_reader/config.ini
sed -i -e "/slack_bot_token/c slack_bot_token = $SLACK_BOT_TOKEN" ~/CaRePi_lite/CaRePi_reader/config.ini
sed -i -e "/slack_channel/c slack_channel = $SLACK_CHANNEL" ~/CaRePi_lite/CaRePi_reader/config.ini

sed -i -e "/SLACK_BOT_TOKEN/c SLACK_BOT_TOKEN = $SLACK_BOT_TOKEN" ~/CaRePi_lite/CaRePi_slack/.env
sed -i -e "/SLACK_APP_TOKEN/c SLACK_APP_TOKEN = $SLACK_APP_TOKEN" ~/CaRePi_lite/CaRePi_slack/.env


# API
cd ~/CaRePi_lite
echo -n "Put config/master.key... > (y)"
read str
docker compose up -d
docker compose exec rails bin/setup
docker compose down


# Reader
cd ~/CaRePi_lite/CaRePi_reader
sudo bash ./setup.sh


# Slack
cd ~/CaRePi_lite/CaRePi_slack
sudo bash ./setup.sh


# systemd
cd ~/CaRePi_lite
sudo cp ~/CaRePi_lite/carepi_lite.service /etc/systemd/system/carepi_lite.service
sudo cp ~/CaRePi_lite/carepi_reader.service /etc/systemd/system/carepi_reader.service
sudo cp ~/CaRePi_lite/carepi_slack.service /etc/systemd/system/carepi_slack.service
sudo systemctl daemon-reload
sudo systemctl enable carepi_lite
sudo systemctl enable carepi_reader
sudo systemctl enable carepi_slack
sudo systemctl start carepi_lite
sudo systemctl start carepi_reader
sudo systemctl start carepi_slack
