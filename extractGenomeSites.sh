#!/bin/bash
## Script extracts column containing splice acceptor sites from bamReader.go output

wkDIR=/Users/brittanyhowell/Documents/University/Honours_2016/Project/ClusterFilter/findGaps/outputGapFinding
outDIR=${wkDIR}

genomeGapTable="gapSummaryEdit.txt"
outName="spliceJunctionSites-Genome.txt"

if [ -d $outDIR ]; then
    echo "Folder $outDIR exists ..." 
else
    mkdir $outDIR
    echo "Folder $outDIR does not exist"     
    mkdir $outDIR
fi

cd ${wkDIR}
	


cat ${genomeGapTable}| sed s/\\\\//g |  awk '{print $9 "\t" $11}' | tr "/" "\t" | sed -e 's/./&      /g'|awk '{print $1$2 "\t" $7 }' > "${outDIR}/${outName}"
		



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





