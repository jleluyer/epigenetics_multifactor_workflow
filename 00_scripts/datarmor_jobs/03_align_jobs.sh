#!/bin/bash


# clean up
rm ALIGN*sh

# Prepare jobs
for file in $(ls 03_trimmed/*fq|sed -e 's/_R[12].fq//g'|sort -u)

do
base="$(basename $file)"

    toEval="cat 00_scripts/03_align.sh | sed 's/__BASE__/$base/g'"
    eval $toEval > ALIGN_"$base".sh
done

# Submit jobs
for i in $(ls ALIGN*sh)
do
    qsub $i
done
