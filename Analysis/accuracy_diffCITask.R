source('accuracy_diffCI.R')


#task 1
propDiff_CIs.df <- propDiffCI(task.df,"1")

#task 2
propDiff_CIs.df <- rbind(propDiff_CIs.df,propDiffCI(task.df,"2"))

#task 3
propDiff_CIs.df <- rbind(propDiff_CIs.df,propDiffCI(task.df,"3"))

#task 4
propDiff_CIs.df <- rbind(propDiff_CIs.df,propDiffCI(task.df,"4"))

#task 5
propDiff_CIs.df <- rbind(propDiff_CIs.df,propDiffCI(task.df,"5"))

#task 6
propDiff_CIs.df <- rbind(propDiff_CIs.df,propDiffCI(task.df,"6"))

#task 7
propDiff_CIs.df <- rbind(propDiff_CIs.df,propDiffCI(task.df,"7"))

#task 8
propDiff_CIs.df <- rbind(propDiff_CIs.df,propDiffCI(task.df,"8"))

#task 9
propDiff_CIs.df <- rbind(propDiff_CIs.df,propDiffCI(task.df,"9"))

#task 10
propDiff_CIs.df <- rbind(propDiff_CIs.df,propDiffCI(task.df,"10"))

#task 11
propDiff_CIs.df <- rbind(propDiff_CIs.df,propDiffCI(task.df,"11"))

#task 12
#propDiff_CIs.df <- rbind(propDiff_CIs.df,propDiffCI(task.df,"12"))

propDiff_CIs.df$TaskID <- revalue(propDiff_CIs.df$TaskID, c("1" = "Task 1",
                                                            "2" = "Task 2",
                                                            "3" = "Task 3",
                                                            "4" = "Task 4",
                                                            "5" = "Task 5",
                                                            "6" = "Task 6",
                                                            "7" = "Task 7",
                                                            "8" = "Task 8",
                                                            "9" = "Task 9",
                                                            "10" = "Task 10",
                                                            "11" = "Task 11"
                                                            #"12" = "Task 12"
))

plot_propDiff_CI2 <- dualChart(propDiff_CIs.df,ymin = -1,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)

plot_propDiff_CI2_1 <- gridChart(propDiff_CIs.df,'Task 1',ymin = -1,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_propDiff_CI2_1, filename = "plot_propDiff_CI2_1.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_propDiff_CI2_2 <- gridChart(propDiff_CIs.df,'Task 2',ymin = -1,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_propDiff_CI2_2, filename = "plot_propDiff_CI2_2.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_propDiff_CI2_3 <- gridChart(propDiff_CIs.df,'Task 3',ymin = -1,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_propDiff_CI2_3, filename = "plot_propDiff_CI2_3.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_propDiff_CI2_4 <- gridChart(propDiff_CIs.df,'Task 4',ymin = -1,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_propDiff_CI2_4, filename = "plot_propDiff_CI2_4.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_propDiff_CI2_5 <- gridChart(propDiff_CIs.df,'Task 5',ymin = -1,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_propDiff_CI2_5, filename = "plot_propDiff_CI2_5.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_propDiff_CI2_6 <- gridChart(propDiff_CIs.df,'Task 6',ymin = -1,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_propDiff_CI2_6, filename = "plot_propDiff_CI2_6.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_propDiff_CI2_7 <- gridChart(propDiff_CIs.df,'Task 7',ymin = -1,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_propDiff_CI2_7, filename = "plot_propDiff_CI2_7.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_propDiff_CI2_8 <- gridChart(propDiff_CIs.df,'Task 8',ymin = -1,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_propDiff_CI2_8, filename = "plot_propDiff_CI2_8.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_propDiff_CI2_9 <- gridChart(propDiff_CIs.df,'Task 9',ymin = -1,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_propDiff_CI2_9, filename = "plot_propDiff_CI2_9.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_propDiff_CI2_10 <- gridChart(propDiff_CIs.df,'Task 10',ymin = -1,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_propDiff_CI2_10, filename = "plot_propDiff_CI2_10.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_propDiff_CI2_11 <- gridChart(propDiff_CIs.df,'Task 11',ymin = -1,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_propDiff_CI2_11, filename = "plot_propDiff_CI2_11.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_propDiff_CI2_12 <- gridChart(propDiff_CIs.df,'Task 12',ymin = -1,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_propDiff_CI2_12, filename = "plot_propDiff_CI2_12.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)
