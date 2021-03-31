source("timingCIs.R")

#task 1
timing_CIs.df <- timingCI(task.df,"1",'Animation')
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"1",'Overlaid'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"1",'SMultiples'))
#timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"1",'Mix'))

#task 2
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"2",'Animation'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"2",'Overlaid'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"2",'SMultiples'))
#timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"2",'Mix'))

#task 3
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"3",'Animation'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"3",'Overlaid'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"3",'SMultiples'))
#timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"3",'Mix'))

#task 4
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"4",'Animation'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"4",'Overlaid'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"4",'SMultiples'))
#timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"4",'Mix'))

#task 5
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"5",'Animation'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"5",'Overlaid'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"5",'SMultiples'))
#timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"5",'Mix'))

#task 6
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"6",'Animation'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"6",'Overlaid'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"6",'SMultiples'))
#timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"6",'Mix'))

#task 7
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"7",'Animation'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"7",'Overlaid'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"7",'SMultiples'))
#timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"7",'Mix'))

#task 8
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"8",'Animation'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"8",'Overlaid'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"8",'SMultiples'))
#timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"8",'Mix'))

#task 9
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"9",'Animation'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"9",'Overlaid'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"9",'SMultiples'))
#timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"9",'Mix'))

#task 10
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"10",'Animation'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"10",'Overlaid'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"10",'SMultiples'))
#timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"10",'Mix'))

#task 11
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"11",'Animation'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"11",'Overlaid'))
timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"11",'SMultiples'))
#timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"11",'Mix'))

#task 12
# timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"12",'Animation'))
# timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"12",'Overlaid'))
# timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"12",'SMultiples'))
# timing_CIs.df <- rbind(timing_CIs.df,timingCI(task.df,"12",'Mix'))

timing_CIs.df$TaskID <- revalue(timing_CIs.df$TaskID, c("1" = "Task 1",
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

#timing_CIs.df$VisModeID <- ordered(timing_CIs.df$VisModeID, levels = c('Animation','Overlaid','SMultiples','Mix'))
timing_CIs.df$VisModeID <- ordered(timing_CIs.df$VisModeID, levels = c('Animation','Overlaid','SMultiples','Mix'))

timing_CIs.df$VisModeID <- revalue(timing_CIs.df$VisModeID, c("Animation" = "A",
                                                              "Overlaid" = "O",
                                                              "SMultiples" = "S"
                                                              #"Mix" = "M"
))


plot_timing_CI2 <- dualChart(timing_CIs.df,ymin = 0,ymax = 180,yAxisLabel = "",xAxisLabel = "",displayXLabels = T,displayYLabels = T,vLineVal = -30,percentScale=F)
#ggsave(plot = plot_timing_CI2, filename = "plot_timing_CI2.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

#plot_timing_CI_axis2 <- gridChart(timing_CIs.df,'Task 1',ymin = -0.5,ymax = 4,yAxisLabel = "",xAxisLabel = "",displayXLabels = T,displayYLabels = F,vLineVal = -30,percentScale=F)

plot_timing_CI2_1 <- gridChart(timing_CIs.df,'Task 1',ymin = 0,ymax = 180,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -30,percentScale=F)
ggsave(plot = plot_timing_CI2_1, filename = "plot_timing_CI2_1.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_CI2_2 <- gridChart(timing_CIs.df,'Task 2',ymin = 0,ymax = 180,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -30,percentScale=F)
ggsave(plot = plot_timing_CI2_2, filename = "plot_timing_CI2_2.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_CI2_3 <- gridChart(timing_CIs.df,'Task 3',ymin = 0,ymax = 180,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -30,percentScale=F)
ggsave(plot = plot_timing_CI2_3, filename = "plot_timing_CI2_3.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_CI2_4 <- gridChart(timing_CIs.df,'Task 4',ymin = 0,ymax = 180,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -30,percentScale=F)
ggsave(plot = plot_timing_CI2_4, filename = "plot_timing_CI2_4.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_CI2_5 <- gridChart(timing_CIs.df,'Task 5',ymin = 0,ymax = 180,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -30,percentScale=F)
ggsave(plot = plot_timing_CI2_5, filename = "plot_timing_CI2_5.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_CI2_6 <- gridChart(timing_CIs.df,'Task 6',ymin = 0,ymax = 180,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -30,percentScale=F)
ggsave(plot = plot_timing_CI2_6, filename = "plot_timing_CI2_6.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_CI2_7 <- gridChart(timing_CIs.df,'Task 7',ymin = 0,ymax = 180,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -30,percentScale=F)
ggsave(plot = plot_timing_CI2_7, filename = "plot_timing_CI2_7.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_CI2_8 <- gridChart(timing_CIs.df,'Task 8',ymin = 0,ymax = 180,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -30,percentScale=F)
ggsave(plot = plot_timing_CI2_8, filename = "plot_timing_CI2_8.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_CI2_9 <- gridChart(timing_CIs.df,'Task 9',ymin = 0,ymax = 180,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -30,percentScale=F)
ggsave(plot = plot_timing_CI2_9, filename = "plot_timing_CI2_9.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_CI2_10 <- gridChart(timing_CIs.df,'Task 10',ymin = 0,ymax = 180,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -30,percentScale=F)
ggsave(plot = plot_timing_CI2_10, filename = "plot_timing_CI2_10.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_timing_CI2_11 <- gridChart(timing_CIs.df,'Task 11',ymin = 0,ymax = 180,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -30,percentScale=F)
ggsave(plot = plot_timing_CI2_11, filename = "plot_timing_CI2_11.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

#plot_timing_CI2_12 <- gridChart(timing_CIs.df,'Task 12',ymin = -0.5,ymax = 4,yAxisLabel = "",xAxisLabel = "",displayXLabels = T,displayYLabels = T,vLineVal = -30,percentScale=F)