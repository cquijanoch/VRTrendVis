source("accuracyCIs.R")

#task 1
accuracy_CIs.df <- accuracyCI(task.df,"1",'Animation')
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"1",'Overlaid'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"1",'SMultiples'))
#accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"1",'Mix'))

#task 2
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"2",'Animation'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"2",'Overlaid'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"2",'SMultiples'))
#accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"2",'Mix'))

#task 3
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"3",'Animation'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"3",'Overlaid'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"3",'SMultiples'))
#accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"3",'Mix'))

#task 4
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"4",'Animation'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"4",'Overlaid'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"4",'SMultiples'))
#accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"4",'Mix'))

#task 5
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"5",'Animation'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"5",'Overlaid'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"5",'SMultiples'))
#accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"5",'Mix'))

#task 6
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"6",'Animation'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"6",'Overlaid'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"6",'SMultiples'))
#accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"6",'Mix'))

#task 7
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"7",'Animation'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"7",'Overlaid'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"7",'SMultiples'))
#accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"7",'Mix'))

#task 8
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"8",'Animation'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"8",'Overlaid'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"8",'SMultiples'))
#accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"8",'Mix'))

#task 9
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"9",'Animation'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"9",'Overlaid'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"9",'SMultiples'))
#accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"9",'Mix'))

#task 10
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"10",'Animation'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"10",'Overlaid'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"10",'SMultiples'))
#accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"10",'Mix'))

#task 11
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"11",'Animation'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"11",'Overlaid'))
accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"11",'SMultiples'))
#accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"11",'Mix'))

#task 12
#accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"12",'Animation'))
#accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"12",'Overlaid'))
#accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"12",'SMultiples'))
#accuracy_CIs.df <- rbind(accuracy_CIs.df,accuracyCI(task.df,"12",'Mix'))

accuracy_CIs.df$TaskID <- revalue(accuracy_CIs.df$TaskID, c("1" = "Task 1",
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

#accuracy_CIs.df$VisModeID <- ordered(accuracy_CIs.df$VisModeID, levels = c('Mix','SMultiples','Overlaid','Animation'))
accuracy_CIs.df$VisModeID <- ordered(accuracy_CIs.df$VisModeID, levels = c('SMultiples','Overlaid','Animation'))

accuracy_CIs.df$VisModeID <- revalue(accuracy_CIs.df$VisModeID, c("Animation" = "A",
                                                                    "Overlaid" = "O",
                                                                    "SMultiples" = "S"
                                                                    #"Mix" = "M"
))

accuracy_CIs.df$VisModeID <- ordered(accuracy_CIs.df$VisModeID, levels = c('A','O','S'))

plot_accuracy_CI2 <- dualChart(accuracy_CIs.df,ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
#ggsave(plot = plot_timing_CI2_1, filename = "plot_timing_CI2_1.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_accuracy_CI2_1 <- gridChart(accuracy_CIs.df,'Task 1',ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_accuracy_CI2_1, filename = "plot_accuracy_CI2_1.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_accuracy_CI2_2 <- gridChart(accuracy_CIs.df,'Task 2',ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_accuracy_CI2_2, filename = "plot_accuracy_CI2_2.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_accuracy_CI2_3 <- gridChart(accuracy_CIs.df,'Task 3',ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_accuracy_CI2_3, filename = "plot_accuracy_CI2_3.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_accuracy_CI2_4 <- gridChart(accuracy_CIs.df,'Task 4',ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_accuracy_CI2_4, filename = "plot_accuracy_CI2_4.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_accuracy_CI2_5 <- gridChart(accuracy_CIs.df,'Task 5',ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_accuracy_CI2_5, filename = "plot_accuracy_CI2_5.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_accuracy_CI2_6 <- gridChart(accuracy_CIs.df,'Task 6',ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_accuracy_CI2_6, filename = "plot_accuracy_CI2_6.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_accuracy_CI2_7 <- gridChart(accuracy_CIs.df,'Task 7',ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_accuracy_CI2_7, filename = "plot_accuracy_CI2_7.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_accuracy_CI2_8 <- gridChart(accuracy_CIs.df,'Task 8',ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_accuracy_CI2_8, filename = "plot_accuracy_CI2_8.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_accuracy_CI2_9 <- gridChart(accuracy_CIs.df,'Task 9',ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_accuracy_CI2_9, filename = "plot_accuracy_CI2_9.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_accuracy_CI2_10 <- gridChart(accuracy_CIs.df,'Task 10',ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_accuracy_CI2_10, filename = "plot_accuracy_CI2_10.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_accuracy_CI2_11 <- gridChart(accuracy_CIs.df,'Task 11',ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_accuracy_CI2_11, filename = "plot_accuracy_CI2_11.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

#plot_accuracy_CI2_12 <- gridChart(accuracy_CIs.df,'Task 12',ymin = -0.1,ymax = 1.1,yAxisLabel = "",xAxisLabel = "",displayXLabels = T,displayYLabels = T,vLineVal = -1,percentScale=T)