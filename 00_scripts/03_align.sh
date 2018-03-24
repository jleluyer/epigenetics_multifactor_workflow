#!/bin/bash
#SBATCH -D ./ 
#SBATCH --job-name="align.__BASE__"
#SBATCH -o 98_log_files/align.__BASE__.out
#SBATCH -c 5
#SBATCH -p ibismax
#SBATCH -A ibismax
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=20-00:00
#SBATCH --mem=32000

<<<<<<< HEAD
cd $SLURM_SUBMIT_DIR
=======
# Import samtools

cd $PBS_O_WORKDIR
>>>>>>> 03e5d98c78fecfe25ec9b9de4ac9a93051b30648

#global variables
INDEX="04_reference/index_genome.dbindex"
DATAFOLDER="03_trimmed"
DATAOUTPUT="05_results"
base=__BASE__

<<<<<<< HEAD
zcat "$DATAFOLDER"/"$base"_R1.fq.gz >"$DATAFOLDER"/"$base"_R1.fq
zcat "$DATAFOLDER"/"$base"_R2.fq.gz >"$DATAFOLDER"/"$base"_R2.fq

walt -i $INDEX -m 6 -t 5 -k 10 -N 5000000 -1 "$DATAFOLDER"/"$base"_R1.fq -2 "$DATAFOLDER"/"$base"_R2.fq -o "$DATAFOLDER"/"$base".mr
=======
walt -i $INDEX -m 6 -t 5 -N 5000000 -1 "$DATAFOLDER"/"$base"_R1.fq.gz -2 "$DATAFOLDER"/"$base"_R2.fq.gz -o "$DATAOUTPUT"/"$base".mr
>>>>>>> 03e5d98c78fecfe25ec9b9de4ac9a93051b30648

rm "$DATAFOLDER"/"$base"_R*.fq
