#!/bin/bash
#SBATCH -n 1
#SBATCH -oe result_summary.out

# search the results files for failures

grep -rn FAILED analysis_*

