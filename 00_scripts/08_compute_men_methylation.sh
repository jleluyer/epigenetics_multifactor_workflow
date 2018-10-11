#!/bin/bash
#PBS -N prep
#PBS -o 98_log_files/log-roimethstat__BASE__.out
#PBS -l walltime=1:00:00
#PBS -l mem=6g
#PBS -r n

. /appli/bioinfo/methpipe/3.4.3/env.sh 

cd $PBS_O_WORKDIR

## TO add
#prepare input .txt files for bedtools

#global variables
DATA_FOLDER="05_results"
DATAOUTPUT="10_average_methylation_by_regions"
INTERACTION="01_info_files/genome.bed"
interaction_dmr="01_info_files/dmr.interaction.bed"
environment_dmr="01_info_files/dmr.environment.bed"
genotype_dmr="01_info_files/dmr.strain.bed"
utr3_dmr="01_info_files/utr3prime.bed"
genes="01_info_files/list_genes.bed"

base=__BASE__

roimethstat -o "$DATAOUTPUT"/mean."$base".meth "$INTERACTION" "$DATA_FOLDER"/"$base"_CpG.meth

sed 's/:/\t/g' "$DATAOUTPUT"/mean."$base".meth |awk '$5 > 2'|awk '$7 > 10'|awk '{print $1"_"$2"_"$3"\t"$8}' >"$DATAOUTPUT"/Trim."$base".meth

roimethstat -o "$DATAOUTPUT"/mean.interaction."$base".meth "$interaction_dmr" "$DATA_FOLDER"/"$base"_CpG.meth
roimethstat -o "$DATAOUTPUT"/mean.genotype."$base".meth "$genotype_dmr" "$DATA_FOLDER"/"$base"_CpG.meth
roimethstat -o "$DATAOUTPUT"/mean.environment."$base".meth "$environment_dmr" "$DATA_FOLDER"/"$base"_CpG.meth
roimethstat -o "$DATAOUTPUT"/mean.3utr."$base".meth "$utr3_dmr" "$DATA_FOLDER"/"$base"_CpG.meth
roimethstat -o "$DATAOUTPUT"/mean.genes."$base".meth "$genes" "$DATA_FOLDER"/"$base"_CpG.meth

awk -F "\t" '{print $1"_"$2"_"$3"\t"$5}' "$DATAOUTPUT"/mean.interaction."$base".meth >"$DATAOUTPUT"/Trim.interaction."$base".meth
awk -F "\t" '{print $1"_"$2"_"$3"\t"$5}' "$DATAOUTPUT"/mean.environment."$base".meth >"$DATAOUTPUT"/Trim.environment."$base".meth
awk -F "\t" '{print $1"_"$2"_"$3"\t"$5}' "$DATAOUTPUT"/mean.genotype."$base".meth >"$DATAOUTPUT"/Trim.genotype."$base".meth
awk -F "\t" '{print $1"_"$2"_"$3"\t"$5}' "$DATAOUTPUT"/mean.3utr."$base".meth >"$DATAOUTPUT"/Trim.3utr."$base".meth
awk -F "\t" '{print $1"_"$2"_"$3"\t"$5}' "$DATAOUTPUT"/mean.genes."$base".meth >"$DATAOUTPUT"/Trim.genes."$base".meth
