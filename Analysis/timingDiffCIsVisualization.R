source("timingDiffCIs.R")

#Vis
timing_diff_CIs_vis.df <- timing_diffCI(task.df[task.df$TaskID != "12",])

plot_timing_diff_CI2_Vis <- dualChart(timing_diff_CIs_vis.df,ymin = 0,ymax = 2,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 1,percentScale=F)
ggsave(plot = plot_timing_diff_CI2_Vis, filename = "plot_timing_diff_CI2_Vis.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)