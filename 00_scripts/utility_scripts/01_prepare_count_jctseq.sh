#!/usr/bin/env bash
#PBS -N jctseq.__BASE__
#PBS -o 98_log_files/log-jctseq.__BASE__.err
#PBS -l walltime=02:00:00
#PBS -m ea
#PBS -l ncpus=1
#PBS -l mem=30g
#PBS -r n

. /appli/bioinfo/samtools/latest/env.sh

# Move to present working dir
cd $PBS_O_WORKDIR

base=__BASE__



# launch 
java -jar -Xmx25g /home1/datahome/jleluyer/softwares/QoRTs-STABLE.jar QC \
                --stranded \
                --nameSorted \
                --maxReadLength 100 \
                --genomeFA /home1/datawork/jleluyer/01_projects/transcriptome_assembly/gawn/03_data/Pmarg_trimmed.fasta --keepMultiMapped \
                --runFunctions writeKnownSplices,writeNovelSplices,writeSpliceExon \
                04_mapped/"$base".namesorted.genome.bam \
                /home1/datawork/jleluyer/01_projects/transcriptome_assembly/gawn/04_annotation/indexed_genome.gtf \
                05_count_jctseq/"$base"_jctseq/
