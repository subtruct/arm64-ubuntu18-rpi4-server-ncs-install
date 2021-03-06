#!/bin/bash -x
# initialization
cd && sudo apt -y update && sudo apt -y upgrade && sudo apt-get dist-upgrade
sudo apt -y install wget mc wget git python python3 python-pip python3-pip python3.6-dev
#if any trouble use...
#sudo python3 -m pip uninstall pip && sudo apt install python3-pip --reinstall 
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1
#wget https://bootstrap.pypa.io/get-pip.py
#sudo python3 get-pip.py --user
#pip3 install virtualenv virtualenvwrapper
export OpenCV_DIR=/usr/local/opencv4
export PATH=$PATH:/home/ubuntu/.local/bin
alias python=python3.7
alias pip=pip3

#System lib&tools
cd && sudo apt -y install build-essential unzip pkg-config yum
sudo apt -y install libjpeg-dev libpng-dev libtiff-dev
sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt -y install libxvidcore-dev libx264-dev
sudo apt -y install libcanberra-gtk*
sudo apt -y install libatlas-base-dev gfortran
sudo apt -y install libtbb2 libtbb-dev libdc1394-22-dev  libgtk-3-dev 

#-- Pip3 depenzenses libs & tools & settings
pip3 install pillow --upgrade
pip3 install numpy
pip3 install scikit-image
pip3 install google #caffe dependences 
pip3 install protobuf pyyaml 

#Custom NCS SDK/API Installation
#cd && one https://github.com/markjay4k/ncsdk-aarch64.git
#git clone https://github.com/subtruct/arm64-ubuntu18-rpi4-server-ncs-install.git
#udo cp ~/arm64-ubuntu18-rpi4-server-ncs-install/ncsdk.conf ~/ncsdk-aarch64
#sudo cp ~/arm64-ubuntu18-rpi4-server-ncs-install/ncsdk.conf ~/ncsdk-aarch64/NCSDK-1.12.00.01/ncsdk-aarch64
#cd ~/ncsdk-aarch64
#sudo make install
#sudo make api3##

cd && wget https://github.com/Kitware/CMake/releases/download/v3.14.4/cmake-3.14.4.tar.gz
tar xvzf cmake-3.14.4.tar.gz
cd ~/cmake-3.14.4
./bootstrap
make clean
make –j4
sudo make install

#--NCS SDK/API on Ubuntu18.1. Build.2019.3.376
#cd && wget https://download.01.org/opencv/2019/openvinotoolkit/R3/l_openvino_toolkit_dev_ubuntu18_p_2019.3.376.tgz
#tar -xvzf l_openvino_toolkit_dev_ubuntu18_p_2019.3.376.tgz
cd 
#wget https://download.01.org/opencv/2019/openvinotoolkit/R3/l_openvino_toolkit_runtime_ubuntu18_p_2019.3.376.tgz
wget https://download.01.org/opencv/2019/openvinotoolkit/R3/l_openvino_toolkit_runtime_raspbian_p_2019.3.334.tgz
#git clone https://github.com/openvinotoolkit/openvino.git
#tar -xf l_openvino_toolkit_runtime_ubuntu18_p_2019.3.376.tgz
#sudo cp -R ./l_openvino_toolkit_runtime_raspbian_p_2019.2.242 /srv/chroot/buster_armhf/
cp ~/l_openvino_toolkit_runtime_raspbian_p_2019.3.334 ~/dldt -r
cd ~/dldt/inference_engine
#cd ~/openvino/
####git submodule init
####git submodule update --recursive
#sh install_build_dependencies.sh
./install_dependencies.sh
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release -DENABLE_MKL_DNN=OFF -DENABLE_CLDNN -DENABLE_GNA=OFF -DENABLE_SSE42=OFF -DTHREADING=SEQ ..
make clean
make –j4
sudo make install
sudo ln -s /usr/local/lib/python3.7/dist-packages/mvnc .
sudo ln -s /usr/local/lib/python3.7/dist-packages/graphviz .
sudo cp -R ~/dldt/python/python3.7/* /usr/local/lib/python3.7/dist-packages/
sudo cp -R ~/dldt/deployment_tools/inference_engine/lib/intel64/* /usr/local/lib/python3.7/dist-packages/openvino/inference_engine/
cd && source ~/dldt/bin/setupvars.sh
sudo sh ~/dldt/install_dependencies/install_NCS_udev_rules.sh
echo "source ~/dldt/bin/setupvars.sh" >> ~/.bashrc
sudo usermod -a -G users "$(whoami)"

#--OPEN-CV Installation
cd
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.1.1.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.1.1.zip
unzip opencv.zip
unzip opencv_contrib.zip
mv opencv-4.1.1/ opencv/
mv opencv_contrib-4.1.1/ opencv_contrib/
cd ~/opencv
mkdir build && cd build 
cmake -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D PYTHON3_EXECUTABLE=/usr/bin/python3.7 \
      -D PYTHON3_INCLUDE_DIR=/usr/include/python3.7m \
      -D PYTHON3_PACKAGES_PATH=/usr/lib/python3.7/dist-packages \
      -D PYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3.7 \
      -D BUILD_OPENCV_PYTHON3=yes \
      -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
      -D CMAKE_BUILD_TYPE=Release \
      -D WITH_IPP=OFF \
      -D BUILD_TESTS=OFF \
      -D BUILD_PERF_TESTS=OFF \
      -D BUILD_EXAMPLES=OFF \
      -D ENABLE_PRECOMPILED_HEADERS=OFF \
      -D ENABLE_NEON=ON \
      -D WITH_INF_ENGINE=ON \
      -D INF_ENGINE_LIB_DIRS="~/dldt/deployment_tools/inference_engine/lib/intel64" \
      -D INF_ENGINE_INCLUDE_DIRS="~/dldt/deployment_tools/inference_engine/include" \
      -D CMAKE_FIND_ROOT_PATH="~/dldt/" .. 
make clean
make -j4
sudo make install

# BASHRC
echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.bashrc
#echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
#echo "export WORKON_HOME=$HOME/.venvs" >> ~/.bashrc
#echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3.6" >> ~/.bashrc
#echo "export OpenCV_DIR=/usr/local/opencv4" >> ~/.bashrc
#echo "export PATH=/home/ubuntu/.local/bin:/home/ubuntu/.virtualenvs/cv/bin"
#echo "source $WORKON_HOME/cv/bin/activate" >> ~/.bashrc
echo "export PATH=$PATH:/home/ubuntu/.local/bin" >> ~/.bashrc
echo "alias python=python3.7" >> ~/.bashrc
echo "alias pip=pip3" >> ~/.bashrc
source ~/.bashrc


#-- Link to source files  
#cd ~/.virtualenvs/cv/lib/python3.6/site-packages/
#sudo mv cv2.so cv2.so.bak
#sudo ln -s /usr/local/lib/python3.6/site-packages/cv2.cpython-32mu.so cv2.so

#--Tensorflow silent installation
#cd && git clone https://github.com/markjay4k/Tensorflow-1.9rc0-py36-aarch64.git
#sudo apt install Tensorflow-1.9rc0-py36-aarch64/tensorflow-1.9.0rc0-cp36-cp36m-linux_aarch64.whl
#sudo reboot 
