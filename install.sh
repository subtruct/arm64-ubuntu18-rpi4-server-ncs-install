# initialization
sudo apt-get update && sudo apt-get upgrade
cd ~
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
alias python=python3
alias pip=pip3

# virtualenv and virtualenvwrapper
sudo pip install ncs virtualenvwrapper
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
sudo apt-get install python3.7-dev
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1
workon cv
#libs & tools
sudo apt-get -y install build-essential cmake unzip pkg-config
sudo apt-get install libjpeg-dev libpng-dev libtiff-dev
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install libxvidcore-dev libx264-dev
sudo apt-get install libcanberra-gtk*
sudo apt-get install libatlas-base-dev gfortran

pip install numpy



