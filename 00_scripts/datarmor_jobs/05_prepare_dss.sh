#!/bin/bash


# clean up
rm PREPDSS*sh

# Prepare jobs
for i in $(ls 05_results*_CpG.meth|sed 's/_CpG.meth//g')

do
base="$(basename $file)"

    toEval="cat 00_scripts/05_prepare_dss.sh | sed 's/__BASE__/$base/g'"
    eval $toEval > PREPDSS_"$base".sh
done

# Submit jobs
for i in $(ls PREPDSS*sh)
do
    qsub $i
done
