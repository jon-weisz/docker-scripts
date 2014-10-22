#!/bin/bash
echo "Installing nvidia stuff"

sudo apt-get update
sudo apt-get -y install --force-yes install x-window-system
sudo apt-get install -y binutils mesa-utils module-init-tools

NVIDIA_INSTALL_BIN=$1

sudo sh $NVIDIA_INSTALL_BIN -a -N --ui=none --no-kernel-module -q
rm $NVIDIA_INSTALL_BIN

