source('accuracy_diffCI.R')

##Axes
#1D
task_1D_axes.df <- rbind(task.df[task.df$TaskID == 2,],task.df[task.df$TaskID == 4,])
task_1D_axes.df <- rbind(task_1D_axes.df,task.df[task.df$TaskID == 5,])
#task_1D_axes.df <- rbind(task_1D_axes.df,task.df[task.df$TaskID == 12,])

propDiff_CIs_axes_1D.df <- propDiffCI(task_1D_axes.df,"Visualization")
propDiff_CIs_axes_1D.df$TaskID <- "1D"

#2D
task_2D_axes.df <- rbind(task.df[task.df$TaskID == 1,],task.df[task.df$TaskID == 3,])
task_2D_axes.df <- rbind(task_2D_axes.df,task.df[task.df$TaskID == 6,])
task_2D_axes.df <- rbind(task_2D_axes.df,task.df[task.df$TaskID == 7,])
task_2D_axes.df <- rbind(task_2D_axes.df,task.df[task.df$TaskID == 8,])
task_2D_axes.df <- rbind(task_2D_axes.df,task.df[task.df$TaskID == 9,])

propDiff_CIs_axes_2D.df <- propDiffCI(task_2D_axes.df,"Visualization")
propDiff_CIs_axes_2D.df$TaskID <- "2D"

#3D
task_3D_axes.df <- rbind(task.df[task.df$TaskID == 10,],task.df[task.df$TaskID == 11,])

propDiff_CIs_axes_3D.df <- propDiffCI(task_3D_axes.df,"Visualization")
propDiff_CIs_axes_3D.df$TaskID <- "3D"

propDiff_CIs_axes.df <- rbind(propDiff_CIs_axes_1D.df, propDiff_CIs_axes_2D.df, propDiff_CIs_axes_3D.df)

remove(task_1D_axes.df)
remove(task_2D_axes.df)
remove(task_3D_axes.df)


plot_propDiff_CI2_Axes <- dualChart2(propDiff_CIs_axes.df,ymin = -.5,ymax = .5,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_propDiff_CI2_Axes, filename = "plot_propDiff_CI2_Axes.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)