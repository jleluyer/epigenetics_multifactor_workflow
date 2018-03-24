#!/usr/bin/env bash
#SBATCH -D ./ 
#SBATCH --job-name="average.__BASE__"
#SBATCH -o 98_log_files/log-average.__BASE__.out
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
DATAOUTPUT="07_average_meth"
INTERACTION="01_info_files/region.interaction.bed"
GENOTYPE="01_info_files/region.genotype.bed"
ENVIRONMENT="01_info_files/region.environment.bed"
base=__BASE__

#LC_ALL=C sort -k 1,1 -k 3,3n -k 2,2n -k 6,6 \
#-o regions_ESC.meth.sorted regions_ESC.meth


roimethstat -o "$DATAOUTPUT"/interaction.regions."$base".meth "$INTERACTION" "$DATA_FOLDER"/"$base"_CpG.meth

roimethstat -o "$DATAOUTPUT"/genotype.regions."$base".meth "$GENOTYPE" "$DATA_FOLDER"/"$base"_CpG.meth

roimethstat -o "$DATAOUTPUT"/environment.regions."$base".meth "$ENVIRONMENT" "$DATA_FOLDER"/"$base"_CpG.meth

