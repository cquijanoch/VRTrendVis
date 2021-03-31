source('pointsCIs.R')

#task 1
points_CIs.df <- pointsCI(task.df,"1",'Animation')
points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"1",'Overlaid'))
points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"1",'SMultiples'))
#points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"1",'Mix'))

#task 2
points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"2",'Animation'))
points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"2",'Overlaid'))
points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"2",'SMultiples'))
#points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"2",'Mix'))

#task 4
points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"4",'Animation'))
points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"4",'Overlaid'))
points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"4",'SMultiples'))
#points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"4",'Mix'))

#task 5
points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"5",'Animation'))
points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"5",'Overlaid'))
points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"5",'SMultiples'))
#points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"5",'Mix'))

#task 6
points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"6",'Animation'))
points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"6",'Overlaid'))
points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"6",'SMultiples'))
#points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"6",'Mix'))

#task 11
points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"11",'Animation'))
points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"11",'Overlaid'))
points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"11",'SMultiples'))
#points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"11",'Mix'))

#task 12
#points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"12",'Animation'))
#points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"12",'Overlaid'))
#points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"12",'SMultiples'))
#points_CIs.df <- rbind(points_CIs.df,pointsCI(task.df,"12",'Mix'))

points_CIs.df$VisModeID <- revalue(points_CIs.df$VisModeID, c("Animation" = "A",
                                                              "Overlaid" = "O",
                                                              "SMultiples" = "S"
                                                              #"Mix" = "M"
))

points_CIs.df$TaskID <- revalue(points_CIs.df$TaskID, c("1" = "Task 1",
                                                        "2" = "Task 2",
                                                        "4" = "Task 4",
                                                        "5" = "Task 5",
                                                        "6" = "Task 6",
                                                        "11" = "Task 11"
                                                        #"12" = "Task 12"
))

#points_CIs.df$VisModeID <- ordered(points_CIs.df$VisModeID, levels = c('M','S','O','A'))
points_CIs.df$VisModeID <- ordered(points_CIs.df$VisModeID, levels = c('A','O','S'))

plot_points_CI2 <- dualChart(points_CIs.df,ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
#ggsave(plot = plot_points_CI2, filename = "plot_points_CI2.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_points_CI2_1 <- gridChart(points_CIs.df,'Task 1',ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_points_CI2_1, filename = "plot_points_CI2_1.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_points_CI2_2 <- gridChart(points_CIs.df,'Task 2',ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_points_CI2_2, filename = "plot_points_CI2_2.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_points_CI2_4 <- gridChart(points_CIs.df,'Task 4',ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_points_CI2_4, filename = "plot_points_CI2_4.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_points_CI2_5 <- gridChart(points_CIs.df,'Task 5',ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_points_CI2_5, filename = "plot_points_CI2_5.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_points_CI2_6 <- gridChart(points_CIs.df,'Task 6',ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_points_CI2_6, filename = "plot_points_CI2_6.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_points_CI2_11 <- gridChart(points_CIs.df,'Task 11',ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_points_CI2_11, filename = "plot_points_CI2_11.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)