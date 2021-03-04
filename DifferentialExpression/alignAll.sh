#!/usr/bin/env bash

#set up path and out directory
pairedPath="/scratch/SampleDataFiles/Paired/"

outDir="quant/"
mkdir -p $outDir
#left and right read suffix
leftSuffix=".R1.paired.fastq"
rightSuffix=".R2.paired.fastq"

function align {
    for leftFile in $pairedPath*$leftSuffix
    do  
        pathRemoved="${leftFile/$pairedPath/}"
        #can echo $pathRemoved to check
        sampleName="${pathRemoved/$leftSuffix/}"
        echo $sampleName
        salmon quant -l IU \
            -1 $pairedPath$sampleName$leftSuffix \
            -2 $pairedPath$sampleName$rightSuffix \
            -i AipIndex \
            --validateMappings \
            -o $outDir$sampleName
    done
}
align 1>align.log 2>align.err &
