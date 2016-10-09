#!/bin/bash
## Script extracts column containing splice acceptor sites from bamReader.go output

wkDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ClusterFilter/findGaps/outputGapFinding
outDIR=${wkDIR}

genomeGapTable="gapSummaryEdit.txt"
outName="spliceJunctionSites-Genome.txt"

# Check if outFolder exists
    if [ -d $outDIR ]; then
    	echo "Folder $outDIR exists ..." 
    else
    	mkdir $outDIR
    	echo "Folder $outDIR does not exist"     
   	mkdir $outDIR
    fi

cd ${wkDIR}
	
# Part 1: Extract the SJ nucleotides
	# Remove terminal \\, print only columns 9 & 11, replace all spaces with tabs print only the three required SJ nucleotides.
	cat ${genomeGapTable}| sed s/\\\\//g |  awk '{print $9 "\t" $11}' | tr "/" "\t" | sed -e 's/./&      /g'|awk '{print $1$2 "\t" $7 }' > "${outDIR}/${outName}"
		


# Part 2: Plot the splice junctions in a nice plotty plot
	tableDIR=${outDIR}
	plotDIR=${wkDIR}/../plots/

	gapTable=${tableDIR}/$outName

 	cd ${tableDIR}


	pdfSplice5="genomeSplice_5.pdf"
	pdfSplice3="genomeSplice_3.pdf"
	



	Rscript makeSplicePlot.R ${gapTable} ${plotDIR}/${pdfSplice3} "" ${plotDIR}/${pdfSplice5}


	# args 1: table input
	# args 2: pdf of table of 3' sites (mononucleotide)
	# args 3: title on both plots: should be sample name
	# args 4: pdf of table of 5' sites (dinucleotides)



 echo "complete"





