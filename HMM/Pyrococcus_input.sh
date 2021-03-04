#!/usr/bin/env sh
#Pyrococcus_input.sh
#Analyze all kmers of length 8 using a 1st order Markov model for genome Pyrococcus_abyssi.fast\Pyrococcus_horikoshii.fasta, Combine the outputs from steps 1 and 2 into one file

    
sspatt Pyrococcus_abyssi.fasta -l 8 -m 1 --all-words >Pyrococcus_abyssi.fasta.8.m1.allwords.txt
sspatt Pyrococcus_horikoshii.fasta -l 8 -m 1 --all-words >Pyrococcus_horikoshii.fasta.8.m1.allwords.txt
#paste is utility which is used to join files horizontally (parallel merging) by outputting lines consisting of the sequentially corresponding lines of each file specified, separated by tabs, to the standard output.
paste Pyrococcus_horikoshii.fasta.8.m1.allwords.txt Pyrococcus_abyssi.fasta.8.m1.allwords.txt >Pyrococcus_horikoshii.fasta.8.m1.allwords_Pyrococcus_abyssi.fasta.8.m1.allwords.txt
