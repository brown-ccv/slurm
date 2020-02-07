#!/bin/bash
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --array=1-6
#SBATCH -o analysis_%a.out
#SBATCH -e analysis_%a.out

# Submit the check_results.sh script to run after this job completes
sbatch --dependency=afterok:$SLURM_JOB_ID check_results.sh

# This gets the poem to work on from the list_of_poems
poem="Anthem_for_Doomed_Youth
Deeply_Morbid
Dule_et_Decorium_Est
Matty_Groves
Money
Not_Waving_but_Drowning"
echo  "slurm array task id is" ${SLURM_ARRAY_TASK_ID}

# Here is our analysis: Does the poem have the word "dog" in it?
if grep dog ; then
  echo "Poem"  " has the word dog"
else
  echo "FAILED"
fi

