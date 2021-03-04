#!/usr/bin/env Rscript
# mergeKo.R
# Load the kable library to display formatted tables
library(knitr)

#load BLAST results, swisspro to kegg, and kegg to ko
blastFile <- "/scratch/SampleDataFiles/Annotation/transcriptBlast.txt"
keggFile <- "/scratch/SampleDataFiles/Annotation/kegg.txt"
koFile <- "/scratch/SampleDataFiles/Annotation/ko.txt"

#read files as tables 
blast <- read.table(blastFile, sep="\t", header=FALSE)
kegg <- read.table(keggFile, sep="\t", header=FALSE)
ko <- read.table(koFile, sep="\t", header=FALSE)

#set column names for each tables
colnames(blast) <- c("trans", "sp", "qlen", "slen", "bitscore", 
                     "length", "nident", "pident", "evalue", "ppos")
colnames(kegg) <- c("sp", "kegg")
colnames(ko) <- c("kegg", "ko")

# Calculate the percentage of identical matches relative to subject length in BLAST result 
blast$cov <- blast$nident/blast$slen
#add cov as a new column and filter for at least 50% coverage of subject(SwissProt) sequence
blast <- subset(blast, cov > .5)
# Remove the up: prefix from sp column
kegg$sp <- gsub("up:","",kegg$sp)

# Merge BLAST and SwissProt-to-KEGG, and Merge BLAST+KEGG and KO
blastKegg <- merge(blast, kegg)
blastKo <- merge(blastKegg, ko)
write.csv(blastKo, file = "blastKo.csv",row.names = FALSE)
#create txwgene with column trans and ko
tx2gene <- unique(subset(blastKo, select=c(trans, ko)))
kable(head(tx2gene))
# Write as a csv file, excluding row.names
write.csv(tx2gene, file="tx2gene.csv", row.names=FALSE)
