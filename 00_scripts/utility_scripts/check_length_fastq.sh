#!/bin/bash
#SBATCH -D ./ 
#SBATCH --job-name="check"
#SBATCH -o 98_log_files/check_size.out
#SBATCH -c 1
#SBATCH -p ibismini
#SBATCH -A ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=20-00:00
#SBATCH --mem=200

cd $SLURM_SUBMIT_DIR

for i in $(ls 03_trimmed/*fq)

do

wc -l $i >> file.size.temp
done

awk '{print $1/4,$2}' file.size.temp >size_file_trimmed.txt

# clean up

rm file.size.temp
