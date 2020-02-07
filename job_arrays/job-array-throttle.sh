#!/bin/bash

# Job Name
#SBATCH -J arrayjob 

# Walltime requested
#SBATCH -t 0:10:00

# Provide index values (TASK IDs)
# 40 array tasks, but only 2 can run simultaneously
#SBATCH --array=1-40%2

# Use '%A' for array-job ID, '%J' for job ID and '%a' for task ID
#SBATCH -e maths-%a.err
#SBATCH -o maths-%a.out

# single core
#SBATCH -c 1

# Using sleep here to make the job take more time so you can 
# see the effect of throttling. 
sleep(2)

# Use the $SLURM_ARRAY_TASK_ID variable to provide different inputs for each job
input=$((SLURM_ARRAY_TASK_ID*1000+2))
echo "Running job array number: "$SLURM_ARRAY_TASK_ID "input " $input
