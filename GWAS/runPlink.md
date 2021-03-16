Title: Example of running Plink
-------------------------------

Author: Hang Yin
----------------

Method
------

Second-Generation Plink(Chang et al. 2015) is used to analyze the whole
genome association.In this module, data of randomly selected genotypes
(approximately 80,000 autosomal SNPs) from the 89 Asian HapMap
individuals were analyzed by Plink. The analysis includes summary
statistics of missing rates and allele frequencies, basic association
analysis, genotypic association models, stratification analysis,
clusters association analysis, quantitative trail association analysis
and extracting a SNP of interest

Result
------

Summary statistics: missing rates
=================================

    #individual missingness information
    head miss_stat.lmiss
    #locus missingness information
    head miss_stat.imiss

    ##  CHR         SNP   N_MISS   N_GENO   F_MISS
    ##    1   rs6681049        0       89        0
    ##    1   rs4074137        0       89        0
    ##    1   rs7540009        0       89        0
    ##    1   rs1891905        0       89        0
    ##    1   rs9729550        0       89        0
    ##    1   rs3813196        0       89        0
    ##    1   rs6704013        2       89  0.02247
    ##    1    rs307347       12       89   0.1348
    ##    1   rs9439440        2       89  0.02247
    ##      FID  IID MISS_PHENO   N_MISS   N_GENO   F_MISS
    ##   HCB181    1          N      671    83534 0.008033
    ##   HCB182    1          N     1156    83534  0.01384
    ##   HCB183    1          N      498    83534 0.005962
    ##   HCB184    1          N      412    83534 0.004932
    ##   HCB185    1          N      329    83534 0.003939
    ##   HCB186    1          N     1233    83534  0.01476
    ##   HCB187    1          N      258    83534 0.003089
    ##   HCB188    1          N      864    83534  0.01034
    ##   HCB189    1          N      517    83534 0.006189

Allele frequencies smilarirty analysis
======================================

    head freq_stat.frq
    #stratified analysis
    head freq_stat.frq.strat

    ##  CHR         SNP   A1   A2          MAF  NCHROBS
    ##    1   rs6681049    1    2       0.2135      178
    ##    1   rs4074137    1    2      0.07865      178
    ##    1   rs7540009    0    2            0      178
    ##    1   rs1891905    1    2       0.4045      178
    ##    1   rs9729550    1    2       0.1292      178
    ##    1   rs3813196    1    2      0.02809      178
    ##    1   rs6704013    0    2            0      174
    ##    1    rs307347    0    2            0      154
    ##    1   rs9439440    0    2            0      174
    ##  CHR         SNP     CLST   A1   A2      MAF    MAC  NCHROBS
    ##    1   rs6681049        1    1    2   0.2333     21       90 
    ##    1   rs6681049        2    1    2   0.1932     17       88 
    ##    1   rs4074137        1    1    2      0.1      9       90 
    ##    1   rs4074137        2    1    2  0.05682      5       88 
    ##    1   rs7540009        1    0    2        0      0       90 
    ##    1   rs7540009        2    0    2        0      0       88 
    ##    1   rs1891905        1    1    2   0.4111     37       90 
    ##    1   rs1891905        2    1    2   0.3977     35       88 
    ##    1   rs9729550        1    1    2   0.1444     13       90

Basic association analysis
==========================

    #association analysis on the disease trait for all single SNPs
    sort --key=8 -nr as1.assoc | head
    #association analysis with FDR adjusted
    head as2.assoc.adjusted

    ##   13   rs9585021      64274    1    0.625   0.2841    2        20.62    5.586e-06          4.2 
    ##    2   rs2222162      10602    1   0.2841   0.6222    2        20.51    5.918e-06       0.2409 
    ##    9  rs10810856      46335    1   0.2955  0.04444    2        20.01    7.723e-06        9.016 
    ##    2   rs4675607      13220    1   0.1628   0.4778    2        19.93     8.05e-06       0.2125 
    ##    2   rs4673349      13218    1   0.1818      0.5    2        19.83    8.485e-06       0.2222 
    ##    2   rs1375352      13219    1   0.1818      0.5    2        19.83    8.485e-06       0.2222 
    ##   21    rs219746      81525    1      0.5   0.1889    2        19.12    1.228e-05        4.294 
    ##    1   rs4078404       6200    2      0.5      0.2    1        17.64    2.667e-05            4 
    ##   14   rs1152431      66892    2   0.2727   0.5795    1        16.94    3.862e-05       0.2721 
    ##   14   rs4899962      66836    2   0.3023   0.6111    1        16.88    3.983e-05       0.2758 
    ##  CHR         SNP      UNADJ         GC       BONF       HOLM   SIDAK_SS   SIDAK_SD     FDR_BH     FDR_BY
    ##   13   rs9585021  5.586e-06  4.994e-05     0.3839     0.3839     0.3188     0.3188    0.09719          1 
    ##    2   rs2222162  5.918e-06  5.232e-05     0.4068     0.4067     0.3342     0.3342    0.09719          1 
    ##    9  rs10810856  7.723e-06  6.483e-05     0.5308     0.5308     0.4118     0.4118    0.09719          1 
    ##    2   rs4675607   8.05e-06  6.703e-05     0.5533     0.5533     0.4249     0.4249    0.09719          1 
    ##    2   rs1375352  8.485e-06  6.994e-05     0.5832     0.5831     0.4419     0.4419    0.09719          1 
    ##    2   rs4673349  8.485e-06  6.994e-05     0.5832     0.5831     0.4419     0.4419    0.09719          1 
    ##   21    rs219746  1.228e-05  9.422e-05     0.8442     0.8441     0.5701     0.5701     0.1206          1 
    ##    1   rs4078404  2.667e-05   0.000176          1          1     0.8401       0.84     0.2291          1 
    ##   14   rs1152431  3.862e-05  0.0002374          1          1     0.9297     0.9297     0.2737          1

Genotypic and other association models
======================================

    #calculate association statistic for  run it for rs2222162
    head mod2.model

    ##  CHR         SNP   A1   A2     TEST            AFF          UNAFF        CHISQ   DF            P
    ##    2   rs2222162    1    2     GENO        3/19/22        17/22/6        19.15    2    6.932e-05
    ##    2   rs2222162    1    2    TREND          25/63          56/34        19.15    1    1.207e-05
    ##    2   rs2222162    1    2  ALLELIC          25/63          56/34        20.51    1    5.918e-06
    ##    2   rs2222162    1    2      DOM          22/22           39/6        13.87    1    0.0001958
    ##    2   rs2222162    1    2      REC           3/41          17/28        12.24    1    0.0004679

Stratification analysis
=======================

    head str1.cluster1

    ## SOL-0     HCB181_1 JPT260_1
    ## SOL-1     HCB182_1 HCB225_1
    ## SOL-2     HCB183_1 HCB194_1
    ## SOL-3     HCB184_1 HCB202_1
    ## SOL-4     HCB185_1 HCB217_1
    ## SOL-5     HCB186_1 HCB201_1
    ## SOL-6     HCB187_1 HCB189_1
    ## SOL-7     HCB188_1 HCB206_1
    ## SOL-8     HCB190_1 HCB224_1
    ## SOL-9     HCB191_1 HCB220_1

Association analysis, accounting for clusters
=============================================

    head aac1.cmh.adjusted
    head aac2.cmh.adjusted
    head aac3.cmh.adjusted

    ##  CHR         SNP      UNADJ         GC       BONF       HOLM   SIDAK_SS   SIDAK_SD     FDR_BH     FDR_BY
    ##   13   rs9585021  1.906e-06  4.418e-06     0.1274     0.1274     0.1196     0.1196     0.1274          1 
    ##   21   rs3017432  2.209e-05  4.332e-05          1          1     0.7716     0.7716     0.7384          1 
    ##    2   rs2222162  4.468e-05  8.353e-05          1          1     0.9496     0.9495     0.8734          1 
    ##   17   rs3829612  7.177e-05  0.0001299          1          1     0.9918     0.9918     0.8734          1 
    ##    2   rs1375352  9.617e-05  0.0001707          1          1     0.9984     0.9984     0.8734          1 
    ##    2   rs4673349  9.617e-05  0.0001707          1          1     0.9984     0.9984     0.8734          1 
    ##   15   rs4887466  0.0001215  0.0002123          1          1     0.9997     0.9997     0.8734          1 
    ##   12  rs12823722    0.00026  0.0004317          1          1          1          1     0.8734          1 
    ##    9   rs2025330    0.00026  0.0004317          1          1          1          1     0.8734          1 
    ##  CHR         SNP      UNADJ         GC       BONF       HOLM   SIDAK_SS   SIDAK_SD     FDR_BH     FDR_BY
    ##    2   rs2222162  1.474e-08  2.276e-08   0.001013   0.001013   0.001013   0.001013   0.001013    0.01187 
    ##    2   rs4675607  1.134e-05  1.479e-05     0.7794     0.7794     0.5413     0.5413     0.2779          1 
    ##   13   rs9585021  1.213e-05   1.58e-05     0.8338     0.8338     0.5656     0.5656     0.2779          1 
    ##    9   rs7046471  3.372e-05  4.278e-05          1          1     0.9015     0.9015     0.4296          1 
    ##    2   rs4673349   3.75e-05  4.746e-05          1          1      0.924      0.924     0.4296          1 
    ##    2   rs1375352   3.75e-05  4.746e-05          1          1      0.924      0.924     0.4296          1 
    ##    4   rs6823804   4.49e-05  5.657e-05          1          1     0.9543     0.9543     0.4408          1 
    ##    6  rs13217899  9.432e-05  0.0001166          1          1     0.9985     0.9985     0.6869          1 
    ##    6   rs9488062  0.0001003  0.0001238          1          1      0.999      0.999     0.6869          1 
    ##  CHR         SNP      UNADJ         GC       BONF       HOLM   SIDAK_SS   SIDAK_SD     FDR_BH     FDR_BY
    ##    2   rs2222162  2.594e-10  2.594e-10  1.783e-05  1.783e-05  1.783e-05  1.783e-05  1.783e-05  0.0002089 
    ##    2   rs4675607   4.03e-06   4.03e-06      0.277      0.277     0.2419     0.2419     0.1385          1 
    ##    2   rs1375352  1.204e-05  1.204e-05     0.8276     0.8276     0.5629     0.5629     0.1679          1 
    ##    2   rs4673349  1.204e-05  1.204e-05     0.8276     0.8276     0.5629     0.5629     0.1679          1 
    ##   13   rs9585021  1.222e-05  1.222e-05     0.8395     0.8395     0.5681     0.5681     0.1679          1 
    ##    2   rs2176427  4.309e-05  4.309e-05          1          1     0.9483     0.9483     0.4936          1 
    ##    9   rs7046471  6.926e-05  6.926e-05          1          1     0.9914     0.9914       0.68          1 
    ##    6   rs9488062  0.0001084  0.0001084          1          1     0.9994     0.9994     0.8566          1 
    ##    9   rs2900556  0.0001122  0.0001122          1          1     0.9996     0.9996     0.8566          1

Quantitative trait association analysis
---------------------------------------

    head quant1.qassoc.adjusted 
    #with permutation test
    head quant2.qassoc.adjusted

    ##  CHR         SNP      UNADJ         GC       BONF       HOLM   SIDAK_SS   SIDAK_SD     FDR_BH     FDR_BY
    ##    2   rs2222162  5.273e-09  6.224e-08  0.0003624  0.0003624  0.0003623  0.0003623  0.0003624   0.004245 
    ##   21    rs219746  1.095e-06  6.815e-06    0.07529    0.07529    0.07252    0.07252    0.03764      0.441 
    ##    7   rs1922519   1.63e-05  7.167e-05          1          1     0.6739     0.6739     0.2527          1 
    ##    2   rs2969348  2.886e-05  0.0001176          1          1     0.8624     0.8624     0.2527          1 
    ##    3   rs6773558  3.581e-05  0.0001419          1          1     0.9146     0.9146     0.2527          1 
    ##   10   rs3862003  3.716e-05  0.0001465          1          1     0.9222     0.9222     0.2527          1 
    ##    8    rs660416  4.114e-05    0.00016          1          1     0.9408     0.9408     0.2527          1 
    ##   14   rs2526935  4.236e-05  0.0001641          1          1     0.9456     0.9456     0.2527          1 
    ##    6   rs7774115  4.588e-05  0.0001759          1          1     0.9573     0.9573     0.2527          1 
    ##  CHR         SNP      UNADJ         GC       BONF       HOLM   SIDAK_SS   SIDAK_SD     FDR_BH     FDR_BY
    ##    2   rs2222162  5.273e-09  6.224e-08  0.0003624  0.0003624  0.0003623  0.0003623  0.0003624   0.004245 
    ##   21    rs219746  1.095e-06  6.815e-06    0.07529    0.07529    0.07252    0.07252    0.03764      0.441 
    ##    7   rs1922519   1.63e-05  7.167e-05          1          1     0.6739     0.6739     0.2527          1 
    ##    2   rs2969348  2.886e-05  0.0001176          1          1     0.8624     0.8624     0.2527          1 
    ##    3   rs6773558  3.581e-05  0.0001419          1          1     0.9146     0.9146     0.2527          1 
    ##   10   rs3862003  3.716e-05  0.0001465          1          1     0.9222     0.9222     0.2527          1 
    ##    8    rs660416  4.114e-05    0.00016          1          1     0.9408     0.9408     0.2527          1 
    ##   14   rs2526935  4.236e-05  0.0001641          1          1     0.9456     0.9456     0.2527          1 
    ##    6   rs7774115  4.588e-05  0.0001759          1          1     0.9573     0.9573     0.2527          1

Extracting a SNP of interest (rs2222162)
----------------------------------------

    d <- read.table("rec_snp1.raw" , header=T)
    summary(glm(PHENOTYPE-1 ~ rs2222162_1, data=d, family="binomial"))

    ## 
    ## Call:
    ## glm(formula = PHENOTYPE - 1 ~ rs2222162_1, family = "binomial", 
    ##     data = d)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -1.7690  -1.1042  -0.5848   0.6851   1.9238  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)   1.3300     0.4107   3.238   0.0012 ** 
    ## rs2222162_1  -1.5047     0.3765  -3.997 6.42e-05 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 123.37  on 88  degrees of freedom
    ## Residual deviance: 102.64  on 87  degrees of freedom
    ## AIC: 106.64
    ## 
    ## Number of Fisher Scoring iterations: 4

Visualization of clusters based on pairwsie IBS distances
=========================================================

![](Figs/unnamed-chunk-10-1.png)

References
----------

Chang, Christopher C., Carson C. Chow, Laurent CAM Tellier, Shashaank
Vattikuti, Shaun M. Purcell, and James J. Lee. 2015. “Second-Generation
PLINK: Rising to the Challenge of Larger and Richer Datasets.”
*GigaScience* 4 (1). <https://doi.org/10.1186/s13742-015-0047-8>.
