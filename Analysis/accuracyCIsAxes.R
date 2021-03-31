source("accuracyCIs.R")

##Axes
#1D
task_1D_axes.df <- rbind(task.df[task.df$TaskID == 2,],task.df[task.df$TaskID == 4,])
task_1D_axes.df <- rbind(task_1D_axes.df,task.df[task.df$TaskID == 5,])
#task_1D_axes.df <- rbind(task_1D_axes.df,task.df[task.df$TaskID == 12,])

accuracy_CIs_axes_1D.df <- accuracyCI(task_1D_axes.df,"Visualization",'Animation')
accuracy_CIs_axes_1D.df <- rbind(accuracy_CIs_axes_1D.df,accuracyCI(task_1D_axes.df,"Visualization",'Overlaid'))
accuracy_CIs_axes_1D.df <- rbind(accuracy_CIs_axes_1D.df,accuracyCI(task_1D_axes.df,"Visualization",'SMultiples'))
#accuracy_CIs_axes_1D.df <- rbind(accuracy_CIs_axes_1D.df,accuracyCI(task_1D_axes.df,"Visualization",'Mix'))
accuracy_CIs_axes_1D.df$TaskID <- "1D"

#2D
task_2D_axes.df <- rbind(task.df[task.df$TaskID == 1,],task.df[task.df$TaskID == 3,])
task_2D_axes.df <- rbind(task_2D_axes.df,task.df[task.df$TaskID == 6,])
task_2D_axes.df <- rbind(task_2D_axes.df,task.df[task.df$TaskID == 7,])
task_2D_axes.df <- rbind(task_2D_axes.df,task.df[task.df$TaskID == 8,])
task_2D_axes.df <- rbind(task_2D_axes.df,task.df[task.df$TaskID == 9,])

accuracy_CIs_axes_2D.df <- accuracyCI(task_2D_axes.df,"Visualization",'Animation')
accuracy_CIs_axes_2D.df <- rbind(accuracy_CIs_axes_2D.df,accuracyCI(task_2D_axes.df,"Visualization",'Overlaid'))
accuracy_CIs_axes_2D.df <- rbind(accuracy_CIs_axes_2D.df,accuracyCI(task_2D_axes.df,"Visualization",'SMultiples'))
#accuracy_CIs_axes_2D.df <- rbind(accuracy_CIs_axes_2D.df,accuracyCI(task_2D_axes.df,"Visualization",'Mix'))
accuracy_CIs_axes_2D.df$TaskID <- "2D"

#3D
task_3D_axes.df <- rbind(task.df[task.df$TaskID == 10,],task.df[task.df$TaskID == 11,])

accuracy_CIs_axes_3D.df <- accuracyCI(task_3D_axes.df,"Visualization",'Animation')
accuracy_CIs_axes_3D.df <- rbind(accuracy_CIs_axes_3D.df,accuracyCI(task_3D_axes.df,"Visualization",'Overlaid'))
accuracy_CIs_axes_3D.df <- rbind(accuracy_CIs_axes_3D.df,accuracyCI(task_3D_axes.df,"Visualization",'SMultiples'))
#accuracy_CIs_axes_3D.df <- rbind(accuracy_CIs_axes_3D.df,accuracyCI(task_3D_axes.df,"Visualization",'Mix'))
accuracy_CIs_axes_3D.df$TaskID <- "3D"

accuracy_CIs_axes.df <- rbind(accuracy_CIs_axes_1D.df, accuracy_CIs_axes_2D.df, accuracy_CIs_axes_3D.df)

remove(task_1D_axes.df)
remove(task_2D_axes.df)
remove(task_3D_axes.df)

#accuracy_CIs_axes.df$VisModeID <- ordered(accuracy_CIs_axes.df$VisModeID, levels = c('Mix','SMultiples','Overlaid','Animation'))
accuracy_CIs_axes.df$VisModeID <- ordered(accuracy_CIs_axes.df$VisModeID, levels = c('SMultiples','Overlaid','Animation'))
accuracy_CIs_axes.df$VisModeID <- revalue(accuracy_CIs_axes.df$VisModeID, c("Animation" = "A",
                                                                    "Overlaid" = "O",
                                                                    "SMultiples" = "S"
                                                                    #"Mix" = "M"
))

accuracy_CIs_axes.df$VisModeID <- ordered(accuracy_CIs_axes.df$VisModeID, levels = c('A','O','S'))
plot_accuracy_CI2_Axes <- dualChart(accuracy_CIs_axes.df,ymin = .0,ymax = 1,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = -1,percentScale=F)
ggsave(plot = plot_accuracy_CI2_Axes, filename = "plot_accuracy_CI2_Axes.png", devi="png", width = 3.75, height = 2.25, units = "in", dpi = 300)