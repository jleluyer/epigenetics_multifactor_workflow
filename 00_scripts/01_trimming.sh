#!/bin/bash
#PBS -N trimming.__BASE__
#PBS -o 98_log_files/log-trimming.__BASE__.out
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

#variables
LENGTH=100
QUAL=20
ERROR_RATE="0.2"
OUTPUT="03_trimmed"
base=__BASE__

trim_galore --illumina --fastqc -q $QUAL --gzip --trim1 --paired 02_data/"$base"_R1.fastq.gz 02_data/"$base"_R2.fastq.gz -o $OUTPUT

done 2>&1 | tee 98_log_files/"$TIMESTAMP"_trimmgalore_wgbs.log

