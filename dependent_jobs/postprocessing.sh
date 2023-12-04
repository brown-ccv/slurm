#!/bin/bash

# Resource request
#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G

# Job handling
#SBATCH -J postprocessing
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

# Run a command
echo “Doing some postprocessing”
