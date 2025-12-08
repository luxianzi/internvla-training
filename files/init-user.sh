#!/bin/bash
set -e

# Delete the default user from ubuntu base image
deluser ubuntu
rm -rf /home/ubuntu

# Add the new user, user name specified by environment variable
adduser --uid $UID --disabled-password --gecos '' $USERNAME && echo "$USERNAME:$USERNAME" | chpasswd
adduser $USERNAME sudo
echo "export LANG=en_US.UTF-8" | cat >> /home/$USERNAME/.bashrc
chown $USERNAME:$USERNAME /home/$USERNAME/.bashrc

# Create the SSH directory in case we need openssh server
mkdir /home/$USERNAME/.ssh
chown $USERNAME:$USERNAME /home/$USERNAME/.ssh
