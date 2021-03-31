source('accuracy_diffCI.R')

##Characteristic
#CompareDim
task_CompareDim.df <- rbind(task.df[task.df$TaskID == 1,],task.df[task.df$TaskID == 6,])

propDiff_CIs_CompareDim.df <- propDiffCI(task_CompareDim.df,"Visualization")
propDiff_CIs_CompareDim.df$TaskID <- "Compare axes"
remove(task_CompareDim.df)

#LongerTrajectory
task_longerTrajectory.df <- rbind(task.df[task.df$TaskID == 5,],task.df[task.df$TaskID == 11,])

propDiff_CIs_LongerTrajectory.df <- propDiffCI(task_longerTrajectory.df,"Visualization")
propDiff_CIs_LongerTrajectory.df$TaskID <- "Longer trajectory"
remove(task_longerTrajectory.df)

#StrictCompare
task_strictCompare.df <- rbind(task.df[task.df$TaskID == 3,],task.df[task.df$TaskID == 8,],task.df[task.df$TaskID == 9,])

propDiff_CIs_StrictCompare.df <- propDiffCI(task_strictCompare.df,"Visualization")
propDiff_CIs_StrictCompare.df$TaskID <- "Strict compare"
remove(task_strictCompare.df)

#Reversals
task_reversals.df <- rbind(task.df[task.df$TaskID == 4,],task.df[task.df$TaskID == 7,])

propDiff_CIs_Reversals.df <- propDiffCI(task_reversals.df,"Visualization")
propDiff_CIs_Reversals.df$TaskID <- "Reversals"
remove(task_reversals.df)

#OverlaidPoints
task_overlaidPoints.df <- task.df[task.df$TaskID == 2,]

propDiff_CIs_OverlaidPoints.df <- propDiffCI(task_overlaidPoints.df,"Visualization")
propDiff_CIs_OverlaidPoints.df$TaskID <- "Overlaid Points"
remove(task_overlaidPoints.df)

#SimilarChanges
task_similarChanges.df <- task.df[task.df$TaskID == 10,]

propDiff_CIs_SimilarChanges.df <- propDiffCI(task_similarChanges.df,"Visualization")
propDiff_CIs_SimilarChanges.df$TaskID <- "Similar Changes"
remove(task_similarChanges.df)

#Placement
task_placement.df <- task.df[task.df$TaskID == 12,]

propDiff_CIs_Placement.df <- propDiffCI(task_placement.df,"Visualization")
propDiff_CIs_Placement.df$TaskID <- "Placement"
remove(task_placement.df)

propDiff_CIs_characteristic.df <- rbind(propDiff_CIs_CompareDim.df,
                                        propDiff_CIs_LongerTrajectory.df,
                                        propDiff_CIs_StrictCompare.df,
                                        propDiff_CIs_Reversals.df,
                                        propDiff_CIs_OverlaidPoints.df,
                                        propDiff_CIs_SimilarChanges.df,
                                        propDiff_CIs_Placement.df)


plot_propDiff_CI2_Characteristic <- dualChart(propDiff_CIs_characteristic.df,ymin = -1.2,ymax = 1.2,yAxisLabel = "",xAxisLabel = "",displayXLabels = T,displayYLabels = T,vLineVal = 0,percentScale=T)
