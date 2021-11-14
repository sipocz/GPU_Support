# python version: 3.8.10
sudo apt install python3-pip





pip install tensorflow  # tensorflow install v:  2.7.0 tensorflow-2.7.0-cp38-cp38-manylinux2010_x86_64.whl 
# DOC: https://www.tensorflow.org/install/pip
# CUDA toolkit https://developer.nvidia.com/cuda-toolkit-archive
# CUDA toolkit - driver  compatibility: https://docs.nvidia.com/cuda/cuda-toolkit-release-notes/index.html#cuda-major-component-versions__table-cuda-toolkit-driver-versions

#
sudo tee /etc/apt/preferences.d/cuda-repository-pin-600 > /dev/null <<EOL
Package: nsight-compute
Pin: origin *ubuntu.com*
Pin-Priority: -1

Package: nsight-systems
Pin: origin *ubuntu.com*
Pin-Priority: -1

Package: nvidia-modprobe
Pin: release l=NVIDIA CUDA
Pin-Priority: 600

Package: nvidia-settings
Pin: release l=NVIDIA CUDA
Pin-Priority: 600

Package: *
Pin: release l=NVIDIA CUDA
Pin-Priority: 100
EOL

#       

sudo apt install software-properties-common

#

NVIDIA_DRIVER_VERSION=$(sudo apt-cache search 'linux-modules-nvidia-[0-9]+-gcp$' | awk '{print $1}' | sort | tail -n 2 | head -n 1 | awk -F"-" '{print $4}')


#https://cloud.google.com/compute/docs/gpus/install-drivers-gpu#no-secure-boot

CUDA_DRIVER_VERSION=$(apt-cache madison cuda-drivers | awk '{print $3}' | sort -r | while read line; do
   if dpkg --compare-versions $(dpkg-query -f='${Version}\n' -W nvidia-driver-${NVIDIA_DRIVER_VERSION}) ge $line ; then
       echo "$line"
       break
   fi
done)

#



sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt install nvidia-driver-440

-- reboot

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget http://developer.download.nvidia.com/compute/cuda/11.0.2/local_installers/cuda-repo-ubuntu2004-11-0-local_11.0.2-450.51.05-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2004-11-0-local_11.0.2-450.51.05-1_amd64.deb
sudo apt-key add /var/cuda-repo-ubuntu2004-11-0-local/7fa2af80.pub
sudo apt update
sudo apt install cuda
