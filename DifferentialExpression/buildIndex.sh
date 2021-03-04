#!/usr/bin/env bash
# buildIndex.sh

#build a salmon index from the de-novo transcriptome in-t:transcript argument,-i: salmon index, k:size of kmer 
salmon index -t /scratch/SampleDataFiles/Trinity.fasta -i AipIndex k 25
