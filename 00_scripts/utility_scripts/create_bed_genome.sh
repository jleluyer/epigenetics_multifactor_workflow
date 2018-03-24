#!/usr/bin/env bash
#SBATCH -D ./ 
#SBATCH --job-name="createbed"
#SBATCH -o 98_log_files/createbed.out
#SBATCH -c 1
#SBATCH -p ibismax
#SBATCH -A ibismax
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=20-00:00
#SBATCH --mem=20000

cd $SLURM_SUBMIT_DIR

module load bedtools/2.26.0

#global variables
GENOME="01_info_files/genome.info.txt"

bedtools makewindows -g $GENOME -w 500 >01_info_files/genome.bed
