library(PropCIs)
library(plyr)

accuracyCI <- function(result.df,task_num ,exp_condition) {
  
  if(task_num == "Visualization")
  {
    result_subset.df <- data.frame(result.df)
  }
  else
  {
      result_subset.df <- subset(result.df,TaskID==task_num)
  }
  
  result_subset.df <- result_subset.df[result_subset.df$VisModeID==exp_condition,]
  
  CI <- bootstrapProportionCI(result_subset.df$accuracy,0.95)
  BCI <- bootstrapProportionCI(result_subset.df$accuracy,0.99)
  
  exactCI.df <- data.frame(task_num,exp_condition,mean(result_subset.df$accuracy),CI[2],CI[3],BCI[2],BCI[3],length(result_subset.df$accuracy))
  colnames(exactCI.df) <- c('TaskID','VisModeID','mean','lowerBound_CI','upperBound_CI','lowerBound_BCI','upperBound_BCI','n')
  
  return(exactCI.df)
  
}
