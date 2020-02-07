#!/bin/bash

#SBATCH --array=1-4
#SBATCH -o output_%A-%a

line="`sed -n ${SLURM_ARRAY_TASK_ID}p list_of_files`"
echo $line "slurm array task id is" ${SLURM_ARRAY_TASK_ID}

