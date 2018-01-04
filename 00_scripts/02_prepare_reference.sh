#!/bin/bash
#PBS -N index.trim
#PBS -o log-index.trim.out
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

: 'usage
makedb -c <genome folder or file> -o <index file>
'

#variables
GENOME="04_refernce/genome.fa"
INDEX="index_genome.dbindex"

#prepare genome
makedb -c $GENOME -o $INDEX
