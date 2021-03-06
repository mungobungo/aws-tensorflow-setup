#!/bin/bash

# stop on error
set -e
############################################
# install into /mnt/bin
sudo mkdir -p /mnt/bin
sudo chown ubuntu:ubuntu /mnt/bin

##############################################
# preparing big partition
mkdir ~/nd013
sudo mkfs.ext3 /dev/xvdb
sudo sh -c "echo '/dev/xvdb /home/ubuntu/nd013 	ext4 	defaults,discard 0 0 ' >> /etc/fstab"
sudo mount -a
sudo chown  ubuntu:ubuntu -R nd013

# install the required packages
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get -y install linux-headers-$(uname -r) linux-image-extra-`uname -r`

# install cuda
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_7.5-18_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1404_7.5-18_amd64.deb
rm cuda-repo-ubuntu1404_7.5-18_amd64.deb
sudo apt-get update
sudo apt-get install -y cuda

# get cudnn
CUDNN_FILE=cudnn-7.0-linux-x64-v4.0-prod.tgz
wget http://developer.download.nvidia.com/compute/redist/cudnn/v4/${CUDNN_FILE}
tar xvzf ${CUDNN_FILE}
rm ${CUDNN_FILE}
sudo cp cuda/include/cudnn.h /usr/local/cuda/include # move library files to /usr/local/cuda
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
rm -rf cuda

# set the appropriate library path
echo 'export CUDA_HOME=/usr/local/cuda
export CUDA_ROOT=/usr/local/cuda
export PATH=$PATH:$CUDA_ROOT/bin:$HOME/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_ROOT/lib64
' >> ~/.bashrc

# install anaconda
wget http://repo.continuum.io/archive/Anaconda2-4.1.1-Linux-x86_64.sh
bash Anaconda2-4.1.1-Linux-x86_64.sh -b -p /mnt/bin/anaconda2
rm Anaconda2-4.1.1-Linux-x86_64.sh
echo 'export PATH="/mnt/bin/anaconda2/bin:$PATH"' >> ~/.bashrc

# install tensorflowi

# Ubuntu/Linux 64-bit, GPU enabled, Python 2.7
# Requires CUDA toolkit 7.5 and CuDNN v5. For other versions, see "Install from sources" below.
export TF_BINARY_URL='https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.10.0-cp27-none-linux_x86_64.whl'

/mnt/bin/anaconda2/bin/pip install $TF_BINARY_URL


# install libs
sudo apt-get install python-pip python-dev -y

sudo apt-get install python-opencv -y
sudo apt-get install liblapack-dev -y

#sudo pip install virtualenv
# reload .bashrc
exec bash

############################################
# run the test
# byobu				# start byobu + press Ctrl + F2 
# htop				# run in window 1, press Shift + F2
# watch --color -n1.0 gpustat -cp	# run in window 2, press Shift + <left>
# wget https://raw.githubusercontent.com/tensorflow/tensorflow/master/tensorflow/models/image/mnist/convolutional.py
# python convolutional.py		# run in window 3
