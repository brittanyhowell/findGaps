# findGaps

## Summary:
This repo finds instances of long gaps which occur in multiple sequences, and has some tools to analyse the output (which for now has to be collected manually...)
Note the inputs necessary for these tools can be made with the scripts found in the ClusterFilter repo (https://github.com/brittanyhowell/ClusterFilter)

#### Input/Output
Input: 		Fasta alignments
Output: 	Plots which suggest where gaps might be, and a summary plot of where the candidate gaps are, also some files which can be used to make webLogos.

#### Script Purposes:

- plotIntervals.sh:		Invoke findGaps.go then coverageIntervals.R. 
- findGaps.go:			Scan alignment fasta files, look for gaps, report coordinates of gaps.
- coverageIntervals.R:	Plots coverage data across canonical L1s of alignment gaps, to allow visualisation of gaps common to multiple sequences.



- LatexToTab.sh:			Converts LaTeX table into tab delimited file.
- covGapIntervals.sh:		Plots coverage plot of every candidate plot (bad way of displaying data).
- coverageGenomic.sh:		Plots rectangle ranges plot of every candidate gap (still bad but not quite as bad).



- extractGenomeSites.sh:	Uses sed/awk to extract the useful splice junction nucleotides from the recorded genome data. Invokes makeSplicePlot.sh.
- makeSplicePlot.sh:		Makes fairly atrocious plot of the most common SJ nucleotides.

