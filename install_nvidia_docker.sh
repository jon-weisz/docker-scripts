#!/bin/sh

NVIDIA_DIR=/proc/driver/nvidia

if test ! -d $NVIDIA_DIR; then
    echo "NVIDIA driver not installed yet. Driver must be installed on host first"
    return -1
fi

# Get your current host nvidia driver version, e.g. 340.24
nvidia_version=$(cat $NVIDIA_DIR/version | head -n 1 | awk '{ print $8 }')

# We must use the same driver in the image as on the host
if test ! -f nvidia-driver.run; then
  nvidia_driver_uri=http://us.download.nvidia.com/XFree86/Linux-x86_64/${nvidia_version}/NVIDIA-Linux-x86_64-${nvidia_version}.run
  wget -O nvidia-driver.run $nvidia_driver_uri
fi

DOCKER_IMAGE=$1
echo $DOCKER_IMAGE
NVIDIA_SCRIPT_INTERNAL=/mnt/install_nvidia_internal.sh

docker run --name="install-nvidia" -i -t -v  $PWD:/mnt $DOCKER_IMAGE $NVIDIA_SCRIPT_INTERNAL 
#docker start install-nvidia
docker attach install-nvidia
