#!/bin/bash

# Resource request
#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G

# Partition
#SBATCH --partition=batch

# Define array (TASK IDs)
#SBATCH --array=1-4

# Job handling
#SBATCH -J arrayjob-readline
#SBATCH -o %x-%A_%a.out

line="`sed -n ${SLURM_ARRAY_TASK_ID}p list_of_files`"
echo "Line number " ${SLURM_ARRAY_TASK_ID} "is :" $line


