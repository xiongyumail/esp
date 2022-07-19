#!/bin/bash
WORK_PATH=$(cd $(dirname $0); pwd)
TEMP_PATH=~/workspace/.tmp/${MY_NAME}
echo "WORK_PATH: ${WORK_PATH}"
echo "TEMP_PATH: ${TEMP_PATH}"

sudo apt-get update
sudo chown -R ${MY_NAME}:${MY_NAME} /home/${MY_NAME}/workspace

if [ ! -d "${TEMP_PATH}" ]; then
   mkdir -p ${TEMP_PATH}
fi
cd ${TEMP_PATH}
if [ ! -d ".config" ]; then
   mkdir .config
fi
if [ ! -d ".tools" ]; then
   mkdir .tools
fi

cd ${TEMP_PATH}/.config
if [ ! -d ".config" ]; then
   mkdir .config
   sudo rm -rf ~/.config
   sudo ln -s $PWD/.config ~/.config
fi
if [ ! -d ".tmux" ]; then
   mkdir .tmux
   sudo rm -rf ~/.tmux
   sudo ln -s $PWD/.tmux ~/.tmux
fi
if [ ! -d ".espressif" ]; then
   mkdir .espressif
   sudo rm -rf ~/.espressif
   sudo ln -s $PWD/.espressif ~/.espressif
fi

# tmux
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
   tmux \
   vim-gtk 
if [ ! -f "${TEMP_PATH}/.tools/tmux" ]; then
   cd ${WORK_PATH}
   cd tmux
   ln -s $PWD/.tmux.conf ~/.tmux.conf
   ln -s $PWD/.vimrc ~/.vimrc
   echo "export TMUX_PATH=${TEMP_PATH}/tmux" >> ${HOME}/.bashrc
   echo "tmux install ok" >> ${TEMP_PATH}/.tools/tmux
fi

# esp-idf
sudo apt-get install -y \
   python3 \
   python3-pip \
   python3-venv \
   cmake \
   libusb-1.0
if [ ! -f "${TEMP_PATH}/.tools/esp-idf" ]; then
   cd ${WORK_PATH}
   cd esp-idf
   sudo rm -rf /usr/bin/python
   sudo ln -s /usr/bin/python3 /usr/bin/python
   ./install.sh
   echo "export IDF_PATH=${WORK_PATH}/esp-idf" >> ${HOME}/.bashrc
   echo "esp-idf install ok" >> ${TEMP_PATH}/.tools/esp-idf
fi

sudo apt-get clean
sudo apt-get autoclean
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
sudo rm -rf /var/cache/*
sudo rm -rf /var/lib/apt/lists/*
