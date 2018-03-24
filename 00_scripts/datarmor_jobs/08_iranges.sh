#!/usr/bin/env bash
#SBATCH -D ./ 
#SBATCH --job-name="irange"
#SBATCH -o 98_log_files/log-irange.out
#SBATCH -c 1
#SBATCH -p ibismini
#SBATCH -A ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=20-00:00
#SBATCH --mem=5000

cd $SLURM_SUBMIT_DIR

Rscript --vanilla 00_scripts/08_iranges.R
