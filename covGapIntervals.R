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
#bed <- read.table(file = args[1])
gaps <- read.table("../outputGapFinding/gapsTable.txt")
colnames(gaps) <- c("cluster", "start", "end", "length")

start = gaps$start
end = gaps$end

# intervals stored as an IRanges object
intervals <- IRanges(start = start, end = end)

pdf(args[2], width = 10, height = 6)

#x <- c(seq(from=0,to=40000,by=500))

cov <- coverage(intervals)

plot(gaps$start[order(gaps$start)], gaps$length[order(gaps$start)], type = "l",  xlim = c(0,6000), xlab = "start position", ylab = "gap Length")
plot(gaps$end[order(gaps$end)], gaps$length[order(gaps$end)], type = "l",  xlim = c(0,6000), xlab = "end position", ylab = "gap Length")



plot(coverage(intervals), type = "l")




smoothNum <- round(runmean(coverage(intervals), 51, endrule = "constant"))
plot(smoothNum, type = "l", xlim = c(0,6000), xlab = "Position", ylab = "Instances of gaps")

#lines(ksmooth(x, y, kernel = "normal", bandwidth = 5))#, col = ‘purple’, lty=7)

# plot coverage
plot(cov[cov < 8 ], type = "l"  , xlab = "position",   ylab = "number of sequences with gaps", main = args[3])
#axis(side = 1, at = x)
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


