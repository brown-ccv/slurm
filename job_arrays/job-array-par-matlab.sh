#!/bin/bash

# Resource request
#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
# note: MATLAB parpool job, use >1 cpus-per-task
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=4G

# Provide index values (TASK IDs)
#SBATCH --array=1-4

# Job handling
#SBATCH -J arrayjob-matlab
#SBATCH -o %x-%A_%a.out

# Load modules
module load matlab/R2021a 

# Use the $SLURM_ARRAY_TASK_ID variable to provide different inputs for each job

# The defualt "Job Storage Location" for the Matlab Parallel Computing Toolbox (PCT)
# is ~/.matlab/
# When submiting multiple jobs with  PCT such as when using job arrays, you need to
# create a unique temporary directory for each job
tmpdir=~/matlab_temp_dir/$SLURM_ARRAY_TASK_ID

mkdir -p $tmpdir

matlab-threaded -nodisplay -r "multi_parfor('$tmpdir', $SLURM_ARRAY_TASK_ID), exit"

rm -r $tmpdir

