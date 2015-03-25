library(microbenchmark) #For timing purposes
library(compiler)
source("lucompletepivot.R")

lup <- cmpfun(lu_complete_pivot)
timings <- matrix(0, 9, 9)
mbargs <- list()
mbargs$warmup <- 0

j <- 1
for (n in c(10, 20, 50, 100, 200, 500, 1000, 2000, 5000)) {
	A <- matrix(rnorm(n*n), n, n)
	data <- microbenchmark(lup(A), times=5, control=mbargs)
	t <- data$time / 10^9 #Nanoseconds to seconds
	timings[j, 1] <- n
	timings[j, 2:6] <- t
	timings[j, 7] <- min(t)
	timings[j, 8] <- mean(t)
	timings[j, 9] <- sd(t)
	print(timings[j, 1:9])
	j <- j+1
}
write.table(timings, file = "../../data/lu/R-compiler.csv", sep = ",", col.names = FALSE, row.names = FALSE)
