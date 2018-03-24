#!/usr/bin/Rscript

################ DSS script project transgenic coho ############
####################################################
ls()
rm(list=ls())
ls()

# Installing packages

#source("https://bioconductor.org/biocLite.R")
#biocLite("DSS")

# Load library
library(DSS)

#set working directory
setwd("epigenetics_multifactor_workflow/")

#Prepare dataset
trans.1.s<-read.table("05_results/HI.4381.005.Index_5.T-S_1.dss",header=T)
trans.1.t<-read.table("05_results/HI.4381.007.Index_7.T-T_1.dss",header=T)
trans.2.s<-read.table("05_results/HI.4381.006.Index_6.T-S_2.dss",header=T)
trans.2.t<-read.table("05_results/HI.4381.008.Index_8.T-T_2.dss",header=T)
ntrans.1.s<-read.table("05_results/HI.4381.001.Index_1.NT-S_1.dss",header=T)
ntrans.1.t<-read.table("05_results/HI.4381.003.Index_3.NT-T_1.dss",header=T)
ntrans.2.s<-read.table("05_results/HI.4381.002.Index_2.NT-S_2.dss",header=T)
ntrans.2.t<-read.table("05_results/HI.4381.004.Index_4.NT-T_2.dss",header=T)

#Make object DSS
BSobj <- makeBSseqData( list(ntrans.1.s, ntrans.2.s,ntrans.1.t,ntrans.2.t,trans.1.s,trans.2.s,trans.1.t,trans.2.t),c("NTS1","NTS2", "NTT1", "NTT2","TS1","TS2","TT1","TT2"))
save(BSobj,file="06_statistics/bsobj.dss.rda")

message("object completed")

#Make design
Strain = c(rep("NT",4),rep("T",4))
Env = c(rep("S",2),rep("T",2),rep("S",2),rep("T",2))
design = data.frame(Strain,Env)
design

# Build model
DMLfit = DMLfit.multiFactor(BSobj, design=design, formula=~Strain+Env+Strain:Env)
save(DMLfit,file="06_statistics/dmlfit.dss.rda")

message("model w/ interaction completed")

### Strain
# Testing
DMLtest.strain = DMLtest.multiFactor(DMLfit, coef=2)
write.table(DMLtest.strain,file="06_statistics/dss.strain.testing.txt",quote=F)
save(DMLtest.strain,file="06_statistics/dmltest.strain.dss.rda")

#DMR for multiple factor
DMRtest<-callDMR(DMLtest.strain, p.threshold=0.001, minlen=50, minCG=5, dis.merge=50, pct.sig=0.4)
write.table(DMRtest,file="06_statistics/dss.strain.dmr.txt",quote=F)
save(DMRtest,file="06_statistics/dmr.strain.dss.rda")

message("Strain effect completed")

### Environment
# Testing
DMLtest.env = DMLtest.multiFactor(DMLfit, coef=3)
write.table(DMLtest.env,file="06_statistics/dss.env.testing.txt",quote=F)
save(DMLtest.env,file="06_statistics/dmltest.env.dss.rda")

#DMR for multiple factor
DMRtest<-callDMR(DMLtest.env, p.threshold=0.001, minlen=50, minCG=5, dis.merge=50, pct.sig=0.4)
write.table(DMRtest,file="06_statistics/dss.env.dmr.txt",quote=F)
save(DMRtest,file="06_statistics/dmr.env.dss.rda")

message("Environment effect completed")

### Interaction
# Testing
DMLtest.interaction = DMLtest.multiFactor(DMLfit, coef=4)
write.table(DMLtest.interaction,file="06_statistics/dss.interaction.testing.txt",quote=F)
save(DMLtest.interaction,file="06_statistics/dmltest.interaction.dss.rda")

#DMR for multiple factor
DMRtest<-callDMR(DMLtest.interaction, p.threshold=0.001, minlen=50, minCG=5, dis.merge=50, pct.sig=0.4)
write.table(DMRtest,file="06_statistics/dss.interaction.dmr.txt",quote=F)
save(DMRtest,file="06_statistics/dmr.interaction.dss.rda")

message("Interaction effect completed")
message("Data saved .rda for DMR visualization")
