#!/bin/bash 

# This bash script 
#
#  1. creates a file containing a list of
#     poems we want to analyse
#
#  2. counts the number of poems (lines in the file)
#
#  3. creates two batch scipts
#       - An analysis script where the job_array is 
#         eqaul to the number of poems we are analysing
#       - A script to check all the results once our
#         poem analysis has finished
#
#  4. submits the scripts


# 1. create a file with the list of files in the directory 'poems'. 
ls poems > list_of_poems

# 2. count the number of lines in file
#    This will be our job array size
npoems=$(wc -l < list_of_poems)

#-------------------
# create a batch script to check the results
cat << EOF2 > check_results.sh
#!/bin/bash
#SBATCH -n 1
#SBATCH -oe result_summary.out
#SBATCH --mail-type=END
# search the results files for failures

grep -rn FAILED analysis_*

EOF2



#-------------------
# create a batch script for the poem analysis
cat <<EOF > poem_analysis.sh
#!/bin/bash
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --array=1-$(($npoems))
#SBATCH -o analysis_%a.out
#SBATCH -e analysis_%a.out

# Submit the check_results.sh script to run after this job completes
sbatch --dependency=afterok:\$SLURM_JOB_ID check_results.sh

# This gets the poem to work on from the list_of_poems
poem="`sed -n \${SLURM_ARRAY_TASK_ID}p list_of_poems`"
echo $poem "slurm array task id is" \${SLURM_ARRAY_TASK_ID}

# Here is our analysis: Does the poem have the word "love" in it?
if grep love $poem; then
  echo "Poem" $poem " has the word love"
else
  echo "FAILED"
fi

EOF
#------------------

# submit our analysis scipt
sbatch poem_analysis.sh




