#!/usr/bin/env python
#hamming.py

import sys
def hamming(seq1,seq2):
    mismatch = 0
    for char1, char2 in zip(seq1,seq2):
        if char1 != char2:
            mismatch = mismatch +1
    return mismatch        

if __name__ == "__main__":
    seq1 = sys.argv[1]
    seq2 = sys.argv[2]
    if len(seq1) != len(seq2):
        sys.exit("Error:Sequences need to have the same length")
    print("{}\t{}\t{}".format(seq1,seq2,hamming(seq1,seq2)))


