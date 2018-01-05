#!/bin/bash
#PBS -N walt.__BASE__
#PBS -o log-align.__BASE__.out
#PBS -l walltime=20:00:00
#PBS -l mem=30g
#PBS -l ncpus=5
#PBS -q omp
#PBS -r n

. /appli/bioinfo/samtools/latest/env.sh

cd $PBS_O_WORKDIR

#global variables
INDEX="04_reference/index_genome.trim.dbindex"
DATAFOLDER="03_trimmed"
base=__BASE__

walt -i $INDEX -m 6 -t 5 -N 5000000 -1 "$DATAFOLDER"/"$base"_R1.fq -2 "$DATAFOLDER"/"$base"_R2.fq -o "$base".mr

