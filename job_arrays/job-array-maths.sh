#!/bin/bash

# Job Name
#SBATCH -J arrayjob 

# Walltime requested
#SBATCH -t 0:10:00

# Provide index values (TASK IDs)
#SBATCH --array=1-4

# Use '%A' for array-job ID, '%J' for job ID and '%a' for task ID
#SBATCH -e maths-%a.err
#SBATCH -o maths-%a.out

# single core
#SBATCH -c 1

# Use the $SLURM_ARRAY_TASK_ID variable to provide different inputs for each job
 
input=$((SLURM_ARRAY_TASK_ID*1000+2))
echo "Running job array number: "$SLURM_ARRAY_TASK_ID "input " $input
