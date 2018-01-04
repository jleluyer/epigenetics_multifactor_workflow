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
setwd("/home1/datawork/jleluyer/01_projects/test_walt/")

#Prepare dataset
ntrans.1.s<-read.table("ntrans.1.s.dss",header=T)
ntrans.1.t<-read.table("ntrans.1.t.dss",header=T)
ntrans.2.s<-read.table("ntrans.2.s.dss",header=T)
ntrans.2.t<-read.table("ntrans.2.t.dss",header=T)
trans1.s<-read.table("trans1.s.dss",header=T)
trans1.t<-read.table("trans1.t.dss",header=T)
trans2.s<-read.table("trans2.s.dss",header=T)
trans2.t<-read.table("trans2.t.dss",header=T)

#Make object DSS
BSobj <- makeBSseqData( list(ntrans.1.s, ntrans.2.s,ntrans.1.t,ntrans.2.t,trans1.s,trans2.s,trans1.t,trans2.t),c("NTS1","NTS2", "NTT1", "NTT2","TS1","TS2","TT1","TT2"))
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

# Testing
DMLtest.interaction = DMLtest.multiFactor(DMLfit, coef=4)
write.table(DMLtest.interaction,file="06_statistics/dss.interaction.testing.txt",quote=F)

# Sort output
ix=sort(DMLtest.interaction[,"pvals"], index.return=TRUE)$ix
head(DMLtest.interaction[ix,])

# stats distribution
pdf("06_statistics/dss.stat.pdf",width=12,height=12);hist(DMLtest.interaction$stat, 50, main="test statistics", xlab=""); dev.off()
pdf("06_statistics/dss.pvals.pdf",width=12,height=12);hist(DMLtest.interaction$pvals, 50, main="P values", xlab=""); dev.off()


#DMR for multiple factor
DMRtest<-callDMR(DMLtest.interaction, p.threshold=0.01)
write.table(DMRtest,file="06_statistics/dss.interaction.dmr.txt",quote=F)
