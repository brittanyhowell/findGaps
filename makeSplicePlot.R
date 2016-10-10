args = commandArgs(TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}





splices <- read.table(args[1])
colnames(splices) <- c("five", "three" )
monocolours <- c("darkgrey", "darkgrey", "cornflowerblue", "darkgrey")
dicolours <- c("darkgrey","darkgrey", "cornflowerblue", "darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey")

num <- nrow(splices)

pdf(args[2], width = 10, height = 6)
  plot(splices$three, main = args[3], col = monocolours)
  abline(h=num/4)
graphics.off()

pdf(args[4], width = 10, height = 6)
  plot(splices$five, main = args[3], col = dicolours)
  abline(h = num/16, col = 1)
graphics.off()

























