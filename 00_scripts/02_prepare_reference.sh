#!/bin/bash
#SBATCH -D ./ 
#SBATCH --job-name="index"
#SBATCH -o 98_log_files/index.out
#SBATCH -c 1
#SBATCH -p ibismini
#SBATCH -A ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=20-00:00
#SBATCH --mem=20000

cd $SLURM_SUBMIT_DIR

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)

# Copy script as it was run
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"

cp $SCRIPT "$LOG_FOLDER"/"$TIMESTAMP"_"$NAME"

: 'usage
makedb -c <genome folder or file> -o <index file>
'

#variables
GENOME="04_reference/genome_filtered.fa"           #use genome_filtered.fa if removing C-T SNPs from the reference genome 
                                          #("00_scripts/utility_scripts/05_prepare_reference_filter.sh
INDEX="04_reference/index_genome.dbindex"

#prepare genome
makedb -c $GENOME -o $INDEX
