#!/bin/bash


# clean up
rm AVG*sh

# Prepare jobs
for file in $(ls 05_results/*CpG.meth|sed 's/_CpG.meth//g')

do
base="$(basename $file)"
toEval="cat 00_scripts/utility_scripts/compute_mean_methyl_global.sh | sed 's/__BASE__/$base/g'"
#    toEval="cat 00_scripts/utility_scripts/compute_mean_methylation.sh | sed 's/__BASE__/$base/g'"
    eval $toEval > AVG_"$base".sh
done

# Submit jobs
for i in $(ls AVG*sh)
do
    sbatch $i
done
