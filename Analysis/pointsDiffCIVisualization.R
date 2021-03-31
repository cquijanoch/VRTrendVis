source('pointsDiffCI.R')

##Vis
trial_test_by_vis.df <- rbind(     task.df[task.df$TaskID=="1",], task.df[task.df$TaskID=="2",], task.df[task.df$TaskID=="4",],
                                task.df[task.df$TaskID=="5",], task.df[task.df$TaskID=="6",],task.df[task.df$TaskID=="11",])
trial_test_by_vis.df <- bootdif(trial_test_by_vis.df)       
trial_test_by_vis.df$TaskID <- "Visualization"                     


plot_pointDiffCI2_Vis <- dualChart(trial_test_by_vis.df,ymin = -1,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_pointDiffCI2_Vis, filename = "plot_pointDiffCI2_Vis.png", devi="png", width = 3.75, height = 2.25, units = "in", dpi = 300)