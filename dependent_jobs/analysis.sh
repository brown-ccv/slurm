#!/bin/bash

#SBATCH --time=00:05:00
#SBATCH -J analysis
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err
#SBATCH --mem=1G
#SBATCH -n 1

# Run a command
echo "Lots of lovely science"
echo "Cutting edge research"
echo "Algorithms"
