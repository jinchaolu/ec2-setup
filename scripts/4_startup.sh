#!/bin/bash

# Start the X server
# JL: Stop current X server session
sudo service lightdm stop
# JL: To get OpenGL applications to run on the remote computer I need to 
#     start a second X Server which VirtualGL uses to talk to the NVIDIA gpu. 
#     The second X Server will start with the sudo xinit &.
# See https://stackoverflow.com/questions/34805794/virtualgl-and-turbovnc-extension-glx-missing-on-display-0-0
# JL: The & makes the command run in the background.
#     If a command is terminated by the control operator &, the shell 
#     executes the command in the background in a subshell. The shell does 
#     not wait for the command to finish, and the return status is 0.
sudo xinit &

# Start the server on port 5901
# JL: Start a new TurboVNC session
/opt/TurboVNC/bin/vncserver
# JL: Get the return value, if it is not equal to 0, return 1 for warning
if [[ $? -ne 0 ]] ; then
  exit 1
fi

# This should not be needed!
# JL: run nvidia docker plugin
#     nvidia-docker-plugin is a Docker Engine plugin designed to ease the 
#     process of deploying GPU-aware containers in heterogeneous 
#     environments. It acts as a daemon process, discovering host driver 
#     files and GPU devices and answers to volume mount requests originating 
#     from the Docker daemon.
sudo nvidia-docker-plugin &
# TRY:
# https://github.com/NVIDIA/nvidia-docker/issues/116
# sudo apt-get purge nvidia-docker
# sudo rm -r /var/lib/nvidia-docker

# If you wish to run noVNC
# /opt/noVNC/utils/launch.sh --vnc localhost:5901
