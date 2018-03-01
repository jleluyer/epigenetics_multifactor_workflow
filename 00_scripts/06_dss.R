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
ntrans.1.s<-read.table("05_results/ntrans.1.s.dss",header=T)
ntrans.1.t<-read.table("05_results/ntrans.1.t.dss",header=T)
ntrans.2.s<-read.table("05_results/ntrans.2.s.dss",header=T)
ntrans.2.t<-read.table("05_results/ntrans.2.t.dss",header=T)
trans.1.s<-read.table("05_results/trans1.s.dss",header=T)
trans.1.t<-read.table("05_results/trans1.t.dss",header=T)
trans.2.s<-read.table("05_results/trans2.s.dss",header=T)
trans.2.t<-read.table("05_results/trans2.t.dss",header=T)

#Make object DSS
BSobj <- makeBSseqData( list(ntrans.1.s, ntrans.2.s,ntrans.1.t,ntrans.2.t,trans.1.s,trans.2.s,trans.1.t,trans.2.t),c("NTS1","NTS2", "NTT1", "NTT2","TS1","TS2","TT1","TT2"))
save(BSobj,file="06_statistics/bsobj.dss.rda")
message("object done")

#Make design
Strain = c(rep("NT",4),rep("T",4))
Env = c(rep("S",2),rep("T",2),rep("S",2),rep("T",2))
design = data.frame(Strain,Env)
design

# Build model
DMLfit = DMLfit.multiFactor(BSobj, design=design, formula=~Strain+Env+Strain:Env)
save(DMLfit,file="06_statistics/dmlfit.dss.rda")

### Strain
# Testing
DMLtest.strain = DMLtest.multiFactor(DMLfit, coef=2)
write.table(DMLtest.strain,file="06_statistics/dss.strain.testing.txt",quote=F)
save(DMLtest.strain,file="06_statistics/dmltest.strain.dss.rda")

#DMR for multiple factor
DMRtest<-callDMR(DMLtest.strain, p.threshold=0.01, minlen=500, minCG=3, dis.merge=1000, pct.sig=0.5)
write.table(DMRtest,file="06_statistics/dss.strain.dmr.txt",quote=F)

### Environment
# Testing
DMLtest.env = DMLtest.multiFactor(DMLfit, coef=3)
write.table(DMLtest.env,file="06_statistics/dss.env.testing.txt",quote=F)
save(DMLtest.env,file="06_statistics/dmltest.env.dss.rda")

#DMR for multiple factor
DMRtest<-callDMR(DMLtest.env, p.threshold=0.01, minlen=500, minCG=3, dis.merge=1000, pct.sig=0.5)
write.table(DMRtest,file="06_statistics/dss.env.dmr.txt",quote=F)

### Interaction
# Testing
DMLtest.interaction = DMLtest.multiFactor(DMLfit, coef=4)
write.table(DMLtest.interaction,file="06_statistics/dss.interaction.testing.txt",quote=F)
save(DMLtest.interaction,file="06_statistics/dmltest.interaction.dss.rda")

#DMR for multiple factor
DMRtest<-callDMR(DMLtest.interaction, p.threshold=0.01, minlen=500, minCG=3, dis.merge=1000, pct.sig=0.5)
write.table(DMRtest,file="06_statistics/dss.interaction.dmr.txt",quote=F)
