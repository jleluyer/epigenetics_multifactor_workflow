#!/bin/bash

grep -v "#" ~/Databases/genome/Okisutch/latest/ref_Okis_V1_top_level.gff3 |awk -F "\t" '$3 == "gene"'|awk -F "\t" '{print $1"\t"$4"\t"$5"\t"$7"\t"$NF}' >01_info_files/gff_file.iranges 

