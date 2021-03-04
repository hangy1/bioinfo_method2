if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("metagenomeSeq")
library(metagenomeSeq)

#load in BIOM file format data
BiocManager::install("biomformat")
library(biomformat)
biom_file <- system.file("extdata", "min_sparse_otu_table.biom",
                         package = "biomformat")
b <- read_biom(biom_file)
biom2MRexperiment(b)

#write a MRexperiment object out as a BIOM fileh
data(mouseData)
m <- MRexperiment2biom(mouseData)
write_biom(m, biom_file = "./otu_table.biom")

dataDirectory <- system.file("extdata", package = "metagenomeSeq")
#CHK_NAME.otus.count.csv CHK_otus.taxonomy.csv   tmp.tsv
#CHK_clinical.csv        lungfit.rds
lung = loadMeta(file.path(dataDirectory, "CHK_NAME.otus.count.csv"))
dim(lung$counts)

#Loading taxonomy
taxa = read.delim(file.path(dataDirectory, "CHK_otus.taxonomy.csv"),
                  stringsAsFactors = FALSE)
ord = match(colnames(lung$counts), rownames(clin))
clin = clin[ord, ]
head(clin[1:2, ])

#Creating a MRexperiment object
phenotypeData = AnnotatedDataFrame(clin)
OTUdata = AnnotatedDataFrame(taxa)
obj = newMRexperiment(lung$counts,phenoData=phenotypeData,featureData=OTUdata)

#Human lung microbiome
data(lungData)
#Humanized gnotobiotic mouse gut
data(mouseData)

#Useful command
#Phenotype information can be accessed with the phenoData and pData methods
phenoData(obj)
head(pData(obj),3)
#Feature information can be accessed with the featureData and fData methods
featureData(obj)
head(fData(obj)[, -c(2, 10)], 3)
#The raw or normalized counts matrix can be accessed with the MRcounts function
head(MRcounts(obj[, 1:2]))
#MRexperiment-class object can be easily subsetted
featuresToKeep = which(rowSums(obj) >= 100)
samplesToKeep = which(pData(obj)$SmokingStatus == "Smoker")
obj_smokers = obj[featuresToKeep, samplesToKeep]
head(pData(obj_smokers), 3)
#Alternative normalization scaling factors
head(normFactors(obj))
normFactors(obj) <- rnorm(ncol(obj))
head(normFactors(obj))
#Library sizes (sequencing depths) can be accessed or replaced with the libSize method
head(libSize(obj))
libSize(obj) <- rnorm(ncol(obj))
head(libSize(obj))
# data can be filtered to maintain a threshold of minimum depth or OTU presence
data(mouseData)
filterData(mouseData, present = 10, depth = 1000)
#Two MRexperiment-class objects can be merged with the mergeMRexperiments function
newobj = mergeMRexperiments(mouseData, mouseData)

#Normalization
# Calculating normalization factors
p = cumNormStatFast(lungData)
#calculate the scaling factors we simply run cumNorm
lungData = cumNorm(lungData, p = p)
#Calculating normalization factors using Wrench
condition = mouseData$diet
mouseData = wrenchNorm(mouseData, condition = condition)
#Exporting data
mat = MRcounts(lungData, norm = TRUE, log = TRUE)[1:5, 1:5]
exportMat(mat, file = file.path(dataDirectory, "tmp.tsv"))


#Statistic Testing
#comparing smoker’s and non-smokers lung microbiome.
data(lungData)
lungData = lungData[, -which(is.na(pData(lungData)$SmokingStatus))]
lungData = filterData(lungData, present = 30, depth = 1)
lungData <- cumNorm(lungData, p = 0.5)
pd <- pData(lungData)
mod <- model.matrix(~1 + SmokingStatus, data = pd) #1 is interceipt 
lungres1 = fitFeatureModel(lungData, mod)
head(MRcoefs(lungres1))

#Zero-inflated Gaussian mixture model
#Example using fitZig for differential abundance testing
data("lungData")
#remove features that are not present in many samples, controls, and calculate the normalization factors
controls = grep("Extraction.Control", pData(lungData)$SampleType)
lungTrim = lungData[, -controls]
rareFeatures = which(rowSums(MRcounts(lungTrim) > 0) < 10)
lungTrim = lungTrim[-rareFeatures, ]
lungp = cumNormStat(lungTrim, pFlag = TRUE, main = "Trimmed lung data")
lungTrim = cumNorm(lungTrim, p = lungp)
#optional inputs to fitZig, including settings determined by zigControl
smokingStatus = pData(lungTrim)$SmokingStatus
bodySite = pData(lungTrim)$SampleType
normFactor = normFactors(lungTrim)
normFactor = log2(normFactor/median(normFactor) + 1)
mod = model.matrix(~smokingStatus + bodySite + normFactor)
settings = zigControl(maxit = 10, verbose = TRUE)
fit = fitZig(obj = lungTrim, mod = mod, useCSSoffset = FALSE,
             control = settings)
#Multiple groups
#Limma’s topTable functions for F-tests and contrast functions to compare 
#multiple groups and covariates of interest
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
#Exporting fits
taxa = sapply(strsplit(as.character(fData(lungTrim)$taxa), split = ";"),
              function(i) {
                i[length(i)]
              })
head(MRcoefs(fit, taxa = taxa, coef = 2))

#Log Normal permutation test
#permutation based p-values permutation
coeffOfInterest = 2
res = fitLogNormal(obj = lungTrim, mod = mod, useCSSoffset = FALSE,
                   B = 10, coef = coeffOfInterest)
# extract p.values and adjust for multiple testing res$p are
# the p-values calculated through permutation
res$p
adjustedPvalues = p.adjust(res$p, method = "fdr")
# extract the absolute fold-change estimates
foldChange = abs(res$fit$coef[, coeffOfInterest])
# determine features still significant and order by the
sigList = which(adjustedPvalues <= 0.05)
sigList = sigList[order(foldChange[sigList])]
# view the top taxa associated with the coefficient of
# interest.
head(taxa[sigList])

#Presence-absence testing
#fitPA calculates the presence-absence for each organism 
#and returns a table of pvalues, odd’s ratios, and confidence intervals
classes = pData(mouseData)$diet
res = fitPA(mouseData[1:5, ], cl = classes)
# Warning - the p-value is calculating 1 despite a high odd's
# ratio.

#Discovery odds ratio testing
# Fisher’s exact test to create a 2x2 contingency 
#table and calculate p-values, odd’s ratios, and confidence intervals
classes = pData(mouseData)$diet
res = fitDO(mouseData[1:100, ], cl = classes, norm = FALSE, log = FALSE)
head(res)

#Feature correlations
cors = correlationTest(mouseData[55:60, ], norm = FALSE, log = FALSE)
head(cors)
#Unique OTUs or features
cl = pData(mouseData)[["diet"]]
uniqueFeatures(mouseData, cl, nsamples = 10, nreads = 100)

#Aggregating counts
#functions are in place to aggregate the count matrix (normalized or not)
obj = aggTax(mouseData, lvl = "phylum", out = "matrix")
head(obj[1:5, 1:5])
#aggregating samples
obj = aggSamp(mouseData, fct = "mouseID", out = "matrix")
head(obj[1:5, 1:5])

#Visualization of features
#plotMRheatmap, plotCorr, plotOrd, plotRare, plotBubble
#particular features such as the abundance for a single feature: 
#plotOTU, plotFeature, plotGenus

# Interactive Display
#Structural overview
#heatmap
trials = pData(mouseData)$diet
heatmapColColors = brewer.pal(12, "Set3")[as.integer(factor(trials))]
heatmapCols = colorRampPalette(brewer.pal(9, "RdBu"))(50)
# plotMRheatmap
plotMRheatmap(obj = mouseData, n = 200, cexRow = 0.4, cexCol = 0.4,
              trace = "none", col = heatmapCols, ColSideColors = heatmapColColors)
plotCorr(obj = mouseData, n = 200, cexRow = 0.25, cexCol = 0.25,
         trace = "none", dendrogram = "none", col = heatmapCols)
#plotting CMDS plots of the data and the rarefaction effect at theOTU level.
cl = factor(pData(mouseData)$diet)
# plotOrd - can load vegan and set distfun = vegdist and use
# dist.method='bray'
plotOrd(mouseData, tran = TRUE, usePCA = FALSE, useDist = TRUE,
        bg = cl, pch = 21)
# plotRare
res = plotRare(mouseData, cl = cl, pch = 21, bg = cl)
# Linear fits for plotRare / legend
tmp = lapply(levels(cl), function(lv) lm(res[, "ident"] ~res[,
"libSize"] - 1, subset = cl == lv))
for (i in 1:length(levels(cl))) {
  abline(tmp[[i]], col = i)
}
legend("topleft", c("Diet 1", "Diet 2"), text.col = c(1, 2),
       box.col = NA)

head(MRtable(fit, coef = 2, taxa = 1:length(fData(lungTrim)$taxa)))
patients = sapply(strsplit(rownames(pData(lungTrim)), split = "_"),
                  function(i) {
                    i[3]
                  })
pData(lungTrim)$patients = patients
classIndex = list(smoker = which(pData(lungTrim)$SmokingStatus =="Smoker"))
classIndex$nonsmoker = which(pData(lungTrim)$SmokingStatus =="NonSmoker")
otu = 779
# plotOTU
plotOTU(lungTrim, otu = otu, classIndex, main = "Neisseria meningitidis")
#multiple OTUs annotated similarly
x = fData(lungTrim)$taxa[otu]
otulist = grep(x, fData(lungTrim)$taxa)
plotGenus(lungTrim, otulist, classIndex, labs = FALSE, main = "Neisseria meningitidis")
lablist <- c("S", "NS")
axis(1, at = seq(1, 6, by = 1), labels = rep(lablist, times = 3))
#plotFeature
classIndex = list(Western = which(pData(mouseData)$diet == "Western"))
classIndex$BK = which(pData(mouseData)$diet == "BK")
otuIndex = 8770
# par(mfrow=c(1,2))
dates = pData(mouseData)$date
plotFeature(mouseData, norm = FALSE, log = FALSE, otuIndex, classIndex,
            col = dates, sortby = dates, ylab = "Raw reads")
citation("metagenomeSeq")
