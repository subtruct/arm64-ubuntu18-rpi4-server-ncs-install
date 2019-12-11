# initialization
sudo apt -y update && sudo apt -y upgrade
cd ~
sudo apt-get -y install wget mc python python3 python-pip python3-pip python3.7-dev build-essentia
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1
sudo update-alternatives --config python3
sudo pip -q install virtualenv virtualenvwrapper
sudo rm -rf ~/get-pip.py ~/.cache/pip
sudo rm ~/.cache -d -R ./*

# virtualenv and virtualenvwrapper
export WORKON_HOME=~/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
mkvirtualenv cv -p python3

# virtualenvwrapper
echo -e "\n# ncs and virtualenvwrapper" >> ~/.bashrc
echo "export WORKON_HOME=~/.virtualenvs" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo "alias python=python3" >> ~/.bashrc
echo "alias pip=pip3" >> ~/.bashrc
echo "workon cv" >> ~/.bashrc
source ~/.bashrc

#libs & tools
sudo apt-get -y install build-essential cmake unzip pkg-config
sudo apt-get -y install libjpeg-dev libpng-dev libtiff-dev
sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get -y install libxvidcore-dev libx264-dev
sudo apt-get -y install libcanberra-gtk*
sudo apt-get -y install libatlas-base-dev gfortran
sudo apt-get -y install libtbb2 libtbb-dev libdc1394-22-dev  libgtk-3-dev 

wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py

sudo python3 -m pip -q install numpy
sudo usermod -a -G users "$(whoami)"

cd ~
git clone https://github.com/markjay4k/ncsdk-aarch64.git
cd ncsdk-aarch64
sudo make install
source ~/.bashrc
sudo make api

cd ~
git clone https://github.com/markjay4k/Tensorflow-1.9rc0-py36-aarch64.git
sudo pip -q install Tensorflow-1.9rc0-py36-aarch64/tensorflow-1.9.0rc0-cp36-cp36m-linux_aarch64.whl

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









