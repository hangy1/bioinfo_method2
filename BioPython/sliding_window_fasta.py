#!/usr/bin/env python3
#sliding_window_fasta.py

import sys
from Bio import SeqIO

def sliding_window(k,dna):
    """find all the kmer in dna """
    end = len(dna) - k + 1
    seqs = []
    for start in range(0,end):
        seq = line[start:start+k]
        seqs.append(seq)
    return seqs

def gc_content(seq):
    """calculate GC ratio in seq"""
    seq = seq.lower()
    gc = 0
    for nucleotide in seq:
        if nucleotide in ['g', 'c']:
            gc = gc+1
    return gc/len(seq)

with open(sys.argv[2])as f:
    for record in SeqIO.parse(f,"fasta"):
        line = record.seq
        k = int(sys.argv[1])
        #for i in range(len(record)-k+1):
        kmers = []
        kmers = sliding_window(k,line)
        print(len(kmers))
        results = []
        for i in range(len(kmers)):
            result = gc_content(kmers[i])
            results.append(result)
            print("{}\t{:.2f}".format(kmers[i], results[i]))
 
if __name__ == "__main__" :
    k = int(sys.argv[1])
    arg_count = len(sys.argv)-1
    if arg_count < 2:
        raise Exception("This script requires at least 2 argument")
    elif k <= 0: 
        sys.exit("value of k must be > 0")







