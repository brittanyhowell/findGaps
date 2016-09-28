#!/bin/bash
# Generates intervals, then runs R script to generate the plots

# Working directories
WKDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ClusterFilter
SCRIPTDIR=${WKDIR}/findGaps/Scripts

# SEQDIR=${WKDIR}/splitting/AlignedClusters/sequences/
SEQDIR=${WKDIR}/clusterOutput/AlignedClusters/sequences/1

gapOUTDIR=${WKDIR}/findGaps/gapOutput12nonsplit_reduced/
gapOUT=${WKDIR}/findGaps/gapOutput12nonsplit_reduced/gaps*.fasta
gapGraphOUTDIR=${WKDIR}/findGaps/pdf12nonSplit_reduced/

# # Check if the folder $Plots exists
# if [ -d $gapOUTDIR ]; then
# 	rm -r $gapOUTDIR 
# 	mkdir $gapOUTDIR
# 	echo "Gap folder exists... replacing" 
# else 
# 	echo "creating Plots folder" 
# 	mkdir $gapOUTDIR
# fi 

# # Check if gapGraphOUTDIR folder $Plots exists
# if [ -d $Plots ]; then
# 	rm -r $gapGraphOUTDIR 
# 	mkdir $gapGraphOUTDIR
# 	echo "Plots folder exists... replacing" 
# else 
# 	echo "creating Plots folder" 
# 	mkdir $gapGraphOUTDIR
# fi 


# cd ${SCRIPTDIR}
# cp otherFasta.go ${SEQDIR}

# cd ${SEQDIR}

# for sequence in  *.fasta ; do 

#  	go run otherFasta.go -inSequence=${sequence} -outpath=$gapOUTDIR

# done

# rm otherFasta.go



for gapFile in ${gapOUT} ; do 

	 filename=${gapFile%.fasta}
filenameTrunc=${filename##*/}

	cd ${SCRIPTDIR}
	Rscript coverageIntervals.R ${gapFile}  ${filename}_A.pdf ${filenameTrunc}_A
	# Args 1: input table
	# Args 2: output file
	# Args 3: title of plot
done


cd ${gapOUTDIR}

mv *.pdf ${gapGraphOUTDIR}