source('pointsCIs.R')

#Vis
task_points.df <- rbind(task.df[task.df$TaskID=="1",],
                        task.df[task.df$TaskID=="2",],
                        task.df[task.df$TaskID=="4",],
                        task.df[task.df$TaskID=="5",],
                        task.df[task.df$TaskID=="6",],
                        task.df[task.df$TaskID=="11",])

points_CIs_vis.df <- pointsCI(task_points.df,"Visualization",'Animation')
points_CIs_vis.df <- rbind(points_CIs_vis.df,pointsCI(task_points.df,"Visualization",'Overlaid'))
points_CIs_vis.df <- rbind(points_CIs_vis.df,pointsCI(task_points.df,"Visualization",'SMultiples'))
#points_CIs_vis.df <- rbind(points_CIs_vis.df,pointsCI(task_points.df,"Visualization",'Mix'))
remove(task_points.df)

points_CIs_vis.df$VisModeID <- revalue(points_CIs_vis.df$VisModeID, c("Animation" = "A",
                                                              "Overlaid" = "O",
                                                              "SMultiples" = "S"
                                                              #"Mix" = "M"
))


#points_CIs_vis.df$VisModeID <- ordered(points_CIs_vis.df$VisModeID, levels = c('M','S','O','A'))
points_CIs_vis.df$VisModeID <- ordered(points_CIs_vis.df$VisModeID, levels = c('A','O','S'))

plot_points_CI2_Vis <- dualChart(points_CIs_vis.df,ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_points_CI2_Vis, filename = "plot_points_CI2_Vis.png", devi="png", width = 3.75, height = 2.25, units = "in", dpi = 300)
