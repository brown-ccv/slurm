#!/bin/bash

#SBATCH -n 1 
#SBATCH -t 00:05:00
#SBATCH -o slurm_environment_variables

# Slurm sets a bunch of environment variales
# This script lists all the environment variables
# that have 'SLURM' in the name

env | grep SLURM
