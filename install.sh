# initialization
sudo apt -y update && sudo apt -y upgrade
cd ~
sudo apt -y install wget mc python python3 python-pip python3-pip 
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
sudo pip install virtualenv virtualenvwrapper
sudo rm -rf ~/get-pip.py ~/.cache/pip

# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

# virtualenv and virtualenvwrapper
echo -e "\n# ncs and virtualenvwrapper" >> ~/.bashrc
echo "export WORKON_HOME=~/.virtualenvs" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
echo "alias python=python3" >> ~/.bashrc
echo "alias pip=pip3" >> ~/.bashrc
source ~/.bashrc
mkvirtualenv cv -p python3
workon cv

cd ~
wget https://github.com/Kitware/CMake/releases/download/v3.14.4/cmake-3.14.4.tar.gz
tar xvzf cmake-3.14.4.tar.gz
cd ~/cmake-3.14.4
./bootstrap
make –j4
make install

cd ~
#libs & tools
sudo apt -y install build-essential unzip pkg-config
sudo apt -y install libjpeg-dev libpng-dev libtiff-dev
sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt -y install libxvidcore-dev libx264-dev
sudo spt -y install libcanberra-gtk*
sudo apt -y install libatlas-base-dev gfortran
sudo apt -y install libtbb2 libtbb-dev libdc1394-22-dev  libgtk-3-dev 

cd ~
pip install numpy 
sudo usermod -a -G users "$(whoami)"

cd ~
git clone https://github.com/markjay4k/ncsdk-aarch64.git
git clone https://github.com/subtruct/arm64-ubuntu18-rpi4-server-ncs-install.git
sudo cp ~/arm64-ubuntu18-rpi4-server-ncs-install/ncsdk.conf ~/ncsdk-aarch64
sudo cp ~/arm64-ubuntu18-rpi4-server-ncs-install/ncsdk.conf ~/ncsdk-aarch64/NCSDK-1.12.00.01/ncsdk-aarch64
cd ~
cd ncsdk-aarch64
sudo make install
sudo make api

cd ~
git clone https://github.com/markjay4k/Tensorflow-1.9rc0-py36-aarch64.git
pip install Tensorflow-1.9rc0-py36-aarch64/tensorflow-1.9.0rc0-cp36-cp36m-linux_aarch64.whl

cd ~
mkdir ./Downloads
cd ~/Downloads
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.1.1.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.1.1.zip
unzip opencv.zip
unzip opencv_contrib.zip
mv opencv-4.1.1/ opencv/
mv opencv_contrib-4.1.1/ opencv_contrib/

cd ~
wget https://download.01.org/opencv/2019/openvinotoolkit/R3/l_openvino_toolkit_dev_ubuntu18_p_2019.3.376.tgz
tar -xvzf l_openvino_toolkit_dev_ubuntu18_p_2019.3.376.tgz

cd ~
mkdir -p opencv/build
cd opencv/build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
    -D ENABLE_NEON=ON \
    -D ENABLE_VFPV3=ON \
    -D BUILD_TESTS=OFF \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D BUILD_EXAMPLES=OFF ..
make -j4
sudo make install

cd ~/.virtualenvs/cv/lib/python3.6/site-packages/
ln -s /usr/local/python/cv2/python-3.6/cv2.cpython-35m-arm-linux-gnueabihf.so cv2.so
cd ~

sudo make examples


