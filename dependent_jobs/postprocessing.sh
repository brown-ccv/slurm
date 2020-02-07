#!/bin/bash

#SBATCH --time=00:05:00
#SBATCH --mem=1G
#SBATCH -J postprocessing
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err
#SBATCH -n 1

# Run a command
echo “Doing some postprocessing”
