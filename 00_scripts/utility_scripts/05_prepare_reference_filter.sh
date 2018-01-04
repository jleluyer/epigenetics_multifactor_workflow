#!/bin/bash
#PBS -N filter_genome
#PBS -o log-filter_genome.out
#PBS -l walltime=20:00:00
#PBS -l mem=50g
#PBS -r n

cd $PBS_O_WORKDIR

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)

# Copy script as it was run
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#global variables
GENOME="04_reference/genome_filtered.fasta"

GENOME_MASK="04_reference/genome_filtered.fa"

#SOFT="-soft"           Enforce "soft" masking.  That is, instead of masking with Ns,
#                       mask with lower-case bases.

#MASK_CHR="-mc"         #Replace masking character.  That is, instead of masking
#                       with Ns, use another charac

FORMAT_INFO="01_info_files/list_snps.bed" #BED/GFF/VCF file of ranges to mask in -fi



#script
bedtools maskfasta $SOFT $MASK_CHR -fi $GENOME -fo $GENOME_MASK -bed $FORMAT_INFO
