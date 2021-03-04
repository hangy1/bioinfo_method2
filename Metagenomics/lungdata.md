Lung Metagenomic Analysis
================

## GitHub Documents

This is an R Markdown format used for publishing markdown documents to
GitHub. When you click the **Knit** button all R code chunks are run and
a markdown file (.md) suitable for publishing to GitHub is generated.

## Including Code

You can include R code in the document as follows:

``` r
library(metagenomeSeq)
data(lungData)
lungData
```

    ## MRexperiment (storageMode: environment)
    ## assayData: 51891 features, 78 samples 
    ##   element names: counts 
    ## protocolData: none
    ## phenoData
    ##   sampleNames: CHK_6467_E3B11_BRONCH2_PREWASH_V1V2 CHK_6467_E3B11_OW_V1V2 ...
    ##     CHK_6467_E3B09_BAL_A_V1V2 (78 total)
    ##   varLabels: SampleType SiteSampled SmokingStatus
    ##   varMetadata: labelDescription
    ## featureData
    ##   featureNames: 1 2 ... 51891 (51891 total)
    ##   fvarLabels: taxa
    ##   fvarMetadata: labelDescription
    ## experimentData: use 'experimentData(object)'
    ## Annotation:

``` r
#Calculating normalization factors
p = cumNormStatFast(lungData)
lungData = cumNorm(lungData, p = p)
head(lungData)
```

    ## MRexperiment (storageMode: environment)
    ## assayData: 1 features, 78 samples 
    ##   element names: counts 
    ## protocolData: none
    ## phenoData
    ##   sampleNames: CHK_6467_E3B11_BRONCH2_PREWASH_V1V2 CHK_6467_E3B11_OW_V1V2 ...
    ##     CHK_6467_E3B09_BAL_A_V1V2 (78 total)
    ##   varLabels: SampleType SiteSampled SmokingStatus
    ##   varMetadata: labelDescription
    ## featureData
    ##   featureNames: 1
    ##   fvarLabels: taxa
    ##   fvarMetadata: labelDescription
    ## experimentData: use 'experimentData(object)'
    ## Annotation:

``` r
#fitFeatureModel for differential abundance testing
#comparing smoker’s and non-smokers lung microbiome.
data(lungData)
lungData = lungData[, -which(is.na(pData(lungData)$SmokingStatus))]
lungData = filterData(lungData, present = 30, depth = 1)
lungData <- cumNorm(lungData, p = 0.5)
pd <- pData(lungData)
mod <- model.matrix(~1 + SmokingStatus, data = pd)
lungres1 = fitFeatureModel(lungData, mod)
head(MRcoefs(lungres1))
```

    ##           logFC        se      pvalues   adjPvalues
    ## 3465  -4.824949 0.5697511 0.000000e+00 0.000000e+00
    ## 35827 -4.304266 0.5445548 2.664535e-15 1.079137e-13
    ## 2817   2.320656 0.4324661 8.045793e-08 1.629273e-06
    ## 2735   2.260203 0.4331098 1.803341e-07 2.921412e-06
    ## 5411   1.748296 0.3092461 1.572921e-08 4.246888e-07
    ## 48745 -1.645805 0.3293117 5.801451e-07 7.831959e-06

``` r
#differential abundance testing
#trimmed lung data
data(lungData)
controls = grep("Extraction.Control", pData(lungData)$SampleType)
lungTrim = lungData[, -controls]
rareFeatures = which(rowSums(MRcounts(lungTrim) > 0) < 10)
lungTrim = lungTrim[-rareFeatures, ]
lungp = cumNormStat(lungTrim, pFlag = TRUE, main = "Trimmed lung data")
```

    ## Default value being used.

![](lungData_files/figure-gfm/cars-1.png)<!-- -->

``` r
lungTrim = cumNorm(lungTrim, p = lungp)
smokingStatus = pData(lungTrim)$SmokingStatus
bodySite = pData(lungTrim)$SampleType
normFactor = normFactors(lungTrim)
normFactor = log2(normFactor/median(normFactor) + 1)
mod = model.matrix(~smokingStatus + bodySite + normFactor)
settings = zigControl(maxit = 10, verbose = TRUE)
fit = fitZig(obj = lungTrim, mod = mod, useCSSoffset = FALSE,
control = settings)
```

    ## it= 0, nll=88.42, log10(eps+1)=Inf, stillActive=1029
    ## it= 1, nll=93.56, log10(eps+1)=0.06, stillActive=261
    ## it= 2, nll=93.46, log10(eps+1)=0.05, stillActive=120
    ## it= 3, nll=93.80, log10(eps+1)=0.05, stillActive=22
    ## it= 4, nll=93.94, log10(eps+1)=0.03, stillActive=3
    ## it= 5, nll=93.93, log10(eps+1)=0.00, stillActive=1
    ## it= 6, nll=93.90, log10(eps+1)=0.00, stillActive=1
    ## it= 7, nll=93.87, log10(eps+1)=0.00, stillActive=1
    ## it= 8, nll=93.86, log10(eps+1)=0.00, stillActive=1
    ## it= 9, nll=93.85, log10(eps+1)=0.00, stillActive=1

``` r
#Multiple groups
# maxit=1 is for demonstration purposes
settings = zigControl(maxit = 1, verbose = FALSE)
mod = model.matrix(~bodySite)
colnames(mod) = levels(bodySite)
# fitting the ZIG model
res = fitZig(obj = lungTrim, mod = mod, control = settings)
# The output of fitZig contains a list of various useful
# items. hint: names(res). Probably the most useful is the
# limma 'MLArrayLM' object called fit.
zigFit = slot(res, "fit")
finalMod = slot(res, "fit")$design
contrast.matrix = makeContrasts(BAL.A - BAL.B, OW - PSB, levels = finalMod)
fit2 = contrasts.fit(zigFit, contrast.matrix)
fit2 = eBayes(fit2)
topTable(fit2)
```

    ##       BAL.A...BAL.B  OW...PSB   AveExpr         F      P.Value  adj.P.Val
    ## 18531    0.37318792  2.075648 0.7343081 12.715105 5.359780e-05 0.02813711
    ## 6291    -0.10695735  1.658829 0.4671470 12.956898 5.482439e-05 0.02813711
    ## 37977   -0.37995461  2.174071 0.4526060 12.528733 8.203239e-05 0.02813711
    ## 6901     0.17344138  1.466113 0.2435881 12.018652 1.335806e-04 0.03212047
    ## 40291    0.06892926  1.700238 0.2195735 11.803380 1.560761e-04 0.03212047
    ## 36117   -0.28665883  2.233996 0.4084024 10.571931 3.012092e-04 0.05013569
    ## 7343    -0.22859078  1.559465 0.3116465 10.090602 3.931844e-04 0.05013569
    ## 7342     0.59882970  1.902346 0.5334647  9.410984 4.901651e-04 0.05013569
    ## 1727     1.09837459 -2.160466 0.7780167  9.346013 5.027597e-04 0.05013569
    ## 40329   -0.07145998  1.481582 0.2475735  9.700136 5.259032e-04 0.05013569

``` r
#Exporting fits
taxa = sapply(strsplit(as.character(fData(lungTrim)$taxa), split = ";"),
              function(i) {
                i[length(i)]
              })
head(MRcoefs(fit, taxa = taxa, coef = 2))
```

    ##                                   smokingStatusSmoker      pvalues   adjPvalues
    ## Neisseria polysaccharea                     -4.031612 3.927097e-11 2.959194e-08
    ## Neisseria meningitidis                      -3.958899 5.751592e-11 2.959194e-08
    ## Prevotella intermedia                       -2.927686 4.339587e-09 8.930871e-07
    ## Porphyromonas sp. UQD 414                   -2.675306 1.788697e-07 1.357269e-05
    ## Prevotella paludivivens                      2.575672 1.360718e-07 1.272890e-05
    ## Leptotrichia sp. oral clone FP036            2.574172 3.544957e-04 1.414122e-03

``` r
#permutation based p-values permutation
coeffOfInterest = 2
res = fitLogNormal(obj = lungTrim, mod = mod, useCSSoffset = FALSE,
                   B = 10, coef = coeffOfInterest)
# extract p.values and adjust for multiple testing res$p 
adjustedPvalues = p.adjust(res$p, method = "fdr")
# extract the absolute fold-change estimates
foldChange = abs(res$fit$coef[, coeffOfInterest])
# determine features still significant and order by the
sigList = which(adjustedPvalues <= 0.05)
sigList = sigList[order(foldChange[sigList])]
head(taxa[sigList])
```

    ## [1] "Streptococcus dysgalactiae" "Prevotella genomosp. C2"    "Prevotella genomosp. P6"   
    ## [4] "Mogibacterium timidum"      "Peptostreptococcus sp. C27" "Prevotella pallens"

``` r
head(MRtable(fit, coef = 2, taxa = 1:length(fData(lungTrim)$taxa)))
```

    ##     +samples in group 0 +samples in group 1 counts in group 0 counts in group 1 smokingStatusSmoker
    ## 63                   24                   6              1538                11           -4.031612
    ## 779                  23                   7              1512                22           -3.958899
    ## 358                  24                   1               390                 1           -2.927686
    ## 499                  21                   2               326                 2           -2.675306
    ## 25                   15                  26               162              1893            2.575672
    ## 928                   2                  11                 4                91            2.574172
    ##          pvalues   adjPvalues
    ## 63  3.927097e-11 2.959194e-08
    ## 779 5.751592e-11 2.959194e-08
    ## 358 4.339587e-09 8.930871e-07
    ## 499 1.788697e-07 1.357269e-05
    ## 25  1.360718e-07 1.272890e-05
    ## 928 3.544957e-04 1.414122e-03

``` r
patients = sapply(strsplit(rownames(pData(lungTrim)), split = "_"),
function(i) {
i[3]
})
pData(lungTrim)$patients = patients
classIndex = list(smoker = which(pData(lungTrim)$SmokingStatus =="Smoker"))
classIndex$nonsmoker = which(pData(lungTrim)$SmokingStatus =="NonSmoker")
otu = 779

x = fData(lungTrim)$taxa[otu]
otulist = grep(x, fData(lungTrim)$taxa)
```

## Including Plots

``` r
#differential abundance testing
#trimmed lung data
data(lungData)
controls = grep("Extraction.Control", pData(lungData)$SampleType)
lungTrim = lungData[, -controls]
rareFeatures = which(rowSums(MRcounts(lungTrim) > 0) < 10)
lungTrim = lungTrim[-rareFeatures, ]
lungp = cumNormStat(lungTrim, pFlag = TRUE, main = "Trimmed lung data")
```

    ## Default value being used.

![](lungData_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

``` r
#plotOTU
plotOTU(lungTrim, otu = otu, classIndex, main = "Neisseria meningitidis")
```

![](lungData_files/figure-gfm/unnamed-chunk-1-2.png)<!-- -->

``` r
# plotGenus
plotGenus(lungTrim, otulist, classIndex, labs = FALSE, main = "Neisseria meningitidis")
lablist <- c("S", "NS")
axis(1, at = seq(1, 6, by = 1), labels = rep(lablist, times = 3))
```

![](lungData_files/figure-gfm/unnamed-chunk-1-3.png)<!-- -->

``` r
knitr::write_bib("metagenomeSeq", "bibliography.bib", width = 60)
```

## References

<div id="refs" class="references">

<div id="ref-R-metagenomeSeq">

Paulson, Joseph Nathaniel, Nathan D. Olson, Justin Wagner, Hisham
Talukder, Mihai Pop, and Hector Corrada Bravo. 2019. *MetagenomeSeq:
Statistical Analysis for Sparse High-Throughput Sequencing*.
<https://github.com/nosson/metagenomeSeq/>.

</div>

<div id="ref-metagenomeSeq2013b">

Paulson, Joseph N., Mihai Pop, and Hector Corrada Bravo. 2013.
*MetagenomeSeq: Statistical Analysis for Sparse High-Throughput
Sequncing.* <http://www.cbcb.umd.edu/software/metagenomeSeq>.

</div>

<div id="ref-metagenomeSeq2013a">

Paulson, Joseph N., Oscar Colin Stine, Hector Corrada Bravo, and Mihai
Pop. 2013. “Differential Abundance Analysis for Microbial Marker-Gene
Surveys.” *Nat Meth* advance online publication.
<https://doi.org/10.1038/nmeth.2658>.

</div>

<div id="ref-metagenomeSeq2014a">

Talukder\*, Hisham, Joseph N. Paulson\*, and Hector Corrada Bravo. 2014.
“Longitudinal Differential Abundance Analysis of Marker-Gene Surveys.”
*XX*.

</div>

</div>
