source("accuracyCIs.R")

#Vis
accuracy_CIs_vis.df <- accuracyCI(task.df[task.df$TaskID != "12",],"Visualization",'Animation')
accuracy_CIs_vis.df <- rbind(accuracy_CIs_vis.df,accuracyCI(task.df[task.df$TaskID != "12",],"Visualization",'Overlaid'))
accuracy_CIs_vis.df <- rbind(accuracy_CIs_vis.df,accuracyCI(task.df[task.df$TaskID != "12",],"Visualization",'SMultiples'))
#accuracy_CIs_vis.df <- rbind(accuracy_CIs_vis.df,accuracyCI(task.df,"Visualization",'Mix'))

#accuracy_CIs_vis.df$VisModeID <- ordered(accuracy_CIs_vis.df$VisModeID, levels = c('Mix','SMultiples','Overlaid','Animation'))
accuracy_CIs_vis.df$VisModeID <- ordered(accuracy_CIs_vis.df$VisModeID, levels = c('SMultiples','Overlaid','Animation'))
accuracy_CIs_vis.df$VisModeID <- revalue(accuracy_CIs_vis.df$VisModeID, c("Animation" = "A",
                                                                    "Overlaid" = "O",
                                                                    "SMultiples" = "S"
                                                                    #"Mix" = "M"
))

accuracy_CIs_vis.df$VisModeID <- ordered(accuracy_CIs_vis.df$VisModeID, levels = c('A','O','S'))
plot_accuracy_CI2_Vis <- dualChart(accuracy_CIs_vis.df,ymin = 0.0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_accuracy_CI2_Vis, filename = "plot_accuracy_CI2_Vis.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)