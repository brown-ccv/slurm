# slurm

What would normally go to the screen does to a file.




# Useful tips


* Nodes vs. cores vs. tasks
* Output files



# Job arrays

Job arrays are a great way to submit a bunch of similar jobs with one batch script. It is a similar concept to a loop, but instead of looping though several steps, a slurm job is created for each task.  All the tasks are then submitted at once.  

How does slurm do this?  Slurm sets a bunch of environemnt variables when you submit jobs.  Job arrays have an environement variable SLURM_ARRAY_TASK_ID which is set for each job in the array.  To see all the SLURM environment variables, you can look at the output from:

`sbatch slurm-env.sh` 

How can we use the `SLURM_ARRY_TASK_ID` to set up our jobs?  There are several examples in the directory `job_array`.  

`job-array.sh`  is the most basic example.  If you submit this, it will run 4 jobs. How does the ouptut differ for the 4 jobs?

`job-array-maths.sh` is an example of using arthimetic with `SLURM_ARRAY_TASK_ID` so you can go outside the limits of 1-1000 (maximum array size on Oscar).

`job-array-variable.sh` is an example of an array job you want to operate on a list of elements: A,B,C,D,E.  Note the syntax (lots of brackets) and that we do 0-4 for the array because bash starts counting at zero. 

`job-array-from-file.sh` is an example where each task acts takes a different line from a file.   The file `list_of_files` is the file being read. 

# Dependent jobs

Dependent jobs are a great tool when you have several stages in your data anaylsis.  Here we have a small example of a three step process. This example can be found in the directory `dependent_jobs`.  Step1 must finish successfully before Step2 starts, Step2 must be completed (successful or unsucessful) before Step3 starts.   

1. A preprocessing step, the batch script `preprocessing.sh`
2. An analysis step, the batch script `analysis.sh`
3. A post processing step, the batch script `postprocessing.sh`


Instead of submitting these three scripts indiviually and checking the results after each step, we can use **dependent jobs**. Here is what is inside the `dependent_job.sh` script.

````
#!/bin/bash

# first job - no dependencies
jobID_1=$(sbatch  preprocessing.sh | cut -f 4 -d' ')

# second job - depends on job1
jobID_2=$(sbatch --dependency=afterok:$jobID_1 analysis.sh | cut -f 4 -d' ')

# third job - depends on job2
sbatch  --dependency=afterany:$jobID_2  postprocessing.sh
````

To run this script use:

`bash ./dependent_jobs`

Note this is a bash script, not at batch script.


# Scripting Scripts

In this example we are going to create a batch script with a script. 
