#!/usr/bin/env bash
#SBATCH -D ./ 
#SBATCH --job-name="dss"
#SBATCH -o 98_log_files/log-dss.out
#SBATCH -c 1
#SBATCH -p ibismax
#SBATCH -A ibismax
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=20-00:00
#SBATCH --mem=100000

cd $SLURM_SUBMIT_DIR

Rscript --vanilla 00_scripts/06_dss.R
