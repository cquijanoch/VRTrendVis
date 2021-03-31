
subj_CI_familiarity <- function(result.df,exp_condition) {
  
  result_subset.df <- subset(result.df,VisModeID==exp_condition)
  result_subset.df <- subset(result_subset.df,!is.na(Q1))

  CI <- bootstrapMeanCI(result_subset.df$Q1,0.95)
  BCI <- bootstrapMeanCI(result_subset.df$Q1,0.99)
  
  exactCI.df <- data.frame('Q1',exp_condition,CI[1],CI[2],CI[3],BCI[2],BCI[3],length(result_subset.df$Q1))
  colnames(exactCI.df) <- c('TaskID','VisModeID','mean','lowerBound_CI','upperBound_CI','lowerBound_BCI','upperBound_BCI','n')
  
  return(exactCI.df)

}

subj_CI_confidence <- function(result.df,exp_condition) {
  
  result_subset.df <- subset(result.df,VisModeID==exp_condition)
  result_subset.df <- subset(result_subset.df,!is.na(Q2))

  CI <- bootstrapMeanCI(result_subset.df$Q2,0.95)
  BCI <- bootstrapMeanCI(result_subset.df$Q2,0.99)
  
  exactCI.df <- data.frame('Q2',exp_condition,CI[1],CI[2],CI[3],BCI[2],BCI[3],length(result_subset.df$Q2))
  colnames(exactCI.df) <- c('TaskID','VisModeID','mean','lowerBound_CI','upperBound_CI','lowerBound_BCI','upperBound_BCI','n')
  
  return(exactCI.df)
  
}

subj_CI_ease <- function(result.df,exp_condition) {
  
  result_subset.df <- subset(result.df,VisModeID==exp_condition)
  result_subset.df <- subset(result_subset.df,!is.na(Q3))

  CI <- bootstrapMeanCI(result_subset.df$Q3,0.95)
  BCI <- bootstrapMeanCI(result_subset.df$Q3,0.99)
  
  exactCI.df <- data.frame('Q3',exp_condition,CI[1],CI[2],CI[3],BCI[2],BCI[3],length(result_subset.df$Q3))
  colnames(exactCI.df) <- c('TaskID','VisModeID','mean','lowerBound_CI','upperBound_CI','lowerBound_BCI','upperBound_BCI','n')
  
  return(exactCI.df)
  
}

 #familiarity
#subj_CIs.df <- subj_CI_familiarity(subjetive.df,"1")
#subj_CIs.df <- rbind(subj_CIs.df,subj_CI_familiarity(subjetive.df,'2'))
#subj_CIs.df <- rbind(subj_CIs.df,subj_CI_familiarity(subjetive.df,'3'))
#subj_CIs.df <- rbind(subj_CIs.df,subj_CI_familiarity(subjetive.df,'4'))

#confidence
subj_CIs.df <- subj_CI_confidence(subjetive.df,'1')
subj_CIs.df <- rbind(subj_CIs.df,subj_CI_confidence(subjetive.df,'2'))
subj_CIs.df <- rbind(subj_CIs.df,subj_CI_confidence(subjetive.df,'3'))
subj_CIs.df <- rbind(subj_CIs.df,subj_CI_confidence(subjetive.df,'4'))

#ease
subj_CIs.df <- rbind(subj_CIs.df,subj_CI_ease(subjetive.df,'1'))
subj_CIs.df <- rbind(subj_CIs.df,subj_CI_ease(subjetive.df,'2'))
subj_CIs.df <- rbind(subj_CIs.df,subj_CI_ease(subjetive.df,'3'))
subj_CIs.df <- rbind(subj_CIs.df,subj_CI_ease(subjetive.df,'4'))


subj_CIs.df$VisModeID <- revalue(subj_CIs.df$VisModeID, c("1" = "A",
                                                          "2" = "O",
                                                          "3" = "S",
                                                          "4" = "M"
))

subj_CIs.df$TaskID <- subj_CIs.df$TaskID %>% as.factor()
subj_CIs.df$TaskID <- revalue(subj_CIs.df$TaskID, c(#"Q1" = "Familiarity",
                                                "Q2" = "Confidence",
                                                "Q3" = "Ease of Use"
))

subj_CIs.df$VisModeID <- ordered(subj_CIs.df$VisModeID, levels = c('M','A','O','S'))
#subj_CIs.df$VisModeID <- ordered(subj_CIs.df$VisModeID, levels = c('M','S','O','A'))

plot_subj_CI2 <- dualChart(subj_CIs.df,ymin = 0.5,ymax = 5.5,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)

plot_subj_CI2_1 <- gridChart(subj_CIs.df,'Confidence',ymin = 1,ymax = 5,yAxisLabel = "",xAxisLabel = "Confidence",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_subj_CI2_1, filename = "plot_subj_CI2_1.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_subj_CI2_2 <- gridChart(subj_CIs.df,'Ease of Use',ymin = 1,ymax = 5,yAxisLabel = "",xAxisLabel = "Ease of Use",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_subj_CI2_2, filename = "plot_subj_CI2_2.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)