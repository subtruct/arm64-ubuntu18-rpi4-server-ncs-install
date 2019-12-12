# initialization
sudo apt -y update && sudo apt -y upgrade
cd
sudo apt -y install wget mc python python3 python-pip python3-pip 
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
sudo pip3 install virtualenv virtualenvwrapper
sudo rm -rf ~/get-pip.py ~/.cache/pip

# virtualenv and virtualenvwrapper
echo -e "\n# ncs and virtualenvwrapper" >> ~/.bashrc
echo "export WORKON_HOME=~/.virtualenvs" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
echo "alias python=python3" >> ~/.bashrc
echo "alias pip=pip3" >> ~/.bashrc
echo "workon cv" >> ~/.bashrc
source ~/.bashrc
mkvirtualenv cv -p python3
workon cv

#CMake installation ... 
cd
wget https://github.com/Kitware/CMake/releases/download/v3.14.4/cmake-3.14.4.tar.gz
tar xvzf cmake-3.14.4.tar.gz
cd ~/cmake-3.14.4
./bootstrap
make –j4
sudo make install

#System related res..... 
cd
#System lib&tools
sudo apt -y install build-essential unzip pkg-config
sudo apt -y install libjpeg-dev libpng-dev libtiff-dev
sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt -y install libxvidcore-dev libx264-dev
sudo apt -y install libcanberra-gtk*
sudo apt -y install libatlas-base-dev gfortran
sudo apt -y install libtbb2 libtbb-dev libdc1394-22-dev  libgtk-3-dev 

#Python main depenzenses 
pip install scikit-image #caffe dependences 
pip install google #caffe dependences 
pip install protobuff 
pip install numpy 

#Custom NCS SDK/API Installation
cd
git clone https://github.com/markjay4k/ncsdk-aarch64.git
git clone https://github.com/subtruct/arm64-ubuntu18-rpi4-server-ncs-install.git
sudo cp ~/arm64-ubuntu18-rpi4-server-ncs-install/ncsdk.conf ~/ncsdk-aarch64
sudo cp ~/arm64-ubuntu18-rpi4-server-ncs-install/ncsdk.conf ~/ncsdk-aarch64/NCSDK-1.12.00.01/ncsdk-aarch64
cd ~/ncsdk-aarch64
sudo make install
sudo make api

cd /home/pi/.virtualenvs/cv3.3_py3.5/lib/python3.5/site-packages
ln -s /usr/local/lib/python3.5/dist-packages/mvnc .
ln -s /usr/local/lib/python3.5/dist-packages/graphviz .
pip3 install protobuf pyyaml

#Official NCS SDK/API - UBUNTU v.18 build 2019.3.376
cd
wget https://download.01.org/opencv/2019/openvinotoolkit/R3/l_openvino_toolkit_dev_ubuntu18_p_2019.3.376.tgz
tar -xvzf l_openvino_toolkit_dev_ubuntu18_p_2019.3.376.tgz
mv ./l_openvino_toolkit_dev_ubuntu18_p_2019.3.376 ./ncsIEsdk

OPEN-CV Installation
cd
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
unzip opencv.zip
unzip opencv_contrib.zip
mv opencv-4.1.1/ opencv/
mv opencv_contrib-4.1.1/ opencv_contrib/
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
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules ..
ake -j4
sudo make install

#System calls & settings 
sudo usermod -a -G users "$(whoami)"
#Move to system path - final compoled kernel 
cd ~/.virtualenvs/cv/lib/python3.6/site-packages/
ln -s /usr/local/python/cv2/python-3.6/cv2.cpython-35m-arm-linux-gnueabihf.so cv2.so

#Tensorflow installation
cd 
git clone https://github.com/markjay4k/Tensorflow-1.9rc0-py36-aarch64.git
pip install Tensorflow-1.9rc0-py36-aarch64/tensorflow-1.9.0rc0-cp36-cp36m-linux_aarch64.whl
cd

make examples
