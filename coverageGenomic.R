args = commandArgs(TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}


setwd("~/Documents/University/Honours_2016/Project/ClusterFilter/findGaps/")
# load IRanges library
library(IRanges)


#gaps <- read.table("outputGapFinding/../../../bamReading/Split/gapInfoFiles/gapInRead_Mut-F2-Rep1_CGTACG_L007.txt")
gaps <- read.table("outputGapFinding/gapsTable.txt")

#split <- read.table("./gapInReadCigar.bed")

#colnames(gaps) <-  c("read name", "chromosome", "startL1", "endL1", "startGap", "endGap", "length", "cigar", "flag")
colnames(gaps) <- c("cluster", "start", "stop", "length")
head(gaps)
#start = gaps$startGap
#end = gaps$endGap
  
start = gaps$start
end = gaps$stop

# intervals stored as an IRanges object
gapIntervals <- IRanges(start = start, end = end)

#plot(coverage(intervals), type = "l", xlab = "position in L1", ylab = "number of instances", main = "Location of gaps within reads with splits located entirely within L1s")

plotRanges <- function(x, xlim = x, main = " ",
                       col = "black", sep = .1, ...)
{
  height <- .2
  if (is(xlim, "Ranges"))
    xlim <- c(min(start(xlim)), max(end(xlim)))
  bins <- disjointBins(IRanges(start(x), end(x) + 1))
  plot.new()
  plot.window(xlim, c(0, max(bins)*(height + sep)))
  ybottom <- bins * (sep + height) - height
  rect(start(x)-0.5, ybottom, end(x)+0.5, ybottom + height, col = col, ...)
  title(main)
  axis(1)
}

pdf("./plots/coverage/genomicSplices.pdf", width = 10, height = 6)
plotRanges(gapIntervals)
graphics.off()

# Make length distribution plot, in cornflower blue
plot(sort(gaps$length), main = "")
abline(h=100)


pdf("../../../Thesis/Figures/unGrouped/genomicGapLength.pdf", width = 10, height = 6)
par(mar = c(5,5,1,1))
plot(density(gaps$length), main = "",  xlab = "", ylab="", cex.axis = 1.5)
title(xlab= "length of gap (bp)", cex.lab = 1.5, ylab = "Density")
polygon(density(gaps$length), col = "cornflowerblue")
abline(v=100)
graphics.off()
#x <- c(seq(from=0,to=40000,by=500))

#cov <- coverage(intervals)

#plot(gaps$start[order(gaps$start)], gaps$length[order(gaps$start)], type = "l",  xlim = c(0,6000), xlab = "start position", ylab = "gap Length")
#plot(gaps$end[order(gaps$end)], gaps$length[order(gaps$end)], type = "l",  xlim = c(0,6000), xlab = "end position", ylab = "gap Length")




#smoothNum <- round(runmean(coverage(intervals), 51, endrule = "constant"))
#plot(smoothNum, type = "l", xlim = c(0,6000), xlab = "Position", ylab = "Instances of gaps")
#lines(ksmooth(x, y, kernel = "normal", bandwidth = 5))#, col = ‘purple’, lty=7)

# plot coverage
#plot(cov[cov < 8 ], type = "l"  , xlab = "position",   ylab = "number of sequences with gaps", main = args[3])
#axis(side = 1, at = x)


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


