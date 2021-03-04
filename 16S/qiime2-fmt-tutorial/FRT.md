## Title

FMT study method

## Method

This tutorial is derived from Fecal microbiota transplant (FMT) study
(Kang et al. (2017)). First demux method was used to produce summarized
table, than DADA2(Callahan et al. (2016)) was used to perform quality
control on 1% sequenced sample data, with denoise-single method. Last
the sequences results and frequency results were merged. Further
diversity analysis can be applied to FeatureTable\[Frequency\] and
FeatureData\[Sequence\] objects.  
\#\# Sample data

``` r
library(knitr)
sample.metadata <- read.table(file = "sample_metadata.tsv", sep = '\t', header = TRUE)
kable(sample.metadata[1:10,])
```

| sample.id                            | sequencing.run | sample.type | treatment.group | subject.id | week | gsrs | gsrs.diff | administration.route |  age | gender | weight | height |  bmi |
| :----------------------------------- | :------------- | :---------- | :-------------- | :--------- | ---: | ---: | --------: | :------------------- | ---: | :----- | -----: | -----: | ---: |
| 595e93ed.e4b3.42b5.91b1.1ad4f31e7134 | run-1          | stool       | treatment       | B101       |    0 |  2.9 |       0.0 | Oral                 | 12.5 | m      |     63 |     55 | 14.8 |
| bd64992d.87cc.464f.9e1b.9c0156ed65d8 | run-1          | stool       | treatment       | B101       |    3 |  1.8 |     \-1.1 | Oral                 | 12.5 | m      |     63 |     55 | 14.8 |
| e7a2370c.f80c.4703.b2ee.10c65967e05f | run-1          | stool       | treatment       | B101       |   10 |  1.3 |     \-1.6 | Oral                 | 12.5 | m      |     63 |     55 | 14.8 |
| 11f3f37a.3698.4031.8183.75f6f2c6c04c | run-1          | stool       | treatment       | B101       |   18 |  1.3 |     \-1.6 | Oral                 | 12.5 | m      |     63 |     55 | 14.8 |
| fa2e9bcc.cc53.4b83.ad1e.a308375854f5 | run-1          | swab        | treatment       | B101       |    0 |  2.9 |       0.0 | Oral                 | 12.5 | m      |     63 |     55 | 14.8 |
| b1e40907.45fc.4d81.ad81.c58ed3d91e1f | run-1          | swab        | treatment       | B101       |    2 |  1.3 |     \-1.6 | Oral                 | 12.5 | m      |     63 |     55 | 14.8 |
| c784e063.e586.43cb.a602.9f2e2ae420d1 | run-1          | swab        | treatment       | B101       |    3 |  1.8 |     \-1.1 | Oral                 | 12.5 | m      |     63 |     55 | 14.8 |
| 104e5902.1c3e.417f.bb22.124bfca61a61 | run-1          | swab        | treatment       | B101       |    6 |  1.1 |     \-1.8 | Oral                 | 12.5 | m      |     63 |     55 | 14.8 |
| 7c66ff62.02e7.458d.a55d.8d07d15a9315 | run-1          | swab        | treatment       | B101       |    8 |  1.4 |     \-1.5 | Oral                 | 12.5 | m      |     63 |     55 | 14.8 |
| 0bb5e24a.aa34.48e7.b1f9.e761ac2dc6b4 | run-1          | swab        | treatment       | B101       |   10 |  1.3 |     \-1.6 | Oral                 | 12.5 | m      |     63 |     55 | 14.8 |

## References

<div id="refs" class="references">

<div id="ref-Callahan">

Callahan, Benjamin J., Paul J. McMurdie, Michael J. Rosen, Andrew W.
Han, Amy Jo A. Johnson, and Susan P. Holmes. 2016. “DADA2:
High-Resolution Sample Inference from Illumina Amplicon Data.” *Nature
Methods* 13 (7): 581–83. <https://doi.org/10.1038/nmeth.3869>.

</div>

<div id="ref-Kang">

Kang, Dae-Wook, James B. Adams, Ann C. Gregory, Thomas Borody, Lauren
Chittick, Alessio Fasano, Alexander Khoruts, et al. 2017. “Microbiota
Transfer Therapy Alters Gut Ecosystem and Improves Gastrointestinal and
Autism Symptoms: An Open-Label Study.” *Microbiome* 5 (1): 10.
<https://doi.org/10.1186/s40168-016-0225-7>.

</div>

</div>
