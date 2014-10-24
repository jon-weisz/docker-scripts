#!/bin/bash
echo "Installing nvidia stuff"

sudo apt-get update
sudo apt-get -y install --force-yes install x-window-system
sudo apt-get install -y binutils mesa-utils module-init-tools

NVIDIA_INSTALL_BIN=/mnt/nvidia-run.sh

sudo sh $NVIDIA_INSTALL_BIN -a -N --ui=none --no-kernel-module -q --kernel-source-path=/mnt/linux-src
rm $NVIDIA_INSTALL_BIN

