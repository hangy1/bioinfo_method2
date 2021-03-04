#!/usr/bin/env python3
#sliding_window.py

from __future__ import division
import sys

def sliding_window(k,dna):
    """
    read all the kmers of dna sequence
    """
    end = len(dna) - k + 1
    seqs = []
    for start in range(0,end):
        seq = dna[start:start+k]
        seqs.append(seq)
    return seqs

def gc_content(seq):
    """
    calculate gc ratio in the sequence
    """
    seq = seq.lower()
    gc = 0
    for nucleotide in seq:
        if nucleotide in ['g', 'c']:
            gc = gc+1
    return gc/len(seq)

if __name__ == "__main__" :
    arg_count = len(sys.argv)-1
    if arg_count < 2:
        raise Exception("This script requires at least 2 argument")
    k = int(sys.argv[1])
    dna = sys.argv[2]
    seqs = sliding_window(k,dna)
    results = []
    for i in range(len(seqs)):
        result = gc_content(seqs[i])
        results.append(result)
        print("{}\t{:.2f}".format(seqs[i], results[i]))
        


