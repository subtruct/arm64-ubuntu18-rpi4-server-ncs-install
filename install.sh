#!/bin/bash -x
# initialization
cd && sudo apt -y update && sudo apt -y upgrade && sudo apt-get dist-upgrade
sudo apt -y install wget mc python python3 python-pip python3-pip python3.6-dev
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
wget https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
pip3 install virtualenv virtualenvwrapper
# virtualenv and virtualenvwrapper
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.bashrc
echo "export WORKON_HOME=$HOME/.venvs" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3.6" >> ~/.bashrc
#echo "export OpenCV_DIR=/usr/local/opencv4" >> ~/.bashrc
echo "export PATH=/home/ubuntu/.local/bin:/home/ubuntu/.virtualenvs/cv/bin"
echo "source $WORKON_HOME/cv/bin/activate" >> ~/.bashrc
echo "alias python=python3.6" >> ~/.bashrc
echo "alias pip=pip3" >> ~/.bashrc
source ~/.bashrc

#System lib&tools
cd && sudo apt -y install build-essential unzip pkg-config
sudo apt -y install libjpeg-dev libpng-dev libtiff-dev
sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt -y install libxvidcore-dev libx264-dev
sudo apt -y install libcanberra-gtk*
sudo apt -y install libatlas-base-dev gfortran
sudo apt -y install libtbb2 libtbb-dev libdc1394-22-dev  libgtk-3-dev 

#-- Pip3 depenzenses libs & tools & settings
sudo pip3 install numpy && sudo pip3 install scikit-image 
sudo pip3 install google #caffe dependences 
sudo pip3 install protobuff pyyaml



#Custom NCS SDK/API Installation
#cd && one https://github.com/markjay4k/ncsdk-aarch64.git
#git clone https://github.com/subtruct/arm64-ubuntu18-rpi4-server-ncs-install.git
#udo cp ~/arm64-ubuntu18-rpi4-server-ncs-install/ncsdk.conf ~/ncsdk-aarch64
#sudo cp ~/arm64-ubuntu18-rpi4-server-ncs-install/ncsdk.conf ~/ncsdk-aarch64/NCSDK-1.12.00.01/ncsdk-aarch64
#cd ~/ncsdk-aarch64
#sudo make install
#sudo make api3##

#--OPEN-CV Installation
cd && git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
cd ~/opencv
mkdir build && cd build 
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
    -D ENABLE_NEON=ON \
    -D ENABLE_VFPV3=ON \
    -D BUILD_TESTS=OFF \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D BUILD_EXAMPLES=ON \
    -D BUILD_opencv_python2=False \
    -D BUILD_opencv_python3=True \
    -D PYTHON_DEFAULT_EXECUTABLE=python3 \
    -D PYTHON_EXECUTABLE=python3 \
make -j4
sudo make install

#--NCS SDK/API on Ubuntu18.1. Build.2019.3.376
#cd && wget https://download.01.org/opencv/2019/openvinotoolkit/R3/l_openvino_toolkit_dev_ubuntu18_p_2019.3.376.tgz
#tar -xvzf l_openvino_toolkit_dev_ubuntu18_p_2019.3.376.tgz

#mv ./l_openvino_toolkit_dev_ubuntu18_p_2019.3.376 ./dldt
cd ~/dldt/inference-engine
git submodule init
git submodule update --recursive
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release -DENABLE_MKL_DNN=OFF -DENABLE_CLDNN -DENABLE_GNA=OFF -DENABLE_SSE42=OFF -DTHREADING=SEQ ..
make –j4
sudo make install
ln -s /usr/local/lib/python3.6/dist-packages/mvnc .
ln -s /usr/local/lib/python3.6/dist-packages/graphviz .

sudo usermod -a -G users "$(whoami)"

cd && source ./dldt/bin/setupvars.sh
sh ./dldt/install_dependencies/install_NCS_udev_rules.sh


#-- Link to source files  
cd ~/.virtualenvs/cv/lib/python3.6/site-packages/
sudo mv cv2.so cv2.so.bak
sudo ln -s /usr/local/lib/python3.6/site-packages/cv2.cpython-32mu.so cv2.so

#--Tensorflow silent installation
cd && git clone https://github.com/markjay4k/Tensorflow-1.9rc0-py36-aarch64.git
sudo apt install Tensorflow-1.9rc0-py36-aarch64/tensorflow-1.9.0rc0-cp36-cp36m-linux_aarch64.whl
sudo reboot 
