#!/usr/bin/env bash
#PBS -N methpipe.__BASE__
#PBS -o 98_log_files/log-methpipe.__BASE__.out
#PBS -l walltime=20:00:00
#PBS -l mem=50g
#PBS -r n

#Export libs
source /usr/share/Modules/3.2.10/init/bash
module load gsl

cd $PBS_O_WORKDIR


#global variables
GENOME="04_reference/GCF_002021735.1_Okis_V1_genomic.trim.fa"
DATA_FOLDER="05_results"
base=__BASE__


LC_ALL=C sort -k 1,1 -k 2,2n -k 3,3n -k 6,6 -o "$DATA_FOLDER"/"$base".mr.sorted_start "$DATA_FOLDER"/"$base".mr

duplicate-remover -S "$DATA_FOLDER"/"$base".dremove_stat.txt -o "$DATA_FOLDER"/"$base".mr.dremove "$DATA_FOLDER"/"$base".mr.sorted_start

methcounts -cpg-only -c $GENOME -o "$DATA_FOLDER"/"$base".meth "$DATA_FOLDER"/"$base".mr.sorted_start

symmetric-cpgs -o "$DATA_FOLDER"/"$base"_CpG.meth "$DATA_FOLDER"/"$base".meth

bsrate -c $GENOME -o "$DATA_FOLDER"/"$base".bsrate "$DATA_FOLDER"/"$base".mr.dremove
