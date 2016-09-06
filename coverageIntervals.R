setwd("~/Documents/University/Honours_2016/Project/ClusterFilter/findGaps/Scripts/")
# load IRanges library
library(IRanges)

# randomly generated start and end coordinates of intervals
bed <- read.table("gaps_cluster_198.fasta")
colnames(bed) <- c("name", "start", "end", "length")

start = bed$start
end = bed$end


# intervals stored as an IRanges object
intervals <- IRanges(start = start, end = end)

# plot coverage
plot(coverage(intervals), type = "l")

# so this is if we had 10 elements that could randomly contain gaps at any position
n = 175

# the total number of gaps across all elements / the total number of positions across all elemennts
p = sum(width(intervals))/(length(coverage(intervals))*n)

abline(h = n*p) # mean
abline(h= (n*p) + (1*(n*p*(1-p))), lty = 2) #mean + 1sd
abline(h= (n*p) - (1*(n*p*(1-p))), lty = 2) # mean - 1 sd

abline(h= (n*p) + (2*(n*p*(1-p))), lty = 2) #mean + 2sd
abline(h= (n*p) - (2*(n*p*(1-p))), lty = 2) # mean - 2 sd
