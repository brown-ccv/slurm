#!/bin/bash

# Resource request
#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G

# Define array (TASK IDs)
#SBATCH --array=1-4

# Job handling
#SBATCH -J arrayjob
#SBATCH -o %x-%A_%a.out

# Use the $SLURM_ARRAY_TASK_ID variable to provide different inputs for each job
 
echo "Running job array number: "$SLURM_ARRAY_TASK_ID
