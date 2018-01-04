#!/bin/bash

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

trim_galore --illumina --fastqc -q $QUAL --gzip --trim1 --paired 02_data/"$base"_R1.fastq.gz 02_data/"$base"_R2.fastq.gz -o $OUTPUT

done 2>&1 | tee 98_log_files/"$TIMESTAMP"_trimmgalore_wgbs.log

