source('pointsCIs.R')

##Axes
#1D
task_points_1D.df <- rbind(task.df[task.df$TaskID=="2",],
                        task.df[task.df$TaskID=="4",],
                        task.df[task.df$TaskID=="5",])

points_CIs_axes_1D.df <- pointsCI(task_points_1D.df,"Visualization",'Animation')
points_CIs_axes_1D.df <- rbind(points_CIs_axes_1D.df,pointsCI(task_points_1D.df,"Visualization",'Overlaid'))
points_CIs_axes_1D.df <- rbind(points_CIs_axes_1D.df,pointsCI(task_points_1D.df,"Visualization",'SMultiples'))
#points_CIs_axes_1D.df <- rbind(points_CIs_axes_1D.df,pointsCI(task_points_1D.df,"Visualization",'Mix'))
points_CIs_axes_1D.df$TaskID <- "1D"
remove(task_points_1D.df)

#2D
task_points_2D.df <- rbind(task.df[task.df$TaskID=="1",],
                        task.df[task.df$TaskID=="6",])

points_CIs_axes_2D.df <- pointsCI(task_points_2D.df,"Visualization",'Animation')
points_CIs_axes_2D.df <- rbind(points_CIs_axes_2D.df,pointsCI(task_points_2D.df,"Visualization",'Overlaid'))
points_CIs_axes_2D.df <- rbind(points_CIs_axes_2D.df,pointsCI(task_points_2D.df,"Visualization",'SMultiples'))
#points_CIs_axes_2D.df <- rbind(points_CIs_axes_2D.df,pointsCI(task_points_2D.df,"Visualization",'Mix'))
points_CIs_axes_2D.df$TaskID <- "2D"
remove(task_points_2D.df)

#3D
task_points_3D.df <- rbind(task.df[task.df$TaskID=="11",])

points_CIs_axes_3D.df <- pointsCI(task_points_3D.df,"Visualization",'Animation')
points_CIs_axes_3D.df <- rbind(points_CIs_axes_3D.df,pointsCI(task_points_3D.df,"Visualization",'Overlaid'))
points_CIs_axes_3D.df <- rbind(points_CIs_axes_3D.df,pointsCI(task_points_3D.df,"Visualization",'SMultiples'))
#points_CIs_axes_3D.df <- rbind(points_CIs_axes_3D.df,pointsCI(task_points_3D.df,"Visualization",'Mix'))
points_CIs_axes_3D.df$TaskID <- "3D"
remove(task_points_3D.df)

points_CIs_axes.df <- rbind(points_CIs_axes_1D.df, points_CIs_axes_2D.df, points_CIs_axes_3D.df)

points_CIs_axes.df$VisModeID <- revalue(points_CIs_axes.df$VisModeID, c("Animation" = "A",
                                                              "Overlaid" = "O",
                                                              "SMultiples" = "S"
                                                              #"Mix" = "M"
))

#points_CIs_axes.df$VisModeID <- ordered(points_CIs_axes.df$VisModeID, levels = c('M','S','O','A'))
points_CIs_axes.df$VisModeID <- ordered(points_CIs_axes.df$VisModeID, levels = c('A','O','S'))

plot_points_CI2_Axes <- dualChart(points_CIs_axes.df,ymin = 0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_points_CI2_Axes, filename = "plot_points_CI2_Axes.png", devi="png", width = 3.75, height = 2.25, units = "in", dpi = 300)