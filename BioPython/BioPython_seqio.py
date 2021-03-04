#!/usr/bin/env python3

import sys
from Bio import SeqIO
from Bio.SeqRecord import SeqRecord

NEW_RECORDS = []
with open(sys.argv[1]) as handle:
    for record in SeqIO.parse(handle, "fasta"):
    #extract id and seqs from each record, reverse the seqs using complement.()
        header = record.id
        seq = record.seq
        rev_seq = seq.reverse_complement()
    #write new records by using SeqRecord, and append each new record to New_Records list.
        rev_record = SeqRecord(rev_seq, id=header, description="reverse complemetnary")
        NEW_RECORDS.append(rev_record)
    #write output fasta file  by using SeqIO
        SeqIO.write(NEW_RECORDS, sys.argv[2], "fasta")
