#!/bin/bash
set -e

# conda update
conda update conda --yes
conda update --all --yes

# install jupyter notebook extensions
conda install -c conda-forge jupyter_contrib_nbextensions
jupyter contrib nbextension install --sys-prefix

# create virtual environment
conda create -n Python3.6 python=3.6 --yes
source activate Python3.6
pip install ipykernel
python -m ipykernel install --user --name Python3.6 --display-name "Python 3.6"
source deactivate
