#!/bin/bash
#SBATCH -D ./ 
#SBATCH --job-name="filter"
#SBATCH -o 98_log_files/filter.out
#SBATCH -c 1
#SBATCH -p ibismini
#SBATCH -A ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=20-00:00
#SBATCH --mem=2000

cd $SLURM_SUBMIT_DIR

module available bedtools/2.26.0

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)

# Copy script as it was run
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#global variables
GENOME="04_reference/genome.fa"

GENOME_MASK="04_reference/genome_filtered.fa"

#SOFT="-soft"           Enforce "soft" masking.  That is, instead of masking with Ns,
#                       mask with lower-case bases.

#MASK_CHR="-mc"         #Replace masking character.  That is, instead of masking
#                       with Ns, use another charac

FORMAT_INFO="01_info_files/snp_db.bed" #BED/GFF/VCF file of ranges to mask in -fi



#script
bedtools maskfasta $SOFT $MASK_CHR -fi $GENOME -fo $GENOME_MASK -bed $FORMAT_INFO
