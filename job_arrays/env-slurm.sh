#!/bin/bash

# Resource request
#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G

# Job handling
#SBATCH -J slurm_env
#SBATCH -o %x.out

# Slurm sets a bunch of environment variales
# This script lists all the environment variables
# that have 'SLURM' in the name

env | grep SLURM
