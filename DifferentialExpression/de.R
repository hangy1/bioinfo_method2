#!/usr/bin/env Rscript
# de.R
library(tximport)
library(readr)
library(DESeq2)
library(knitr)

#load tx2gene.csv file
tx2gene <- read.csv("tx2gene.csv")
head(tx2gene)
#load Samples.csv
samples <- read.csv("/scratch/SampleDataFiles/Samples.csv", header=TRUE)
head(samples)
files <- file.path("quant", samples$Sample, "quant.sf")
txi <- tximport(files, type="salmon", tx2gene=tx2gene)
dds <- DESeqDataSetFromTximport(txi, colData = samples, 
                                design = ~ Menthol + Vibrio)
dds$Vibrio <- relevel(dds$Vibrio, ref = "Control")
dds$Menthol <- relevel(dds$Menthol, ref = "Control")
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]
dds <- DESeq(dds)
padj <- .05
minLog2FoldChange <- .5
dfAll <- data.frame()
# Get all DE results except Intercept, and "flatten" into a single file.
for (result in resultsNames(dds)){
        if(result != 'Intercept'){
            res <- results(dds, alpha=.05, name=result)
            dfRes <- as.data.frame(res)
            dfRes <- subset(subset(dfRes, select=c(log2FoldChange, padj)))
            dfRes$Factor <- result
            dfAll <- rbind(dfAll, dfRes)
        }
}
head(dfAll)
write.csv(dfAll, file="dfAll.csv")
# Select genes that has p value less than 0.05
dfAll <- subset(dfAll, dfAll$padj < 0.05)
kable(head(dfAll)
# Read blastKo and merge it with dfAll table
blastKo <- read.csv("blastKo.csv")
deAnnotate <- merge(dfAll, blastKo)
kable(head(deAnnotate))
write.csv(deAnnotate, file = "deAnnotate.csv")
