timingCI <- function(result.df,task_num,exp_condition) {


  result_subset.df <- subset(result.df,TaskID==task_num)
  result_subset.df <- result_subset.df[result_subset.df$VisModeID==exp_condition,]

  result_subset.df$log_duration <- log(result_subset.df$duration)
  result_skewness <- skewness(result_subset.df$duration)
  result_log_skewness <- skewness(result_subset.df$log_duration)
  
  CI <- bootstrapMeanCI(result_subset.df$log_duration,0.95)
  BCI <- bootstrapMeanCI(result_subset.df$log_duration,0.99)
  
  exactCI.df <- data.frame(task_num,exp_condition,exp(CI[1]),exp(CI[2]),exp(CI[3]),exp(BCI[2]),exp(BCI[3]),length(result_subset.df$log_duration))
  colnames(exactCI.df) <- c('TaskID','VisModeID','mean','lowerBound_CI','upperBound_CI','lowerBound_BCI','upperBound_BCI','n')
  
  return(exactCI.df)
  
}

timingCI_Vis <- function(result.df,exp_condition) {


  result_subset.df <- subset(result.df,VisModeID==exp_condition)

  result_subset.df$log_duration <- log(result_subset.df$duration)
  result_skewness <- skewness(result_subset.df$duration)
  result_log_skewness <- skewness(result_subset.df$log_duration)
  
  CI <- bootstrapMeanCI(result_subset.df$log_duration,0.95)
  BCI <- bootstrapMeanCI(result_subset.df$log_duration,0.99)
  
  exactCI.df <- data.frame("Visualization",exp_condition,exp(CI[1]),exp(CI[2]),exp(CI[3]),exp(BCI[2]),exp(BCI[3]),length(result_subset.df$log_duration))
  colnames(exactCI.df) <- c('TaskID','VisModeID','mean','lowerBound_CI','upperBound_CI','lowerBound_BCI','upperBound_BCI','n')
  
  return(exactCI.df)
  
}
