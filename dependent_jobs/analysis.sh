#!/bin/bash

# Resource request
#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G

# Partition
#SBATCH --partition=batch

# Job handling
#SBATCH -J analysis
#SBATCH -o %x-%j.out
#SBATCH -e %x-%j.err

# Run a command
echo "Lots of lovely science"
echo "Cutting edge research"
echo "Algorithms"
