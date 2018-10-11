#!/bin/bash
#PBS -N prep
#PBS -o 98_log_files/log-bedtools.out
#PBS -l walltime=1:00:00
#PBS -l mem=6g
#PBS -r n

cd $PBS_O_WORKDIR

#usage
#. /appli/bioinfo/bedtools/latest/env.sh


#bedtools window [OPTIONS] -a <bed/gff/vcf> -b

#Genotype
bedtools window -bed -w 5000 -a 01_info_files/list_genes.bed -b 01_info_files/dmr.strain.bed >06_statistics/overlap.dmr.gene.bed
bedtools window -bed -a 01_info_files/list_genes.bed -b 01_info_files/dmr.strain.bed >06_statistics/overlap.dmr.gene.intronic.bed

bedtools window -bed -w 5000 -a 01_info_files/list.de.genotype.bed -b 01_info_files/dmr.strain.bed >06_statistics/overlap.dmr.DE.gene.bed

#Environment
bedtools window -bed -w 5000 -a 01_info_files/list.de.environment.bed -b 01_info_files/dmr.environment.bed >06_statistics/overlap.dmr.DE.environment.bed

bedtools window -bed -w 5000 -a 01_info_files/list_genes.bed -b 01_info_files/dmr.environment.bed >06_statistics/overlap.dmr.environment.bed
bedtools window -bed -a 01_info_files/list_genes.bed -b 01_info_files/dmr.environment.bed >06_statistics/overlap.dmr.environment.intronic.bed

# Interaction
bedtools window -bed -w 5000 -a 01_info_files/list_genes.bed -b 01_info_files/dmr.interaction.bed >06_statistics/overlap.dmr.interaction.bed
bedtools window -bed -a 01_info_files/list_genes.bed -b 01_info_files/dmr.interaction.bed >06_statistics/overlap.dmr.interaction.intronic.bed

bedtools window -bed -w 5000 -a 01_info_files/list.de.interaction.bed -b 01_info_files/dmr.interaction.bed >06_statistics/overlap.dmr.DE.interaction.bed

# check overlap strain X genotype X interaction
bedtools window -bed -a 01_info_files/dmr.interaction.bed -b 01_info_files/dmr.environment.bed >06_statistics/overlap.check.env.interaction.bed
bedtools window -bed -a 01_info_files/dmr.interaction.bed -b 01_info_files/dmr.strain.bed >06_statistics/overlap.check.genotype.interaction.bed
bedtools window -bed -a 01_info_files/dmr.strain.bed -b 01_info_files/dmr.environment.bed >06_statistics/overlap.check.genotype.env.bed

# check overlap 
bedtools window -bed -w 5000 -a 01_info_files/list_genes.bed -b 01_info_files/dmr.check.interaction.genotype.bed >06_statistics/overlap.genotypexinteraction.bed
bedtools window -bed -w 5000 -a 01_info_files/list_genes.bed -b 01_info_files/dmr.check.env.interaction.bed >06_statistics/overlap.environmentxinteraction.bed
bedtools window -bed -w 5000 -a 01_info_files/list_genes.bed -b 01_info_files/dmr.check.env.genotype.bed >06_statistics/overlap.environment+genotype.bed


#10kb regions
#Genotype
bedtools window -bed -w 10000 -a 01_info_files/list_genes.bed -b 01_info_files/dmr.strain.bed >06_statistics/overlap.dmr.gene.10kb.bed
bedtools window -bed -w 10000 -a 01_info_files/list.de.genotype.bed -b 01_info_files/dmr.strain.bed >06_statistics/overlap.dmr.DE.gene.10kb.bed

#Environment
bedtools window -bed -w 10000 -a 01_info_files/list.de.environment.bed -b 01_info_files/dmr.environment.bed >06_statistics/overlap.dmr.DE.environment.10kb.bed
bedtools window -bed -w 10000 -a 01_info_files/list_genes.bed -b 01_info_files/dmr.environment.bed >06_statistics/overlap.dmr.environment.10kb.bed

# Interaction
bedtools window -bed -w 10000 -a 01_info_files/list_genes.bed -b 01_info_files/dmr.interaction.bed >06_statistics/overlap.dmr.interaction.10kb.bed
bedtools window -bed -w 10000 -a 01_info_files/list.de.interaction.bed -b 01_info_files/dmr.interaction.bed >06_statistics/overlap.dmr.DE.interaction.10kb.bed


# check overlap conta
bedtools window -bed -w 10000 -a 01_info_files/list_genes.bed -b 01_info_files/dmr.check.interaction.genotype.bed >06_statistics/overlap.genotypexinteraction.10kb.bed
bedtools window -bed -w 10000 -a 01_info_files/list_genes.bed -b 01_info_files/dmr.check.env.interaction.bed >06_statistics/overlap.environmentxinteraction.10kb.bed
bedtools window -bed -w 10000 -a 01_info_files/list_genes.bed -b 01_info_files/dmr.check.env.genotype.bed >06_statistics/overlap.environment+genotype.10kb.bed
