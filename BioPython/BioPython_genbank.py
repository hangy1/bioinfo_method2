#!/usr/bin/env python3

from Bio import Entrez
from Bio import SeqIO

Entrez.email = "yin.hang1@husky.neu.edu"

#print the sequences with designated ids
seq_list = []
ids = ["515056", "J01673.1"]
for i in range(len(ids)):
    with Entrez.efetch(
        db="nucleotide", id=ids[i], rettype="gb", retmode="text"
        ) as handle:
        seq_record = SeqIO.read(handle, "gb")
        seq_list.append(seq_record)

#Prints out the type, location, and strand of each feature
for entry in seq_list:
    print(entry.name)
    for feature in entry.features:
        print("{}".format(feature.type,feature.strand, feature.location))
