#!/usr/bin/env python3
#sliding_window_fasta.py

from __future__ import division
import sys


def sliding_window(k,dna):
    """
    read all the kmers of dna sequence
    """
    end = len(dna) - k + 1
    seqs = []
    for start in range(0,end):
        seq = line[start:start+k]
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

#open fasta file and read lines, process the line with sliding_window function and then gc_content function,print the result.         
with open(sys.argv[2],'r')as f:
    for line in f.readlines():
        line = line.strip()
        if len(line) < 1:
            continue
        elif line[0] ==">":
            print(line)
        else:
            seqs = []
            k = int(sys.argv[1])
            for i in range(len(line)-k+1):
                seqs = sliding_window(k,line)
                results = []
            for i in range(len(seqs)):
                result = gc_content(seqs[i])
                results.append(result)
                print("{}\t{:.2f}".format(seqs[i], results[i]))
 
if __name__ == "__main__" :
    k = int(sys.argv[1])
    arg_count = len(sys.argv)-1
    if arg_count < 2:
        raise Exception("This script requires at least 2 argument")
    elif k <= 0: 
        sys.exit("value of k must be > 0")







