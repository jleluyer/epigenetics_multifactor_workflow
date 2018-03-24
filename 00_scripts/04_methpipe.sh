#!/usr/bin/env bash
#SBATCH -D ./ 
#SBATCH --job-name="methpipe.__BASE__"
#SBATCH -o 98_log_files/log-methpipe.__BASE__.out
#SBATCH -c 1
#SBATCH -p ibismax
#SBATCH -A ibismax
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=20-00:00
#SBATCH --mem=20000

cd $SLURM_SUBMIT_DIR

#global variables
GENOME="04_reference/genome_filtered.fa"
DATA_FOLDER="05_results"
DATAINPUT="03_trimmed"
base=__BASE__

#global variables
GENOME="04_reference/genome_filtered.fa"
DATA_FOLDER="05_results"
DATAINPUT="03_trimmed"
base=__BASE__


LC_ALL=C sort -k 1,1 -k 2,2n -k 3,3n -k 6,6 -o "$DATA_FOLDER"/"$base".mr.sorted_start "$DATAINPUT"/"$base".mr

rm "$DATAINPUT"/"$base".mr

# Remove putative PCR duplicates
duplicate-remover -S "$DATA_FOLDER"/"$base".dremove_stat.txt -o "$DATA_FOLDER"/"$base".mr.dremove "$DATA_FOLDER"/"$base".mr.sorted_start

rm "$DATA_FOLDER"/"$base".mr.sorted_start

LC_ALL=C sort -k 1,1 -k 2,2n -k 3,3n -k 6,6 -o "$DATA_FOLDER"/"$base".mr.dremove.sort "$DATA_FOLDER"/"$base".mr.dremove

rm "$DATA_FOLDER"/"$base".mr.dremove

# Compute methylation level
methcounts -cpg-only -c $GENOME -o "$DATA_FOLDER"/"$base".meth "$DATA_FOLDER"/"$base".mr.dremove.sort

# Compute symmetric CpGs contexts
symmetric-cpgs -o "$DATA_FOLDER"/"$base"_CpG.meth "$DATA_FOLDER"/"$base".meth

# Compute methylation stats
levels -o "$DATA_FOLDER"/"$base".levels "$DATA_FOLDER"/"$base".meth

# Compute conversion rate
bsrate -c $GENOME -o "$DATA_FOLDER"/"$base".bsrate "$DATA_FOLDER"/"$base".mr.dremove.sort

rm "$DATA_FOLDER"/"$base".mr.dremove.sort
