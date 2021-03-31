source("timingDiffCIs.R")

#task 1
timing_diff_CIs.df <- timing_diffCI(task.df,"1")

#task 2
timing_diff_CIs.df <- rbind(timing_diff_CIs.df,timing_diffCI(task.df,"2"))

#task 3
timing_diff_CIs.df <- rbind(timing_diff_CIs.df,timing_diffCI(task.df,"3"))

#task 4
timing_diff_CIs.df <- rbind(timing_diff_CIs.df,timing_diffCI(task.df,"4"))

#task 5
timing_diff_CIs.df <- rbind(timing_diff_CIs.df,timing_diffCI(task.df,"5"))

#task 6
timing_diff_CIs.df <- rbind(timing_diff_CIs.df,timing_diffCI(task.df,"6"))

#task 7
timing_diff_CIs.df <- rbind(timing_diff_CIs.df,timing_diffCI(task.df,"7"))

#task 8
timing_diff_CIs.df <- rbind(timing_diff_CIs.df,timing_diffCI(task.df,"8"))

#task 9
timing_diff_CIs.df <- rbind(timing_diff_CIs.df,timing_diffCI(task.df,"9"))

#task 10
timing_diff_CIs.df <- rbind(timing_diff_CIs.df,timing_diffCI(task.df,"10"))

#task 11
timing_diff_CIs.df <- rbind(timing_diff_CIs.df,timing_diffCI(task.df,"11"))

#task 12
#timing_diff_CIs.df <- rbind(timing_diff_CIs.df,timing_diffCI(task.df,"12"))

timing_diff_CIs.df$TaskID <- revalue(timing_diff_CIs.df$TaskID, c("1" = "Task 1",
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

plot_timing_diff_CI2 <- dualChart(timing_diff_CIs.df,ymin = 0,ymax = 3,yAxisLabel = "",xAxisLabel = "",displayXLabels = T,displayYLabels = T,vLineVal = 1,percentScale=F)
#ggsave(plot = plot_timing_diff_CI2, filename = "plot_timing_diff_CI2.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_diff_CI2_1 <- gridChart(timing_diff_CIs.df,'Task 1',ymin = 0,ymax = 3,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 1,percentScale=F)
ggsave(plot = plot_timing_diff_CI2_1, filename = "plot_timing_diff_CI2_1.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_diff_CI2_2 <- gridChart(timing_diff_CIs.df,'Task 2',ymin = 0,ymax = 3,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 1,percentScale=F)
ggsave(plot = plot_timing_diff_CI2_2, filename = "plot_timing_diff_CI2_2.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_diff_CI2_3 <- gridChart(timing_diff_CIs.df,'Task 3',ymin = 0,ymax = 3,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 1,percentScale=F)
ggsave(plot = plot_timing_diff_CI2_3, filename = "plot_timing_diff_CI2_3.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_diff_CI2_4 <- gridChart(timing_diff_CIs.df,'Task 4',ymin = 0,ymax = 3,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 1,percentScale=F)
ggsave(plot = plot_timing_diff_CI2_4, filename = "plot_timing_diff_CI2_4.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_diff_CI2_5 <- gridChart(timing_diff_CIs.df,'Task 5',ymin = 0,ymax = 3,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 1,percentScale=F)
ggsave(plot = plot_timing_diff_CI2_5, filename = "plot_timing_diff_CI2_5.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_diff_CI2_6 <- gridChart(timing_diff_CIs.df,'Task 6',ymin = 0,ymax = 3,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 1,percentScale=F)
ggsave(plot = plot_timing_diff_CI2_6, filename = "plot_timing_diff_CI2_6.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_diff_CI2_7 <- gridChart(timing_diff_CIs.df,'Task 7',ymin = 0,ymax = 3,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 1,percentScale=F)
ggsave(plot = plot_timing_diff_CI2_7, filename = "plot_timing_diff_CI2_7.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_diff_CI2_8 <- gridChart(timing_diff_CIs.df,'Task 8',ymin = 0,ymax = 3,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 1,percentScale=F)
ggsave(plot = plot_timing_diff_CI2_8, filename = "plot_timing_diff_CI2_8.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_diff_CI2_9 <- gridChart(timing_diff_CIs.df,'Task 9',ymin = 0,ymax = 3,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 1,percentScale=F)
ggsave(plot = plot_timing_diff_CI2_9, filename = "plot_timing_diff_CI2_9.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_diff_CI2_10 <- gridChart(timing_diff_CIs.df,'Task 10',ymin = 0,ymax = 3,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 1,percentScale=F)
ggsave(plot = plot_timing_diff_CI2_10, filename = "plot_timing_diff_CI2_10.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_diff_CI2_11 <- gridChart(timing_diff_CIs.df,'Task 11',ymin = 0,ymax = 3,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 1,percentScale=F)
ggsave(plot = plot_timing_diff_CI2_11, filename = "plot_timing_diff_CI2_11.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

#plot_timing_diff_CI2_12 <- gridChart(timing_diff_CIs.df,'Task 12',ymin = 0,ymax = 4,yAxisLabel = "",xAxisLabel = "",displayXLabels = T,displayYLabels = T,vLineVal = 1,percentScale=F)