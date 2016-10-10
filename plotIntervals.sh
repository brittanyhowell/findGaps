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

# Part 1: Check on the existence of folders
	# Check if the folder $Plots exists
	if [ -d $gapOUTDIR ]; then
		rm -r $gapOUTDIR 
		mkdir $gapOUTDIR
		echo "Gap folder exists... replacing" 
	else 
		echo "creating Plots folder" 
		mkdir $gapOUTDIR
	fi 

	# Check if gapGraphOUTDIR folder $Plots exists
	if [ -d $Plots ]; then
		rm -r $gapGraphOUTDIR 
		mkdir $gapGraphOUTDIR
		echo "Plots folder exists... replacing" 
	else 
		echo "creating Plots folder" 
		mkdir $gapGraphOUTDIR
	fi 


# Part 2: Find the gaps with findGaps.go
	# Copy the script in so it knows what to do.
	cd ${SCRIPTDIR}
	cp findGaps.go ${SEQDIR}

	# Go to where the clusters are and detect the gaps
	cd ${SEQDIR}
	for sequence in  *.fasta ; do 
	 	go run findGaps.go -inSequence=${sequence} -outpath=$gapOUTDIR
	done

	# delete redundant copy of code
	rm findGaps.go


# Part 3: Plot the gaps with coverageIntervals.R
	for gapFile in ${gapOUT} ; do 

		filename=${gapFile%.fasta}
		# Delete the upstream file path
		filenameTrunc=${filename##*/}

		cd ${SCRIPTDIR}
		Rscript coverageIntervals.R ${gapFile}  ${filename}.pdf ${filenameTrunc}
		# Args 1: input table
		# Args 2: output file
		# Args 3: title of plot
	done

# Part 4: Move the output PDFs into their own folder
	cd ${gapOUTDIR}
	mv *.pdf ${gapGraphOUTDIR}