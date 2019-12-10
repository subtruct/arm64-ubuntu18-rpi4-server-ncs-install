# initialization
yes | sudo apt-get update && yes | sudo apt-get upgrade
cd ~
sudo apt-get -y install mc python-pip python3-pip
wget https://bootstrap.pypa.io/get-pip.py
sudo yes | python3 get-pip.py
alias python=python3
alias pip=pip3

# virtualenv and virtualenvwrapper
sudo yes | pip -q install ncs virtualenvwrapper
sudo rm -rf ~/get-pip.py ~/.cache/pip
export WORKON_HOME=$HOME/.ncs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3

# virtualenvwrapper
echo -e "\n# ncs and virtualenvwrapper" >> ~/.bashrc
echo "export WORKON_HOME=$HOME/.ncs" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
echo "workon ncs" >> ~/.bashrc
source ~/.bashrc

# python 3.7
sudo apt-get -y install python3.7-dev
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1
workon cv
#libs & tools
sudo apt-get -y install build-essential cmake unzip pkg-config
sudo apt-get -y install libjpeg-dev libpng-dev libtiff-dev
sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get -y install libxvidcore-dev libx264-dev
sudo apt-get -y install libcanberra-gtk*
sudo apt-get -y install libatlas-base-dev gfortran

pip -q install numpy==



