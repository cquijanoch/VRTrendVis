source("timingDiffCIs.R")

#Axes
#1D
task_1D_axes.df <- rbind(task.df[task.df$TaskID == 2,],task.df[task.df$TaskID == 4,])
task_1D_axes.df <- rbind(task_1D_axes.df,task.df[task.df$TaskID == 5,])
#task_1D_axes.df <- rbind(task_1D_axes.df,task.df[task.df$TaskID == 12,])

timing_diff_CIs_axes_1D.df <- timing_diffCI(task_1D_axes.df)
timing_diff_CIs_axes_1D.df$TaskID <- "1D"

#2D
task_2D_axes.df <- rbind(task.df[task.df$TaskID == 1,],task.df[task.df$TaskID == 3,])
task_2D_axes.df <- rbind(task_2D_axes.df,task.df[task.df$TaskID == 6,])
task_2D_axes.df <- rbind(task_2D_axes.df,task.df[task.df$TaskID == 7,])
task_2D_axes.df <- rbind(task_2D_axes.df,task.df[task.df$TaskID == 8,])
task_2D_axes.df <- rbind(task_2D_axes.df,task.df[task.df$TaskID == 9,])

timing_diff_CIs_axes_2D.df <- timing_diffCI(task_2D_axes.df)
timing_diff_CIs_axes_2D.df$TaskID <- "2D"

#3D
task_3D_axes.df <- rbind(task.df[task.df$TaskID == 10,],task.df[task.df$TaskID == 11,])
timing_diff_CIs_axes_3D.df <- timing_diffCI(task_3D_axes.df)
timing_diff_CIs_axes_3D.df$TaskID <- "3D"

timing_diff_CIs_axes.df <- rbind(timing_diff_CIs_axes_1D.df, timing_diff_CIs_axes_2D.df, timing_diff_CIs_axes_3D.df)

remove(task_1D_axes.df)
remove(task_2D_axes.df)
remove(task_3D_axes.df)


plot_timing_diff_CI2_axes <- dualChart(timing_diff_CIs_axes.df,ymin = 0,ymax = 2,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 1,percentScale=F)
ggsave(plot = plot_timing_diff_CI2_axes, filename = "plot_timing_diff_CI2_axes.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)