source("timingCIs.R")

##Axes
#1D
task_1D_axes.df <- rbind(task.df[task.df$TaskID == 2,],task.df[task.df$TaskID == 4,])
task_1D_axes.df <- rbind(task_1D_axes.df,task.df[task.df$TaskID == 5,])
#task_1D_axes.df <- rbind(task_1D_axes.df,task.df[task.df$TaskID == 12,])

timing_CIs_axes_1D.df <-  timingCI_Vis(task_1D_axes.df,'Animation')
timing_CIs_axes_1D.df <- rbind(timing_CIs_axes_1D.df,timingCI_Vis(task_1D_axes.df,'Overlaid'))
timing_CIs_axes_1D.df <- rbind(timing_CIs_axes_1D.df,timingCI_Vis(task_1D_axes.df,'SMultiples'))
#timing_CIs_axes_1D.df <- rbind(timing_CIs_axes_1D.df,timingCI_Vis(task_1D_axes.df,'Mix'))
timing_CIs_axes_1D.df$TaskID <- "1D"
remove(task_1D_axes.df)

#2D
task_2D_axes.df <- rbind(task.df[task.df$TaskID == 1,],task.df[task.df$TaskID == 3,])
task_2D_axes.df <- rbind(task_2D_axes.df,task.df[task.df$TaskID == 6,])
task_2D_axes.df <- rbind(task_2D_axes.df,task.df[task.df$TaskID == 7,])
task_2D_axes.df <- rbind(task_2D_axes.df,task.df[task.df$TaskID == 8,])
task_2D_axes.df <- rbind(task_2D_axes.df,task.df[task.df$TaskID == 9,])

timing_CIs_axes_2D.df <-  timingCI_Vis(task_2D_axes.df,'Animation')
timing_CIs_axes_2D.df <- rbind(timing_CIs_axes_2D.df,timingCI_Vis(task_2D_axes.df,'Overlaid'))
timing_CIs_axes_2D.df <- rbind(timing_CIs_axes_2D.df,timingCI_Vis(task_2D_axes.df,'SMultiples'))
#timing_CIs_axes_2D.df <- rbind(timing_CIs_axes_2D.df,timingCI_Vis(task_2D_axes.df,'Mix'))
timing_CIs_axes_2D.df$TaskID <- "2D"
remove(task_2D_axes.df)

#3D
task_3D_axes.df <- rbind(task.df[task.df$TaskID == 10,],task.df[task.df$TaskID == 11,])

timing_CIs_axes_3D.df <-  timingCI_Vis(task_3D_axes.df,'Animation')
timing_CIs_axes_3D.df <- rbind(timing_CIs_axes_3D.df,timingCI_Vis(task_3D_axes.df,'Overlaid'))
timing_CIs_axes_3D.df <- rbind(timing_CIs_axes_3D.df,timingCI_Vis(task_3D_axes.df,'SMultiples'))
#timing_CIs_axes_3D.df <- rbind(timing_CIs_axes_3D.df,timingCI_Vis(task_3D_axes.df,'Mix'))
timing_CIs_axes_3D.df$TaskID <- "3D"
remove(task_3D_axes.df)

timing_CIs_axes.df <- rbind(timing_CIs_axes_1D.df,timing_CIs_axes_2D.df,timing_CIs_axes_3D.df)

#timing_CIs_axes.df$VisModeID <- ordered(timing_CIs_axes.df$VisModeID, levels = c('Animation','Overlaid','SMultiples','Mix'))
timing_CIs_axes.df$VisModeID <- ordered(timing_CIs_axes.df$VisModeID, levels = c('Animation','Overlaid','SMultiples'))

timing_CIs_axes.df$VisModeID <- revalue(timing_CIs_axes.df$VisModeID, c("Animation" = "A",
                                                              "Overlaid" = "O",
                                                              "SMultiples" = "S"
                                                              #"Mix" = "M"
))

plot_timing_CI2_axes <- dualChart(timing_CIs_axes.df,ymin = 0,ymax = 180,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -30,percentScale=F)
ggsave(plot = plot_timing_CI2_axes, filename = "plot_timing_CI2_axes.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)