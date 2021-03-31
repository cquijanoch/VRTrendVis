library(plyr)

#error magnitude
pointsCI <- function(result.df,task_num,exp_condition) {
  
  if (task_num == "Visualization")
  {
    result_subset.df <- data.frame(result.df[result.df$TaskID !="12",])
  }
  else
  {
    result_subset.df <- subset(result.df,TaskID==task_num)
  }
  
  result_subset.df <- result_subset.df[result_subset.df$VisModeID==exp_condition,]
  
  CI <- bootstrapMeanCI((result_subset.df$points / result_subset.df$NumAnswers),0.95)
  BCI <- bootstrapMeanCI((result_subset.df$points / result_subset.df$NumAnswers),0.99)
  
  exactCI.df <- data.frame(task_num,exp_condition,CI[1],CI[2],CI[3],BCI[2],BCI[3],length(result_subset.df$points))
  colnames(exactCI.df) <- c('TaskID','VisModeID','mean','lowerBound_CI','upperBound_CI','lowerBound_BCI','upperBound_BCI','n')
  
  return(exactCI.df)
}
