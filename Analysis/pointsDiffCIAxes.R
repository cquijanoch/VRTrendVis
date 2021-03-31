source('pointsDiffCI2.R')

##Axes
#1D
task_points_1D.df <- rbind(task.df[task.df$TaskID=="2",],
                        task.df[task.df$TaskID=="4",],
                        task.df[task.df$TaskID=="5",])

trial_test_by_axes_1D.df <- bootdif(task_points_1D.df)
trial_test_by_axes_1D.df$TaskID <- "1D"
remove(task_points_1D.df)

#2D
task_points_2D.df <- rbind(task.df[task.df$TaskID=="1",],
                        task.df[task.df$TaskID=="6",])

trial_test_by_axes_2D.df <- bootdif(task_points_2D.df)
trial_test_by_axes_2D.df$TaskID <- "2D"
remove(task_points_2D.df)

#3D
task_points_3D.df <- rbind(task.df[task.df$TaskID=="11",])

trial_test_by_axes_3D.df <- bootdif(task_points_3D.df)
trial_test_by_axes_3D.df$TaskID <- "3D"
remove(task_points_3D.df)

trial_test_by_axes.df <- rbind(trial_test_by_axes_1D.df, trial_test_by_axes_2D.df, trial_test_by_axes_3D.df)

plot_pointDiffCI2_Axes <- dualChart(trial_test_by_axes.df,ymin = -1,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_pointDiffCI2_Axes, filename = "plot_pointDiffCI2_Axes.png", devi="png", width = 3.75, height = 2.25, units = "in", dpi = 300)