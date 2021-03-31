source("accuracyCIs.R")

##Characteristic
#CompareDim
task_CompareDim.df <- rbind(task.df[task.df$TaskID == 1,],task.df[task.df$TaskID == 6,])

accuracy_CIs_CompareDim.df <- accuracyCI(task_CompareDim.df,"Visualization",'Animation')
accuracy_CIs_CompareDim.df <- rbind(accuracy_CIs_CompareDim.df,accuracyCI(task_CompareDim.df,"Visualization",'Overlaid'))
accuracy_CIs_CompareDim.df <- rbind(accuracy_CIs_CompareDim.df,accuracyCI(task_CompareDim.df,"Visualization",'SMultiples'))
accuracy_CIs_CompareDim.df <- rbind(accuracy_CIs_CompareDim.df,accuracyCI(task_CompareDim.df,"Visualization",'Mix'))
accuracy_CIs_CompareDim.df$TaskID <- "Compare axes"
remove(task_CompareDim.df)

#LongerTrajectory
task_longerTrajectory.df <- rbind(task.df[task.df$TaskID == 5,],task.df[task.df$TaskID == 11,])

accuracy_CIs_LongerTrajectory.df <- accuracyCI(task_longerTrajectory.df,"Visualization",'Animation')
accuracy_CIs_LongerTrajectory.df <- rbind(accuracy_CIs_LongerTrajectory.df,accuracyCI(task_longerTrajectory.df,"Visualization",'Overlaid'))
accuracy_CIs_LongerTrajectory.df <- rbind(accuracy_CIs_LongerTrajectory.df,accuracyCI(task_longerTrajectory.df,"Visualization",'SMultiples'))
accuracy_CIs_LongerTrajectory.df <- rbind(accuracy_CIs_LongerTrajectory.df,accuracyCI(task_longerTrajectory.df,"Visualization",'Mix'))
accuracy_CIs_LongerTrajectory.df$TaskID <- "Longer trajectory"
remove(task_longerTrajectory.df)

#StrictCompare
task_strictCompare.df <- rbind(task.df[task.df$TaskID == 3,],task.df[task.df$TaskID == 8,],task.df[task.df$TaskID == 9,])

accuracy_CIs_StrictCompare.df <- accuracyCI(task_strictCompare.df,"Visualization",'Animation')
accuracy_CIs_StrictCompare.df <- rbind(accuracy_CIs_StrictCompare.df,accuracyCI(task_strictCompare.df,"Visualization",'Overlaid'))
accuracy_CIs_StrictCompare.df <- rbind(accuracy_CIs_StrictCompare.df,accuracyCI(task_strictCompare.df,"Visualization",'SMultiples'))
accuracy_CIs_StrictCompare.df <- rbind(accuracy_CIs_StrictCompare.df,accuracyCI(task_strictCompare.df,"Visualization",'Mix'))
accuracy_CIs_StrictCompare.df$TaskID <- "Strict compare"
remove(task_strictCompare.df)

#Reversals
task_reversals.df <- rbind(task.df[task.df$TaskID == 4,],task.df[task.df$TaskID == 7,])

accuracy_CIs_Reversals.df <- accuracyCI(task_reversals.df,"Visualization",'Animation')
accuracy_CIs_Reversals.df <- rbind(accuracy_CIs_Reversals.df,accuracyCI(task_reversals.df,"Visualization",'Overlaid'))
accuracy_CIs_Reversals.df <- rbind(accuracy_CIs_Reversals.df,accuracyCI(task_reversals.df,"Visualization",'SMultiples'))
accuracy_CIs_Reversals.df <- rbind(accuracy_CIs_Reversals.df,accuracyCI(task_reversals.df,"Visualization",'Mix'))
accuracy_CIs_Reversals.df$TaskID <- "Reversals"
remove(task_reversals.df)

#OverlaidPoints
task_overlaidPoints.df <- task.df[task.df$TaskID == 2,]

accuracy_CIs_OverlaidPoints.df <- accuracyCI(task_overlaidPoints.df,"Visualization",'Animation')
accuracy_CIs_OverlaidPoints.df <- rbind(accuracy_CIs_OverlaidPoints.df,accuracyCI(task_overlaidPoints.df,"Visualization",'Overlaid'))
accuracy_CIs_OverlaidPoints.df <- rbind(accuracy_CIs_OverlaidPoints.df,accuracyCI(task_overlaidPoints.df,"Visualization",'SMultiples'))
accuracy_CIs_OverlaidPoints.df <- rbind(accuracy_CIs_OverlaidPoints.df,accuracyCI(task_overlaidPoints.df,"Visualization",'Mix'))
accuracy_CIs_OverlaidPoints.df$TaskID <- "Overlaid Points"
remove(task_overlaidPoints.df)

#SimilarChanges
task_similarChanges.df <- task.df[task.df$TaskID == 10,]

accuracy_CIs_SimilarChanges.df <- accuracyCI(task_similarChanges.df,"Visualization",'Animation')
accuracy_CIs_SimilarChanges.df <- rbind(accuracy_CIs_SimilarChanges.df,accuracyCI(task_similarChanges.df,"Visualization",'Overlaid'))
accuracy_CIs_SimilarChanges.df <- rbind(accuracy_CIs_SimilarChanges.df,accuracyCI(task_similarChanges.df,"Visualization",'SMultiples'))
accuracy_CIs_SimilarChanges.df <- rbind(accuracy_CIs_SimilarChanges.df,accuracyCI(task_similarChanges.df,"Visualization",'Mix'))
accuracy_CIs_SimilarChanges.df$TaskID <- "Similar Changes"
remove(task_similarChanges.df)

#Placement
task_placement.df <- task.df[task.df$TaskID == 12,]

accuracy_CIs_Placement.df <- accuracyCI(task_placement.df,"Visualization",'Animation')
accuracy_CIs_Placement.df <- rbind(accuracy_CIs_Placement.df,accuracyCI(task_placement.df,"Visualization",'Overlaid'))
accuracy_CIs_Placement.df <- rbind(accuracy_CIs_Placement.df,accuracyCI(task_placement.df,"Visualization",'SMultiples'))
accuracy_CIs_Placement.df <- rbind(accuracy_CIs_Placement.df,accuracyCI(task_placement.df,"Visualization",'Mix'))
accuracy_CIs_Placement.df$TaskID <- "Placement"
remove(task_placement.df)

accuracy_CIs_characteristic.df <- rbind(accuracy_CIs_CompareDim.df,
                                        accuracy_CIs_LongerTrajectory.df,
                                        accuracy_CIs_StrictCompare.df,
                                        accuracy_CIs_Reversals.df,
                                        accuracy_CIs_OverlaidPoints.df,
                                        accuracy_CIs_SimilarChanges.df,
                                        accuracy_CIs_Placement.df)

accuracy_CIs_characteristic.df$VisModeID <- ordered(accuracy_CIs_characteristic.df$VisModeID, levels = c('Mix','SMultiples','Overlaid','Animation'))
accuracy_CIs_characteristic.df$VisModeID <- revalue(accuracy_CIs_characteristic.df$VisModeID, c("Animation" = "A",
                                                                    "Overlaid" = "O",
                                                                    "SMultiples" = "S",
                                                                    "Mix" = "M"
))


plot_accuracy_CI2_Characterisitic <- dualChart(accuracy_CIs_characteristic.df,ymin = -0.1,ymax = 1.1,yAxisLabel = "",xAxisLabel = "",displayXLabels = T,displayYLabels = T,vLineVal = -1,percentScale=T)
