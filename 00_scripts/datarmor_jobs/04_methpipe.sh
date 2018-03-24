#!/bin/bash


# clean up
rm METH*sh

# Prepare jobs
for file in $(ls 03_trimmed/*.mr|grep -v "NT-S_1"|sed 's/.mr//g')

do
base="$(basename $file)"

    toEval="cat 00_scripts/04_methpipe.sh | sed 's/__BASE__/$base/g'"
    eval $toEval > METH_"$base".sh
done
exit
# Submit jobs
for i in $(ls METH*sh)
do
    sbatch $i
done
