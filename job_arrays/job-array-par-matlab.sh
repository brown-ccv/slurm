#!/bin/bash

# Job Name
#SBATCH -J arrayjob 

# Walltime requested
#SBATCH -t 0:10:00

# Provide index values (TASK IDs)
#SBATCH --array=1-4

# Use '%A' for array-job ID, '%J' for job ID and '%a' for task ID
#SBATCH -e arrayjob-%a.err
#SBATCH -o arrayjob-%a.out

# two core Matlab parpool job
#SBATCH -c 2

# Use the $SLURM_ARRAY_TASK_ID variable to provide different inputs for each job

# The defualt "Job Storage Location" for the Matlab Parallel Computing Toolbox (PCT)
# is ~/.matlab/
# When submiting multiple jobs with  PCT such as when using job arrays, you need to
# create a unique temporary directory for each job


tmpdir=~/matlab_temp_dir/$SLURM_ARRAY_TASK_ID

mkdir -p $tmpdir

matlab-threaded -nodisplay -nojvm -r "multi_parfor($tmpdir, $SLURM_ARRAY_TASK_ID), exit"

rm $tmpdir

