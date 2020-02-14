# SLURM workshop Feb 2020

This workshop is for people who are already familiar with SLURM, but would like to use SLURM's more powerful features. 

To clone this repository:

````
  git clone https://github.com/brown-ccv/slurm.git
````

## Important Concepts

####  Batch scripts vs bash scripts

Batch is 'batch processing' - running a bunch of things at once.  Batch scripts contain instructions for slurm, and the commands you want to run on the compute nodes. Batch scripts are submited to slurm like so:

````
sbatch my_script.sh
````

Bash scripts are (Borne Again) shell scripts. They are lists of instructions which are _exectuted_ when you run the script like so:

````
bash my_bash_script.sh
````

or if the bash script has been made executable  `chmod +x my_bash_script.sh`, bash scripts can be executed like so:

````
./my_bash_script.sh 
````



#### Slurm instructions go at the start of the batch script

Any `#SBATCH` lines that come after a regular line are ignored. Make sure you put all your `SBATCH` lines at the start of the file.

**Incorrect** way:

````
#SBATCH -J science_work
my_cool_science
#SBATCH -n 10
````

The `#SBATCH -n 10 ` will be ingored and you will get the default value for the number of tasks (1 on Oscar) 

**Correct** way:

````
#SBATCH -J science_work
#SBATCH -n 10
my_cool_science
````
You will get 10 tasks.

#### Output when using a batch script
What would normally go to the screen goes to a file. You may have heard the terms 'standard out' and 'standard errror'.   You can have output and error go to different files: 

````
#SBATCH -o output.out
#SBATCH -e output.err
````

You can have output and error going to the same file

````
#SBATCH -o output.out
#SBATCH -e output.out
````

If you normally have figures pop up, you will need to save the figures to a file.  There is no screen to output figures to when using a batch script. 

##### SBATCH features for naming files

SLURM provies several variables that you can use in your `SBATCH` commands.  A useful one is `%j` which expands to the job number.  Since every job has a unique job number, using `%j` guarantees that you won't overwrite your slurm output file if you resubmit the job.`%x` expands to the job name.  In the example below, the output file will be called `roast_beef-888888.out` and the error file will be called `roast_beef-888888.out`.

````
#SBATCH -J roast_beef
#SBATCH -o %x-%j.out 
#SBATCH -e %x-%j.err 

````


#### Environement variables

These are variables available to any program.  To see a list of environemnt variables currently set, do `env`.  There are many environemnt variables that you may find useful when writting scripts, such as USER, HOME.  Slurm sets a bunch of environemnt variables when you submit jobs. The example batch script `env-slurm.sh` finds all the SLURM environment variables.  You can submit this script and look at the output file to see which variables are set. 

`sbatch env-slurm.sh` 

#### Bash syntax

Bash is very powerful, but its syntax can be challenging if you are coming from other languages. You can use other scripting languages in your batch script, but it is worth knowing a little bash. 

In bash a `$` is used to get the value of a variable.   In the following line we are printing (echo in bash) the value of the variable USER.

`echo $USER`

When setting variables don't put spaces around the equals sign.
 
````
a=1
b='chicken_pot_pie'
````

You can do arithmetic in bash

````
a=1
echo $((a+2)) 
````

You can use filename expansion `*` (globbing).  e.g. in the example below an array "my_array" is created with`*`.  What does "my_array" contain?

````
my_array=(*)
````

#### Small jobs vs loops vs job arrays

Lots of jobs submitted at once can overwhelm SLURM, e.g. 30 000 jobs.  
You can have loops in your batch script to perform several tasks in the same job.  For example, if you are running analyses that only take a few seconds, more time will be spent by slurm setting queing up and shutting down the job than doing the actual computation. 

#### Spending as little time in the queue as possible
Review what resources your job actually used.  The more acurate you can be with the limits of time and memory, they less uneccesary time you will spend in the queue.  Do you really need to use the big memory parition?

`````
sacct -jl 888888
`````

On Oscar we have the command `myjobinfo` which will give you a summary of the resources your job used. 


# Job arrays

Job arrays are a great way to submit a bunch of similar jobs with one batch script. It is a similar concept to a loop, but instead of looping though several steps, a slurm job is created for each task.  All the tasks are then submitted at once.  

How does slurm do this?  Slurm sets a bunch of environemnt variables when you submit jobs.  Job arrays have an environement variable `SLURM_ARRAY_TASK_ID` which is set for each job in the array.  To see all the SLURM environment variables, you can look at the output from:

`sbatch env-slurm.sh` 

How can we use the `SLURM_ARRY_TASK_ID` to set up our jobs?  There are several examples in the directory `job_array`.  

`job-array.sh`  is the most basic example.  If you submit this, it will run 4 jobs. How does the ouptut differ for the 4 jobs?

`job-array-maths.sh` is an example of using arthimetic with `SLURM_ARRAY_TASK_ID` so you can go outside the limits of 1-1000 (maximum array size on Oscar).

`job-array-variable.sh` is an example of an array job you want to operate on a list of elements: A,B,C,D,E.  Note the syntax (lots of brackets) and that we do 0-4 for the array because bash starts counting at zero. 

`job-array-from-file.sh` is an example where each task acts takes a different line from a file.   The file `list_of_files` is the file being read. 

Use `myq` to view your job arrays in the queue.  Note the format `8888888_3`.    

`8888888` is the job number and `_3` is the array task id. You can cancel the whole array at once with 8888888, or individual arrays with `8888888_3`.

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

In this example we are going to create two batch script withs a script. It uses dependent jobs, job arrays, and slurm environement variables. 

We have a directory full of files.  We want to find out how many files are in the directory, then create our job array based on the number of files and the filenames.  In addition, we want our job array script to submit a second batch script, dependent on the job array running sucessfully, that aggregates the results from our job array.   







