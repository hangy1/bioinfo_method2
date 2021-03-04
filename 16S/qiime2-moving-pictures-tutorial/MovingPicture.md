## Title

Moving Picture Method

## Method

The moving picture tutorial uses QIIME2 to analyze human microbiome
samples(Kuczynski et al. (2011)) from published sample data (Caporaso et
al. (2011)). First step was demultiplexing sequence, then Deblur(Amir et
al. (2017)) method was used to perform quality control.Then visual
summaries was created by using qiime feature-table methods.The
summarized data was used to perform phylogenetic analysis, Alpha and
beta diversity analysis, Alpha rarefaction plotting, Taxonomic analysis,
and differential abundance testing with ANCOM(Mandal et al. (2015)).

## Sample data

``` r
library(knitr)
sample.metadata <- read.table(file = "sample_metadata.tsv", sep = '\t', header = TRUE)
kable(sample.metadata[1:10,])
```

| sample.id | barcode.sequence | body.site  | year | month | day | subject   | reported.antibiotic.usage | days.since.experiment.start |
| :-------- | :--------------- | :--------- | ---: | ----: | --: | :-------- | :------------------------ | --------------------------: |
| L1S8      | AGCTGACTAGTC     | gut        | 2008 |    10 |  28 | subject-1 | Yes                       |                           0 |
| L1S57     | ACACACTATGGC     | gut        | 2009 |     1 |  20 | subject-1 | No                        |                          84 |
| L1S76     | ACTACGTGTGGT     | gut        | 2009 |     2 |  17 | subject-1 | No                        |                         112 |
| L1S105    | AGTGCGATGCGT     | gut        | 2009 |     3 |  17 | subject-1 | No                        |                         140 |
| L2S155    | ACGATGCGACCA     | left palm  | 2009 |     1 |  20 | subject-1 | No                        |                          84 |
| L2S175    | AGCTATCCACGA     | left palm  | 2009 |     2 |  17 | subject-1 | No                        |                         112 |
| L2S204    | ATGCAGCTCAGT     | left palm  | 2009 |     3 |  17 | subject-1 | No                        |                         140 |
| L2S222    | CACGTGACATGT     | left palm  | 2009 |     4 |  14 | subject-1 | No                        |                         168 |
| L3S242    | ACAGTTGCGCGA     | right palm | 2008 |    10 |  28 | subject-1 | Yes                       |                           0 |
| L3S294    | CACGACAGGCTA     | right palm | 2009 |     1 |  20 | subject-1 | No                        |                          84 |

## References

<div id="refs" class="references">

<div id="ref-Amir">

Amir, Amnon, Daniel McDonald, Jose A. Navas-Molina, Evguenia Kopylova,
James T. Morton, Zhenjiang Zech Xu, Eric P. Kightley, et al. 2017.
“Deblur Rapidly Resolves Single-Nucleotide Community Sequence
Patterns.” *mSystems* 2 (2): e00191–16.
<https://doi.org/10.1128/mSystems.00191-16>.

</div>

<div id="ref-Caporaso">

Caporaso, J. Gregory, Christian L. Lauber, Elizabeth K. Costello, Donna
Berg-Lyons, Antonio Gonzalez, Jesse Stombaugh, Dan Knights, et al. 2011.
“Moving Pictures of the Human Microbiome.” *Genome Biology* 12 (5).
BioMed Central: R50–R50. <https://doi.org/10.1186/gb-2011-12-5-r50>.

</div>

<div id="ref-Kuczynski">

Kuczynski, Justin, Jesse Stombaugh, William Anton Walters, Antonio
González, J. Gregory Caporaso, and Rob Knight. 2011. “Using QIIME to
Analyze 16S rRNA Gene Sequences from Microbial Communities.” *Current
Protocols in Bioinformatics* Chapter 10 (December): Unit10.7–10.7.
<https://doi.org/10.1002/0471250953.bi1007s36>.

</div>

<div id="ref-Mandal">

Mandal, Siddhartha, Will Van Treuren, Richard A. White, Merete Eggesbø,
Rob Knight, and Shyamal D. Peddada. 2015. “Analysis of Composition of
Microbiomes: A Novel Method for Studying Microbial Composition.”
*Microbial Ecology in Health and Disease* 26 (May). Co-Action
Publishing: 27663–3. <https://doi.org/10.3402/mehd.v26.27663>.

</div>

</div>
