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
#SBATCH --array=0-4

# Job handling
#SBATCH -J arrayjob-variable
#SBATCH -o %x-%A_%a.out

input=(A B C D E)

echo "Hello I am doing science with "  ${input[$SLURM_ARRAY_TASK_ID]}
