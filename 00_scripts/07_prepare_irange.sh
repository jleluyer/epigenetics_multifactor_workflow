#!/usr/bin/env bash
#SBATCH -D ./ 
#SBATCH --job-name="prepirqnge.__BASE__"
#SBATCH -o 98_log_files/log-prepirange.__BASE__.out
#SBATCH -c 1
#SBATCH -p ibismini
#SBATCH -A ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=20-00:00
#SBATCH --mem=2000

cd $SLURM_SUBMIT_DIR

# Global variables
base=__BASE__

# prepare file for dss
cat 06_statistics/"$base".dmr.txt |grep -v chr|awk '{print $2"\t"$3"\t"$4"\t""+""\t"$NF}' > 06_statistics/"$base".temp
cat 01_info_files/header_irange.txt 06_statistics/"$base".temp > 06_statistics/"$base".iranges

# clean up
rm 06_statistics/"$base".*.temp

