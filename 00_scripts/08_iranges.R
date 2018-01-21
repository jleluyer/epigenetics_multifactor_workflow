#!/usr/bin/Rscript

library(GenomicRanges)

setwd("/home/jelel8/epic4_projects/transgenic/epigenetics/epigenetics_multifactor_workflow")

#load Data
datainteraction <-read.table("06_statistics/dss.interaction.iranges",header=T,sep="\t")
dataenv <-read.table("06_statistics/dss.env.iranges",header=T,sep="\t")
datastrain <-read.table("06_statistics/dss.strain.iranges",header=T,sep="\t")
datagff <-read.table("01_info_files/gff_file.iranges",header=T,sep="\t")

#total dmr
dmrinter<-makeGRangesFromDataFrame(datainteraction,
                                        keep.extra.columns=TRUE,
                                        ignore.strand=TRUE,
                                        seqinfo=NULL,
                                        seqnames.field="Chr",
                                        start.field="Start",
                                        end.field="End",
                                        strand.field="Strand",
                                        starts.in.df.are.0based=FALSE)

dmrenv<-makeGRangesFromDataFrame(dataenv,
                                        keep.extra.columns=TRUE,
                                        ignore.strand=TRUE,
                                        seqinfo=NULL,
                                        seqnames.field="Chr",
                                        start.field="Start",
                                        end.field="End",
                                        strand.field="Strand",
                                        starts.in.df.are.0based=FALSE)
dmrstrain<-makeGRangesFromDataFrame(datastrain,
                                        keep.extra.columns=TRUE,
                                        ignore.strand=TRUE,
                                        seqinfo=NULL,
                                        seqnames.field="Chr",
                                        start.field="Start",
                                        end.field="End",
                                        strand.field="Strand",
                                        starts.in.df.are.0based=FALSE)

trans.gff<-makeGRangesFromDataFrame(datagff,
                                        keep.extra.columns=FALSE,
                                        ignore.strand=TRUE,
                                        seqinfo=NULL,
                                        seqnames.field="Chr",
                                        start.field="Start",
                                        end.field="End",
                                        strand.field="Strand",
                                        starts.in.df.are.0based=FALSE)


#find overlaps

### determine region with at least 3 CpG
hitinter<-findOverlaps(trans.gff,dmrinter)
hitinter.inter<-data.frame(trans.gff[queryHits(hitinter),], dmrinter[subjectHits(hitinter),])
write.table(hitinter.inter,"06_statistics/overlap.interaction.txt",quote=F)

hitinter<-findOverlaps(trans.gff,dmrenv)
hitinter.env<-data.frame(trans.gff[queryHits(hitinter),], dmrenv[subjectHits(hitinter),])
write.table(hitinter.env,"06_statistics/overlap.env.txt",quote=F)

hitinter<-findOverlaps(trans.gff,dmrstrain)
hitinter.strain<-data.frame(trans.gff[queryHits(hitinter),], dmrstrain[subjectHits(hitinter),])
write.table(hitinter.strain,"06_statistics/overlap.strain.txt",quote=F)
