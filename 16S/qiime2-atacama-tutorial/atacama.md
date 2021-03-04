## Title

Atacama soil microbiome Method

## Method

The purpose of this tutorial was to perform an analysis of soil
microbiomes samples from the Atacama Desert in northern Chile(Neilson et
al. (2017)).1% subsample data was used for this tutorial. First of all
sequence reads was demuptiplexed, and than DADA2(Callahan et al. (2016))
was used to perform quality control.

## Sample data

``` r
library(knitr)
sample.metadata <- read.table(file = "sample_metadata.tsv", sep = '\t', header = TRUE)
kable(sample.metadata[1:10,])
```

| sample.id   | barcode.sequence | elevation | extract.concen | amplicon.concentration | extract.group.no | transect.name | site.name | depth |   ph | toc |    ec | average.soil.relative.humidity | relative.humidity.soil.high | relative.humidity.soil.low | percent.relative.humidity.soil.100 | average.soil.temperature | temperature.soil.high | temperature.soil.low | vegetation | percentcover |
| :---------- | :--------------- | --------: | -------------: | ---------------------: | :--------------- | :------------ | :-------- | ----: | ---: | --: | ----: | -----------------------------: | --------------------------: | -------------------------: | ---------------------------------: | -----------------------: | --------------------: | -------------------: | :--------- | -----------: |
| BAQ1370.1.2 | GCCCAAGTTCAC     |      1370 |          0.019 |                   0.95 | B                | Baquedano     | BAQ1370   |     2 | 7.98 | 525 | 6.080 |                          16.17 |                       23.97 |                     11.420 |                               0.00 |                    22.61 |                35.210 |               12.460 | no         |            0 |
| BAQ1370.3   | GCGCCGAATCTT     |      1370 |          0.124 |                  17.46 | E                | Baquedano     | BAQ1370   |     2 |   NA | 771 | 6.080 |                          16.17 |                       23.97 |                     11.420 |                               0.00 |                    22.61 |                35.210 |               12.460 | no         |            0 |
| BAQ1370.1.3 | ATAAAGAGGAGG     |      1370 |          1.200 |                   0.96 | J                | Baquedano     | BAQ1370   |     3 | 8.13 |  NA |    NA |                          16.17 |                       23.97 |                     11.420 |                               0.00 |                    22.61 |                35.210 |               12.460 | no         |            0 |
| BAQ1552.1.1 | ATCCCAGCATGC     |      1552 |          0.722 |                  18.83 | J                | Baquedano     | BAQ1552   |     1 | 7.87 |  NA |    NA |                          15.75 |                       35.36 |                     11.100 |                               0.00 |                    22.63 |                30.650 |               10.960 | no         |            0 |
| BAQ1552.2   | GCTTCCAGACAA     |      1552 |          0.017 |                   2.00 | B                | Baquedano     | BAQ1552   |     2 |   NA | 223 | 1.839 |                          15.75 |                       35.36 |                     11.100 |                               0.00 |                    22.63 |                30.650 |               10.960 | no         |            0 |
| BAQ2420.1.1 | ACACAGTCCTGA     |      2420 |          0.350 |                   7.40 | H                | Baquedano     | BAQ2420   |     1 | 9.33 |  NA |    NA |                          82.54 |                      100.00 |                     41.135 |                              46.77 |                    22.45 |                28.297 |               13.294 | no         |            0 |
| BAQ2420.1.2 | ATTATACGGCGC     |      2420 |          0.108 |                  11.42 | H                | Baquedano     | BAQ2420   |     2 | 9.36 | 166 | 0.075 |                          82.54 |                      100.00 |                     41.135 |                              46.77 |                    22.45 |                28.297 |               13.294 | no         |            0 |
| BAQ2420.2   | TAAACGCGACTC     |      2420 |          0.089 |                  10.06 | A                | Baquedano     | BAQ2420   |     2 | 9.36 | 337 | 0.075 |                          82.54 |                      100.00 |                     41.135 |                              46.77 |                    22.45 |                28.297 |               13.294 | no         |            0 |
| BAQ2420.3   | CCTCGGGTACTA     |      2420 |          0.083 |                  15.92 | C                | Baquedano     | BAQ2420   |     2 | 9.36 | 574 | 0.075 |                          82.54 |                      100.00 |                     41.135 |                              46.77 |                    22.45 |                28.297 |               13.294 | no         |            0 |
| BAQ2420.1.3 | ATTCAGATGGCA     |      2420 |          0.132 |                  10.00 | H                | Baquedano     | BAQ2420   |     3 | 8.90 |  NA |    NA |                          82.54 |                      100.00 |                     41.135 |                              46.77 |                    22.45 |                28.297 |               13.294 | no         |            0 |

## References

<div id="refs" class="references">

<div id="ref-Callahan">

Callahan, Benjamin J., Paul J. McMurdie, Michael J. Rosen, Andrew W.
Han, Amy Jo A. Johnson, and Susan P. Holmes. 2016. “DADA2:
High-Resolution Sample Inference from Illumina Amplicon Data.” *Nature
Methods* 13 (7): 581–83. <https://doi.org/10.1038/nmeth.3869>.

</div>

<div id="ref-Neilson">

Neilson, Julia W., Katy Califf, Cesar Cardona, Audrey Copeland, Will van
Treuren, Karen L. Josephson, Rob Knight, et al. 2017. “Significant
Impacts of Increasing Aridity on the Arid Soil Microbiome.” *mSystems* 2
(3). American Society for Microbiology: e00195–16.
<https://doi.org/10.1128/mSystems.00195-16>.

</div>

</div>
