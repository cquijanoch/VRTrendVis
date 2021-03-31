source('accuracy_diffCI.R')

#Vis
propDiff_CIs_vis.df <- BpropDiffCI(task.df[task.df$TaskID != "12",],"Visualization")

plot_propDiff_CI2_Vis <- dualChart(propDiff_CIs_vis.df,ymin = -.5,ymax = .5,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_propDiff_CI2_Vis, filename = "plot_propDiff_CI2_Vis.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)