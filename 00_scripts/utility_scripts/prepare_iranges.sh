#!/bin/bash


awk '{print $2"\t"$3"\t"$4"\t""*""\t"$NF}' 06_statistics/dss.interaction.dmr.txt|grep -v "start" >temp

cat 01_info_files/header.iranges temp >06_statistics/iranges/dss.interaction.iranges

awk '{print $2"\t"$3"\t"$4"\t""*""\t"$NF}' 06_statistics/dss.strain.dmr.txt|grep -v "start" >temp

cat 01_info_files/header.iranges temp >06_statistics/iranges/dss.genotype.iranges

awk '{print $2"\t"$3"\t"$4"\t""*""\t"$NF}' 06_statistics/dss.env.dmr.txt|grep -v "start" >temp

cat 01_info_files/header.iranges temp >06_statistics/iranges/dss.environment.iranges


rm temp
