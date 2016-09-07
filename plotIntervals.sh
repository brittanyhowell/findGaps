#!/bin/bash
# Generates intervals, then runs R script to generate the plots

# Working directories
WKDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ClusterFilter
SCRIPTDIR=${WKDIR}/findGaps/Scripts
SEQDIR=${WKDIR}/splitting/AlignedClusters/sequences
gapOUTDIR=${WKDIR}/findGaps/gapOutput/
gapOUT=${WKDIR}/findGaps/gapOutput/gaps*.fasta
gapGraphOUT=${WKDIR}/findGaps/pdf/

cd ${SCRIPTDIR}
cp otherFasta.go ${SEQDIR}

cd ${SEQDIR}

for sequence in  *.fasta ; do 

 	go run otherFasta.go -inSequence=${sequence} -outpath=$gapOUTDIR

done

rm otherFasta.go



for gapFile in ${gapOUT} ; do 

	filename=${gapFile%.fasta}

	cd ${SCRIPTDIR}
	Rscript coverageIntervals.R ${gapFile}  ${filename}.pdf
	# Args 1: input table
	# Args 3: output file
done


cd ${gapOUTDIR}

mv *.pdf ${gapGraphOUT}