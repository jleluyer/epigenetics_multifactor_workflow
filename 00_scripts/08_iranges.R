#!/usr/bin/Rscript

library(GenomicRanges)


#load Data
datainteraction <-read.table("06_statistics/dss.interaction.iranges",header=T,sep="\t")
dataenv <-read.table("06_statistics/dss.env.iranges",header=T,sep="\t")
datastrain <-read.table("06_statistics/dss.strain.iranges",header=T,sep="\t")
datagff <-read.table("01_info_files/gff_file.iranges",header=T,sep="\t")

#total dmr
dmrinter<-makeGRangesFromDataFrame(datainteraction,
                                        keep.extra.columns=TRUE,
                                        ignore.strand=FALSE,
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
                                        keep.extra.columns=TRUE,
                                        ignore.strand=FALSE,
                                        seqinfo=NULL,
                                        seqnames.field="Chr",
                                        start.field="Start",
                                        end.field="End",
                                        strand.field="Strand",
                                        starts.in.df.are.0based=FALSE)

trans.gff.5kb<-makeGRangesFromDataFrame(datagff,
dmrstrain<-makeGRangesFromDataFrame(datastrain,
                                        keep.extra.columns=TRUE,
                                        ignore.strand=FALSE,
                                        seqinfo=NULL,
                                        seqnames.field="Chr",
                                        start.field="Start",
                                        end.field="End",
                                        strand.field="Strand",
                                        starts.in.df.are.0based=FALSE)

start(trans.gff.5kb)<-start(trans.gff.5kb) - 5000
end(trans.gff.5kb)<-end(trans.gff.5kb) + 5000

trans.DE.inter.5kb<-makeGRangesFromDataFrame(dataDE,
trans.gff<-makeGRangesFromDataFrame(datagff,
                                        keep.extra.columns=TRUE,
                                        ignore.strand=FALSE,
                                        seqinfo=NULL,
                                        seqnames.field="Chr",
                                        start.field="Start",
                                        end.field="End",
                                        strand.field="Strand",
                                        starts.in.df.are.0based=FALSE)

start(trans.DE.inter.5kb)<-start(trans.DE.inter.5kb) - 5000
end(trans.DE.inter.5kb)<-end(trans.DE.inter.5kb) + 5000



### determine region with at least 3 CpG
hitinter<-findOverlaps(trans.gff,dmrinter)
hitinter.inter<-data.frame(trans.gff[queryHits(hitinter),], dmrinter[subjectHits(hitinter),])
write.table(hitinter.inter,"06_statistics/iranges/overlap.interaction.txt",quote=F)

hitinter<-findOverlaps(trans.gff,dmrenv)
hitinter.env<-data.frame(trans.gff[queryHits(hitinter),], dmrenv[subjectHits(hitinter),])
write.table(hitinter.env,"06_statistics/iranges/overlap.env.txt",quote=F)

hitinter<-findOverlaps(trans.gff,dmrstrain)
hitinter.strain<-data.frame(trans.gff[queryHits(hitinter),], dmrstrain[subjectHits(hitinter),])
write.table(hitinter.strain,"06_statistics/iranges/overlap.strain.txt",quote=F)

hitinter<-findOverlaps(trans.gff.5kb,dmrinter)
hitinter.inter<-data.frame(trans.gff.5kb[queryHits(hitinter),], dmrinter[subjectHits(hitinter),])
write.table(hitinter.inter,"06_statistics/iranges/overlap.interaction.5kb.txt",quote=F)

hitinter<-findOverlaps(trans.gff.5kb,dmrenv)
hitinter.env<-data.frame(trans.gff.5kb[queryHits(hitinter),], dmrenv[subjectHits(hitinter),])
write.table(hitinter.env,"06_statistics/iranges/overlap.env.5kb.txt",quote=F)

hitinter<-findOverlaps(trans.gff.5kb,dmrstrain)
hitinter.strain<-data.frame(trans.gff.5kb[queryHits(hitinter),], dmrstrain[subjectHits(hitinter),])
write.table(hitinter.strain,"06_statistics/iranges/overlap.strain.5kb.txt",quote=F)

hitinter<-findOverlaps(trans.DE.inter.5kb,dmrinter)
hitinter.de.dmr<-data.frame(trans.DE.inter.5kb[queryHits(hitinter),], dmrinter[subjectHits(hitinter),])
write.table(hitinter.de.dmr,"06_statistics/iranges/overlap.DE.5kb.dmrinter.txt",quote=F)

# Validate interaction
hitinter<-findOverlaps(dmrenv,dmrinter)
hitinter.checkenv<-data.frame(dmrenv[queryHits(hitinter),], dmrinter[subjectHits(hitinter),])
write.table(hitinter.checkenv,"06_statistics/iranges/overlap.checkenv.txt",quote=F)

hitinter<-findOverlaps(dmrstrain,dmrinter)
hitinter.checkstrain<-data.frame(dmrstrain[queryHits(hitinter),], dmrinter[subjectHits(hitinter),])
write.table(hitinter.checkstrain,"06_statistics/iranges/overlap.checkstrain.txt",quote=F)
write.table(hitinter.inter,"06_statistics/overlap.interaction.txt",quote=F)

hitinter<-findOverlaps(trans.gff,dmrenv)
hitinter.env<-data.frame(trans.gff[queryHits(hitinter),], dmrenv[subjectHits(hitinter),])
write.table(hitinter.env,"06_statistics/overlap.env.txt",quote=F)

hitinter<-findOverlaps(trans.gff,dmrstrain)
hitinter.strain<-data.frame(trans.gff[queryHits(hitinter),], dmrstrain[subjectHits(hitinter),])
write.table(hitinter.strain,"06_statistics/overlap.strain.txt",quote=F)
