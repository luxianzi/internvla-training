#!/bin/bash
set -e

deluser ubuntu
rm -rf /home/ubuntu
adduser --uid $UID --disabled-password --gecos '' $USERNAME && echo "$USERNAME:$USERNAME" | chpasswd
adduser $USERNAME sudo
echo "export LANG=en_US.UTF-8" | cat >> /home/$USERNAME/.bashrc
chown $USERNAME:$USERNAME /home/$USERNAME/.bashrc
