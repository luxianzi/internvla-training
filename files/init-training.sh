#!/bin/bash
set -e

source /home/$USERNAME/miniforge3/etc/profile.d/conda.sh
conda env create -f internvla-m1.yml
conda activate internvla-m1
pip install flash-attn==2.8.3
pip cache purge
conda clean --all -y
