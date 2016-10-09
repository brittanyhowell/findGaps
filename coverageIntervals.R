args = commandArgs(TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}


setwd("~/Documents/University/Honours_2016/Project/ClusterFilter/findGaps/Scripts/")
# load IRanges library
library(IRanges)

# randomly generated start and end coordinates of intervals
bed <- read.table(file = args[1])
#bed <- read.table("../outputGapFinding/gapTrials/gapOutput12NonSplit/gaps_cluster_108.fasta")
colnames(bed) <- c("name", "start", "end", "length")

start = bed$start
end = bed$end

# intervals stored as an IRanges object
intervals <- IRanges(start = start, end = end)

pdf(args[2], width = 10, height = 6)

cov <- coverage(intervals)
# plot coverage
plot(cov[cov < 8 ], type = "l"  , xlab = "position",   ylab = "number of sequences with gaps", main = args[3])
#axis(side = 1, at = x)
graphics.off()

