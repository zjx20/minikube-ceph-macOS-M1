#!/bin/bash

#export HTTP_PROXY=http://192.168.123.27:8001
#export HTTPS_PROXY=http://192.168.123.27:8001
#export NO_PROXY=.aliyuncs.com,localhost,127.0.0.1,10.96.0.0/12,192.168.59.0/24,192.168.49.0/24,192.168.39.0/24

#export EXTRA_CONFIG="--insecure-registry=localhost:5000"

currdir=$(cd $(dirname "$0"); pwd)
cd "$currdir" || exit 1

# from https://storage.googleapis.com/kubernetes-release/release/stable.txt
export KUBE_VERSION=v1.28.3

export MINIKUBE_ARCH=arm64
export VM_DRIVER=qemu2
export CNI=auto
export RESOLV_CONF=/etc/resolv.conf
export CPUS=$(sysctl -n hw.logicalcpu)
export MEMORY=4096
export DISK_SIZE=20

./minikube.sh up
