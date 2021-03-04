#!/usr/bin/env Rscript
# AnalyzeOutSpattFrom2Genomes.R

options("scipen" = 30)#don't print final output with exponents up to e-30

#print a usage statement 
usage <- "\nUsage: AnalyzeOutSpattFrom2Genomes.R <Pyrococcus_horikoshii.fasta.8.m1.allwords_Pyrococcus_abyssi.fasta.8.m1.allwords.txt>\n\n"

#tell R to get arguments from command, 
args <- commandArgs(trailingOnly = TRUE)
print(args)

#test if the arguments are passed
if(length(args) == 0) {
        cat(prompt=usage)
    q(save="no")
}
#create a data frame
file_for_spatt <- read.table(args[1], sep="\t", header=FALSE)

#put names on each column in the data frame
names(file_for_spatt) <- c("kmer1","occurrence1","expected1", "pvalue1",
                         "kmer2","occurrence2","expected2", "pvalue2") 

#Add new column to data frame, and give all 0
file_for_spatt["probablity_occurrence"] <- 0

#fill the column
file_for_spatt$probablity_occurrence <- (file_for_spatt$expected1 / (file_for_spatt$expected1 + file_for_spatt$expected2))

file_for_spatt["trials"] <- 0
file_for_spatt$trials <-  file_for_spatt$occurrence1 + file_for_spatt$occurrence2

file_for_spatt["binomial_upper_tail"] <- 0
file_for_spatt$binomial_upper_tail <- pbinom(file_for_spatt$occurrence1-1,
                                           file_for_spatt$trials,
                                           file_for_spatt$probablity_occurrence,
                                           lower.tail=FALSE)
#write output to a file I can open in Excel
write.table(file_for_spatt, file="out.txt", sep="\t", row.names = FALSE)
