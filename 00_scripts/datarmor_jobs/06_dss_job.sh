#!/bin/bash
#PBS -N dss
#PBS -o log-dss.out
#PBS -l walltime=20:00:00
#PBS -l mem=50g
#PBS -r n

cd $PBS_O_WORKDIR

Rscript --vanilla 00_scripts/06_dss.R
