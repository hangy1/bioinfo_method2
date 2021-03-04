#!/usr/bin/env python3

from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Alphabet import generic_dna

SeqRecord = SeqRecord(seq = Seq("aaaatgggggggggggccccgtt",generic_dna), id = "#12345", description = "example 1")
SeqIO.write(SeqRecord, "BioPython_seq.gb","genbank")

