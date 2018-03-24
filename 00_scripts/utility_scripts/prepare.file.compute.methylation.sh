#!/bin/bash

paste interaction.regions.HI.4381.001.Index_1.NT-S_1.meth interaction.regions.HI.4381.002.Index_2.NT-S_2.meth interaction.regions.HI.4381.003.Index_3.NT-T_1.meth interaction.regions.HI.4381.004.Index_4.NT-T_2.meth interaction.regions.HI.4381.005.Index_5.T-S_1.meth interaction.regions.HI.4381.006.Index_6.T-S_2.meth interaction.regions.HI.4381.007.Index_7.T-T_1.meth interaction.regions.HI.4381.008.Index_8.T-T_2.meth|awk '{print $1"_"$2"_"$3,$5,$11,$17,$23,$29,$35,$41,$47}' >join_methylation.interaction.txt

awk '{print $2"\t"$3"\t"$4}' 06_statistics/overlap.checkenv.txt >temp
grep -v -f temp 06_statistics/dss.env.iranges|awk '{print $1"\t"$2"\t"$3}'|grep -v Start >01_info_files/temp
LC_ALL=C sort -k1,1 -k2,2n -k3,3n -o 01_info_files/region.environment.bed 01_info_files/temp
