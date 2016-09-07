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
colnames(bed) <- c("name", "start", "end", "length")

start = bed$start
end = bed$end


# intervals stored as an IRanges object
intervals <- IRanges(start = start, end = end)

pdf(args[2], width = 10, height = 6)

# plot coverage
plot(coverage(intervals), type = "l"  , xlab = "position")

graphics.off()

# so this is if we had 10 elements that could randomly contain gaps at any position
#n = args[2]

# the total number of gaps across all elements / the total number of positions across all elemennts
#p = sum(width(intervals))/(length(coverage(intervals))*n)

#abline(h = n*p) # mean
#abline(h= (n*p) + (1*sqrt(n*p*(1-p))), lty = 2) #mean + 1sd
#abline(h= (n*p) - (1*sqrt(n*p*(1-p))), lty = 2) # mean - 1 sd

#abline(h= (n*p) + (2*sqrt(n*p*(1-p))), lty = 2) #mean + 2sd
#abline(h= (n*p) - (2*sqrt(n*p*(1-p))), lty = 2) # mean - 2 sd



#cov <- as.integer(coverage(intervals))
#pos <- (1:length(cov))[cov < 15 & cov > 2]

#points(x = pos, y = cov[pos], pch = 16 ,col = 2)
#abline(h = 2, col = 3)
#abline(h = 15, col = 3)
