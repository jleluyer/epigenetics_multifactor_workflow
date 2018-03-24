#!/bin/bash


# clean up
rm PREPIRG*sh

# Prepare jobs
for file in $(ls 06_statistics//*.dmr.txt|sed 's/.dmr.txt//g')

do
base="$(basename $file)"

    toEval="cat 00_scripts/07_prepare_irange.sh | sed 's/__BASE__/$base/g'"
    eval $toEval > PREPIRG_"$base".sh
done

# Submit jobs
for i in $(ls PREPIRG*sh)
do
    sbatch $i
done
