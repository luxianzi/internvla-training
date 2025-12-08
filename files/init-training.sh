#!/bin/bash
set -e

# Activate Miniforge environment
source /home/$USERNAME/miniforge3/etc/profile.d/conda.sh

# Create Training Environment
conda env create -f internvla-m1.yml
conda activate internvla-m1
# FIXME: flash-attn requires torch, but only by the ymal file, we cannot make sure torch will be installed before torch
pip install flash-attn==2.8.3
pip cache purge
conda clean --all -y
