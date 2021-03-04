#!/usr/bin/env python3
<<<<<<< HEAD

=======
>>>>>>> 6136201473b41302108d7b33b238ef21ab9b14fd
import re
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.Alphabet import IUPAC
from Bio.SeqRecord import SeqRecord

<<<<<<< HEAD
#with open("APOE_refseq_transcript.fasta", "r") as fh_transcript:

    #for line in fh_transcript:
        #coding_dna = Seq(line, IUPAC.unambiguous_dna)
        #print(coding_dna)
def finding_orf(dna_seq):
=======

def finding_orf(dna_seq):
    '''
    it finds start and stop codon and trim the open reading frame
    '''
>>>>>>> 6136201473b41302108d7b33b238ef21ab9b14fd
    dna_orf = re.search('ATG([ATGC]{3})+?(TAA|TAG|TGA)', dna_seq).group()
    orf_for_translate = Seq(dna_orf)
    return orf_for_translate

def translation_dna(file_name, file_format):
<<<<<<< HEAD
=======
    '''
    it translate DNA to protein sequences
    '''
>>>>>>> 6136201473b41302108d7b33b238ef21ab9b14fd
    protein_list = []
    for seq_record in SeqIO.parse(file_name, file_format):
        seq_id = seq_record.id
        seq_descript = seq_record.description
        dna_seq = seq_record.seq
        dna_seq_str = str(dna_seq)
        orf_for_translate = finding_orf(dna_seq_str)
        protein_seq = orf_for_translate.translate()
        my_seqs = SeqRecord(protein_seq, id=seq_id, description = seq_descript)
        protein_list.append(my_seqs)
    return protein_list

def main():
    protein_list = translation_dna("APOE_refseq_transcript.fasta", "fasta")
<<<<<<< HEAD
    with open("APOE_refseq.fasta", "w") as handle_out:
=======
    with open("apoe_aa.fasta", "w") as handle_out:
>>>>>>> 6136201473b41302108d7b33b238ef21ab9b14fd
        SeqIO.write(protein_list, handle_out, "fasta" )

if __name__ == '__main__':
    main()



