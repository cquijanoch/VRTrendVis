source("timingCIs.R")

##Visualization
timing_CIs_vis.df <-  timingCI_Vis(task.df[task.df$TaskID != "12",],'Animation')
timing_CIs_vis.df <- rbind(timing_CIs_vis.df,timingCI_Vis(task.df[task.df$TaskID != "12",],'Overlaid'))
timing_CIs_vis.df <- rbind(timing_CIs_vis.df,timingCI_Vis(task.df[task.df$TaskID != "12",],'SMultiples'))
#timing_CIs_vis.df <- rbind(timing_CIs_vis.df,timingCI_Vis(task.df,'Mix'))

timing_CIs_vis.df$VisModeID <- ordered(timing_CIs_vis.df$VisModeID, levels = c('Animation','Overlaid','SMultiples'))
#timing_CIs_vis.df$VisModeID <- ordered(timing_CIs_vis.df$VisModeID, levels = c('Animation','Overlaid','SMultiples','Mix'))

timing_CIs_vis.df$VisModeID <- revalue(timing_CIs_vis.df$VisModeID, c("Animation" = "A",
                                                              "Overlaid" = "O",
                                                              "SMultiples" = "S"
                                                              #"Mix" = "M"
))

plot_timing_CI2_vis <- dualChart(timing_CIs_vis.df,ymin = -0,ymax = 180,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -30,percentScale=F)
ggsave(plot = plot_timing_CI2_vis, filename = "plot_timing_CI2_vis.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)