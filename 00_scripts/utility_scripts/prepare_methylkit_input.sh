#!/usr/bin/env bash
#PBS -N prep_dss.__BASE__
#PBS -o 98_log_files/log-prep_methylkit.__BASE__.out
#PBS -l walltime=20:00:00
#PBS -l mem=5g
#PBS -r n

cd $PBS_O_WORKDIR

# Global variables
DATA_FOLDER="05_results"
base=__BASE__

# prepare file for dss
awk '{print $1"."$2,$1,$2,"F",$6}' "$DATA_FOLDER"/"$base"_CpG.meth >"$DATA_FOLDER"/"$base".methyl.1.temp
awk '{printf "%.2f\n",$5*100}' "$DATA_FOLDER"/"$base"_CpG.meth >"$DATA_FOLDER"/"$base".methyl.2.temp
awk '{printf "%.2f\n",100-($5*100)}' "$DATA_FOLDER"/"$base"_CpG.meth >"$DATA_FOLDER"/"$base".methyl.3.temp
paste "$DATA_FOLDER"/"$base".methyl.1.temp "$DATA_FOLDER"/"$base".methyl.2.temp "$DATA_FOLDER"/"$base".methyl.3.temp >"$DATA_FOLDER"/"$base".temp.methyl
cat 01_info_files/header_methylkit.txt "$DATA_FOLDER"/"$base".temp.methyl|sed 's/\t/ /g' >"$DATA_FOLDER"/"$base".methyl.txt

# clean up
rm "$DATA_FOLDER"/"$base".*.temp
rm "$DATA_FOLDER"/"$base".*temp.methyl

