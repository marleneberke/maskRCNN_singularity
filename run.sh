#!/bin/bash
CONT="$PWD/detectron2.sif"
CONDA_ENV="$PWD/detectron2_env"
COMMAND="$@"

SING_EXEC="singularity"
$SING_EXEC exec --nv $CONT bash -c "source activate $CONDA_ENV \
	&& $COMMAND"
