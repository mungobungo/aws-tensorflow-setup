#!/bin/bash
cd ~/nd013
conda create -n python2 python=2.7 anaconda
source activate python2
conda install -y -c menpo opencv3=3.1.0
pip install https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.10.0-cp27-none-linux_x86_64.whl
pip install keras

echo "keras installed"
# install monitoring programs
sudo wget https://git.io/gpustat.py -O /usr/local/bin/gpustat
sudo chmod +x /usr/local/bin/gpustat
sudo nvidia-smi daemon
sudo apt-get -y install htop

# reload .bashrc
exec bash

