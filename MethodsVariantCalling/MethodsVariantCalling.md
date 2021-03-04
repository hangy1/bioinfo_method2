## Method

1.The reference genome GRCh38 was retrieved from link:
<ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_27/GRCh38.primary_assembly.genome.fa.gz>.
2.Ncbi fastq-dump tool was used to retrieve NGS reads of accession
SRR6808334. 3.To quality trim the reads, Trimmomatic(Bolger, Lohse, and
Usadel (2014)) was used to trim SRR6808334 left and right reads.
4.Burrows-Wheeler Alignment Tool(bwa)(Li and Durbin (2009)) was used to
index reference genome GRCh38. 5. bwa mem(McKenna et al. (2010)) was
used to align reference genome reads and SRR6808334 reads. 6.Samtools(Li
et al. (2009)) was applied to sort sam files that are created from bwa
mem and output as bam files, then Samtools was used again to index
sorted bam files. 7.Finally, DeepVariant method(Poplin et al. (2018))
was applied to create deep neural variants and then convert them from
Tensor flow format to VCF format.

## References

<div id="refs" class="references">

<div id="ref-Bolger">

Bolger, Anthony M., Marc Lohse, and Bjoern Usadel. 2014. “Trimmomatic: A
Flexible Trimmer for Illumina Sequence Data.” *Bioinformatics (Oxford,
England)* 30 (15). Oxford University Press: 2114–20.
<https://doi.org/10.1093/bioinformatics/btu170>.

</div>

<div id="ref-Li&amp;Durbin">

Li, Heng, and Richard Durbin. 2009. “Fast and Accurate Short Read
Alignment with Burrows–Wheeler Transform.” *Bioinformatics* 25 (14):
1754–60. <https://doi.org/10.1093/bioinformatics/btp324>.

</div>

<div id="ref-Li&amp;Handsaker">

Li, Heng, Bob Handsaker, Alec Wysoker, Tim Fennell, Jue Ruan, Nils
Homer, Gabor Marth, Goncalo Abecasis, Richard Durbin, and 1000 Genome
Project Data Processing Subgroup. 2009. “The Sequence Alignment/Map
Format and SAMtools.” *Bioinformatics (Oxford, England)* 25 (16). Oxford
University Press: 2078–9.
<https://doi.org/10.1093/bioinformatics/btp352>.

</div>

<div id="ref-Mckenna">

McKenna, Aaron, Matthew Hanna, Eric Banks, Andrey Sivachenko, Kristian
Cibulskis, Andrew Kernytsky, Kiran Garimella, et al. 2010. “The Genome
Analysis Toolkit: A MapReduce Framework for Analyzing Next-Generation
DNA Sequencing Data.” *Genome Research* 20 (9). Cold Spring Harbor
Laboratory Press: 1297–1303. <https://doi.org/10.1101/gr.107524.110>.

</div>

<div id="ref-Poplin">

Poplin, Ryan, Pi-Chuan Chang, David Alexander, Scott Schwartz, Thomas
Colthurst, Alexander Ku, Dan Newburger, et al. 2018. “A Universal SNP
and Small-Indel Variant Caller Using Deep Neural Networks.” *Nature
Biotechnology* 36 (10): 983–87. <https://doi.org/10.1038/nbt.4235>.

</div>

</div>
