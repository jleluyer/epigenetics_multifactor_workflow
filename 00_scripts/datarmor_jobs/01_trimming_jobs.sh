#!/bin/bash

# clean up
rm TRIM*sh

# Prepare jobs
for file in $(ls 02_data|sed 's/.fastq.gz//g')

do
base="$(basename $file)"

    toEval="cat 00_scripts/01_trimming.sh | sed 's/__BASE__/$base/g'"
    eval $toEval > TRIM_"$base".sh
done

# Submit jobs
for i in $(ls TRIM*sh)
do
    qsub $i
done
