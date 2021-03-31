library(boot)
library(PropCIs)
library(Hmisc)

deterministic <- TRUE
replicates <- 10000
intervalMethod <- "bca"
significantDigits <- 3

samplemean <- function(x, d) {
  return(mean(x[d]))
}

proportion <- function(x, d) {
  return(sum(x[d])/length(x[d]))
}


# Returns the point estimate and confidence interval in an array of length 3
bootstrapCI <- function(statistic, datapoints,conf) {
  # Compute the point estimate
  pointEstimate <- statistic(datapoints)
  # Make the rest of the code deterministic
  if (deterministic) set.seed(0)
  # Generate bootstrap replicates
  b <- boot(datapoints, statistic, R = replicates, parallel="multicore")
  # Compute interval
  ci <- boot.ci(b, type = intervalMethod,conf=conf)
  # Return the point estimate and CI bounds
  # You can print the ci object for more info and debug
  lowerBound <- ci$bca[4]
  upperBound <- ci$bca[5]
  return(c(pointEstimate, lowerBound, upperBound))
}

# Returns the mean and its confidence interval in an array of length 3
bootstrapMeanCI <- function(datapoints,conf) {
  return(bootstrapCI(samplemean, datapoints,conf))
}

# Returns the proportion and its confidence interval in an array of length 3
bootstrapProportionCI <- function(datapoints,conf) {
  return(bootstrapCI(proportion, datapoints,conf))
}
