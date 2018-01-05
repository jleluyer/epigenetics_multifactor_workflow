#!/usr/bin/env bash
#PBS -N prep_dss.__BASE__
#PBS -o log-prep_dss.__BASE__.out
#PBS -l walltime=20:00:00
#PBS -l mem=5g
#PBS -r n

cd $PBS_O_WORKDIR

# Global variables
DATA_FOLDER="05_results"
base=__BASE__

# prepare file for dss
awk '{print $1,$2,$6}' "$DATA_FOLDER"/"$base"_CpG.meth >"$DATA_FOLDER"/"$base".dss.1.temp
awk '{printf "%.0f\n",$5*$6}' "$DATA_FOLDER"/"$base"_CpG.meth >"$DATA_FOLDER"/"$base".dss.2.temp
paste "$DATA_FOLDER"/"$base".dss.1.temp "$DATA_FOLDER"/"$base".dss.2.temp >"$DATA_FOLDER"/"$base".temp.dss
cat 01_info_file/header.dss "$DATA_FOLDER"/"$base".temp.dss|sed -i 's/\t/ /g' >"$DATA_FOLDER"/"$base".dss

# clean up
rm "$DATA_FOLDER"/"$base"*.temp
rm "$DATA_FOLDER"/"$base"*temp.dss

