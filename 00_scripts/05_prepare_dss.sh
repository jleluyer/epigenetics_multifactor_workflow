#!/usr/bin/env bash
#SBATCH -D ./ 
#SBATCH --job-name="prepdss.__BASE__"
#SBATCH -o 98_log_files/log-prepdss.__BASE__.out
#SBATCH -c 1
#SBATCH -p ibismini
#SBATCH -A ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=20-00:00
#SBATCH --mem=2000

cd $SLURM_SUBMIT_DIR

# Global variables
DATA_FOLDER="05_results"
base=__BASE__

# prepare file for dss
awk '{print $1,$2,$6}' "$DATA_FOLDER"/"$base"_CpG.meth >"$DATA_FOLDER"/"$base".dss.1.temp
awk '{printf "%.0f\n",$5*$6}' "$DATA_FOLDER"/"$base"_CpG.meth >"$DATA_FOLDER"/"$base".dss.2.temp
paste "$DATA_FOLDER"/"$base".dss.1.temp "$DATA_FOLDER"/"$base".dss.2.temp >"$DATA_FOLDER"/"$base".temp.dss
cat 01_info_files/header.dss "$DATA_FOLDER"/"$base".temp.dss|sed 's/\t/ /g' >"$DATA_FOLDER"/"$base".dss

# clean up
rm "$DATA_FOLDER"/"$base".*.temp
rm "$DATA_FOLDER"/"$base".*temp.dss

