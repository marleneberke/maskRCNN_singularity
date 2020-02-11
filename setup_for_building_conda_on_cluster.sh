#!/bin/bash

CONT="$PWD/detectron2.sif"
CONDA_ENV="$PWD/detectron2_env"

#CONDAPATH="https://repo.anaconda.com/miniconda/Miniconda2-4.7.12.1-Linux-x86_64.sh"

#if [ ! -f "conda.sh" ]; then
#	echo "Getting Conda installation binary..."
#	wget "$CONDAPATH" -O "conda.sh"
#fi

echo "Building container...(REQUIRES ROOT)"
if [ ! -d $PWD/.tmp ]; then
	mkdir $PWD/.tmp
fi
# SINGULARITY_TMPDIR=$PWD/.tmp sudo -E singularity build $CONT Singularity
#rm conda.sh

echo "Setting up the Conda environment"

SING_EXEC="singularity"
$SING_EXEC exec $CONT bash -c "conda create -y -p ${CONDA_ENV} python=3.6"
# ./run.sh conda install -y --file requirements.txt
./run.sh pip install -r requirements.txt
# Some of Detectron2 prereqs
./run.sh pip install torch torchvision
./run.sh pip install -U 'git+https://github.com/facebookresearch/fvcore'
./run.sh pip install cython opencv-python scipy
./run.sh pip install Pillow==6.2.2
./run.sh pip install 'git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI'

echo "Setting up Detectron2"
git clone https://github.com/facebookresearch/detectron2.git
./run.sh "cd detectron2 && python setup.py build develop"

