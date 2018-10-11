#!/bin/bash
#PBS -N trimming.__BASE__
#PBS -o 98_log_files/log-trimming.__BASE__.out
#PBS -l walltime=20:00:00
#PBS -l mem=100g
#PBS -r n

cd $PBS_O_WORKDIR

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)

# Copy script as it was run
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#variables
base=__BASE__
INPUT="02_data"
OUTPUT="03_trimmed"


fastp --thread 12 --compression 1 -i "$INPUT"/"$base"_R1.fastq.gz -I "$INPUT"/"$base"_R2.fastq.gz \
	--length_required="$LENGTH" --qualified_quality_phred="$QUAL" \
	--correction \
	--trim_tail1=1 --trim_tail2=1 \
	-o "$OUTPUT"/"$base"_R1.fastq.gz -O "$OUTPUT"/"$base"_R2.fastq.gz

done 2>&1 | tee 98_log_files/"$TIMESTAMP"_trimmgalore_wgbs.log

