#!/bin/bash
IMAGE_NAME="esp"
IMAGE_VERSION="1.0.0"

WORK_PATH=$(cd $(dirname $0); pwd)
echo "WORK_PATH: ${WORK_PATH}"

export PROJECTS_PATH=/home/${MY_NAME}/projects

session=${IMAGE_NAME}

tmux has-session -t $session >/dev/null 2>&1
if [ $? = 0 ];then
    tmux attach-session -t $session
    exit
fi

tmux new-session -d -s $session -n ${MY_NAME}

tmux send-keys -t $session:0.0 'cd ${PROJECTS_PATH};source ${IDF_PATH}/export.sh' C-m

tmux select-pane -t $session:0.0
tmux attach-session -t $session
