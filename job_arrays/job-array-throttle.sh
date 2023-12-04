#!/bin/bash

# Resource request
#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G

# Provide index values (TASK IDs)
# 4 array tasks, but only 2 allowed to run simultaneously
#SBATCH --array=1-4%2

# Job handling
#SBATCH -J arrayjob-throttle
#SBATCH -o %x-%A_%a.out

# Using sleep here to make the job take more time so you can 
# see the effect of throttling. 
sleep 2

# Use the $SLURM_ARRAY_TASK_ID variable to provide different inputs for each job
input=$((SLURM_ARRAY_TASK_ID*1000+2))
echo "Running job array number: "$SLURM_ARRAY_TASK_ID "input " $input
