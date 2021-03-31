source('pointsDiffCI.R')

##Tasks
trials_test_1.df <- task.df[task.df$TaskID=="1",]
trials_test_1.df <- bootdif(trials_test_1.df)
trials_test_1.df$TaskID <- "1"

trials_test_2.df <- task.df[task.df$TaskID=="2",]
trials_test_2.df <- bootdif(trials_test_2.df)
trials_test_2.df$TaskID <- "2"

trials_test_4.df <- task.df[task.df$TaskID=="4",]
trials_test_4.df <- bootdif(trials_test_4.df)
trials_test_4.df$TaskID <- "4"

trials_test_5.df <- task.df[task.df$TaskID=="5",]
trials_test_5.df <- bootdif(trials_test_5.df)
trials_test_5.df$TaskID <- "5"
 
trials_test_6.df <- task.df[task.df$TaskID=="6",]
trials_test_6.df <- bootdif(trials_test_6.df)
trials_test_6.df$TaskID <- "6"

trials_test_11.df <- task.df[task.df$TaskID=="11",]
trials_test_11.df <- bootdif(trials_test_11.df)
trials_test_11.df$TaskID <- "11"

#trials_test_12.df <- task.df[task.df$TaskID=="12",]
#trials_test_12.df <- bootdif(trials_test_12.df)
#trials_test_12.df$TaskID <- "12"

pointDiffCIs.df <- rbind(trials_test_1.df,trials_test_2.df,trials_test_4.df,trials_test_5.df,trials_test_6.df,trials_test_11.df)#,trials_test_12.df)
remove(trials_test_1.df,trials_test_2.df,trials_test_4.df,trials_test_5.df,trials_test_6.df,trials_test_11.df)#,trials_test_12.df)


pointDiffCIs.df$TaskID <- revalue(pointDiffCIs.df$TaskID, c("1" = "Task 1",
                                                        "2" = "Task 2",
                                                        "4" = "Task 4",
                                                        "5" = "Task 5",
                                                        "6" = "Task 6",
                                                        "11" = "Task 11"
                                                        #"12" = "Task 12"
))

plot_pointDiffCI2 <- dualChart(pointDiffCIs.df,ymin = -2,ymax = 2,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
#ggsave(plot = plot_pointDiffCI2, filename = "plot_pointDiffCI2.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_pointDiffCI2_1 <- gridChart(pointDiffCIs.df,'Task 1',ymin = -2,ymax = 2,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_pointDiffCI2_1, filename = "plot_pointDiffCI2_1.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_pointDiffCI2_2 <- gridChart(pointDiffCIs.df,'Task 2',ymin = -2,ymax = 2,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_pointDiffCI2_2, filename = "plot_pointDiffCI2_2.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_pointDiffCI2_4 <- gridChart(pointDiffCIs.df,'Task 4',ymin = -2,ymax = 2,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_pointDiffCI2_4, filename = "plot_pointDiffCI2_4.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_pointDiffCI2_5 <- gridChart(pointDiffCIs.df,'Task 5',ymin = -2,ymax = 2,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_pointDiffCI2_5, filename = "plot_pointDiffCI2_5.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_pointDiffCI2_6 <- gridChart(pointDiffCIs.df,'Task 6',ymin = -2,ymax = 2,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_pointDiffCI2_6, filename = "plot_pointDiffCI2_6.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_pointDiffCI2_11 <- gridChart(pointDiffCIs.df,'Task 11',ymin = -2,ymax = 2,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_pointDiffCI2_11, filename = "plot_pointDiffCI2_11.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)