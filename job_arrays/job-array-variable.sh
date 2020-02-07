#!/bin/bash

#SBATCH --time=00:10:00
#SBATCH --mem=20G
#SBATCH -c 8
#SBATCH --array=0-4

input=(A B C D E)

echo "Hello I am doing science with "  ${input[$SLURM_ARRAY_TASK_ID]}
