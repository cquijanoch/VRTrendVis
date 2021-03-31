source("timingCIs.R")

##Characteristic
#CompareDim
task_CompareDim.df <- rbind(task.df[task.df$TaskID == 1,],task.df[task.df$TaskID == 6,])

timing_CIs_compareDim.df <-  timingCI_Vis(task_CompareDim.df,'Animation')
timing_CIs_compareDim.df <- rbind(timing_CIs_compareDim.df,timingCI_Vis(task_CompareDim.df,'Overlaid'))
timing_CIs_compareDim.df <- rbind(timing_CIs_compareDim.df,timingCI_Vis(task_CompareDim.df,'SMultiples'))
timing_CIs_compareDim.df <- rbind(timing_CIs_compareDim.df,timingCI_Vis(task_CompareDim.df,'Mix'))
timing_CIs_compareDim.df$TaskID <- "Compare axes"
remove(task_CompareDim.df)

#LongerTrajectory
task_longerTrajectory.df <- rbind(task.df[task.df$TaskID == 5,],task.df[task.df$TaskID == 11,])

timing_CIs_longerTrajectory.df <-  timingCI_Vis(task_longerTrajectory.df,'Animation')
timing_CIs_longerTrajectory.df <- rbind(timing_CIs_longerTrajectory.df,timingCI_Vis(task_longerTrajectory.df,'Overlaid'))
timing_CIs_longerTrajectory.df <- rbind(timing_CIs_longerTrajectory.df,timingCI_Vis(task_longerTrajectory.df,'SMultiples'))
timing_CIs_longerTrajectory.df <- rbind(timing_CIs_longerTrajectory.df,timingCI_Vis(task_longerTrajectory.df,'Mix'))
timing_CIs_longerTrajectory.df$TaskID <- "Longer trajectory"
remove(task_longerTrajectory.df)

#StrictCompare
task_strictCompare.df <- rbind(task.df[task.df$TaskID == 3,],task.df[task.df$TaskID == 8,],task.df[task.df$TaskID == 9,])

timing_CIs_strictCompare.df <-  timingCI_Vis(task_strictCompare.df,'Animation')
timing_CIs_strictCompare.df <- rbind(timing_CIs_strictCompare.df,timingCI_Vis(task_strictCompare.df,'Overlaid'))
timing_CIs_strictCompare.df <- rbind(timing_CIs_strictCompare.df,timingCI_Vis(task_strictCompare.df,'SMultiples'))
timing_CIs_strictCompare.df <- rbind(timing_CIs_strictCompare.df,timingCI_Vis(task_strictCompare.df,'Mix'))
timing_CIs_strictCompare.df$TaskID <- "Strict compare"
remove(task_strictCompare.df)

#Reversals
task_reversals.df <- rbind(task.df[task.df$TaskID == 4,],task.df[task.df$TaskID == 7,])

timing_CIs_reversals.df <-  timingCI_Vis(task_reversals.df,'Animation')
timing_CIs_reversals.df <- rbind(timing_CIs_reversals.df,timingCI_Vis(task_reversals.df,'Overlaid'))
timing_CIs_reversals.df <- rbind(timing_CIs_reversals.df,timingCI_Vis(task_reversals.df,'SMultiples'))
timing_CIs_reversals.df <- rbind(timing_CIs_reversals.df,timingCI_Vis(task_reversals.df,'Mix'))
timing_CIs_reversals.df$TaskID <- "Reversals"
remove(task_reversals.df)

#OverlaidPoints
task_overlaidPoints.df <- task.df[task.df$TaskID == 2,]

timing_CIs_overlaidPoints.df <-  timingCI_Vis(task_overlaidPoints.df,'Animation')
timing_CIs_overlaidPoints.df <- rbind(timing_CIs_overlaidPoints.df,timingCI_Vis(task_overlaidPoints.df,'Overlaid'))
timing_CIs_overlaidPoints.df <- rbind(timing_CIs_overlaidPoints.df,timingCI_Vis(task_overlaidPoints.df,'SMultiples'))
timing_CIs_overlaidPoints.df <- rbind(timing_CIs_overlaidPoints.df,timingCI_Vis(task_overlaidPoints.df,'Mix'))
timing_CIs_overlaidPoints.df$TaskID <- "Overlaid Points"
remove(task_overlaidPoints.df)

#SimilarChanges
task_similarChanges.df <- task.df[task.df$TaskID == 10,]

timing_CIs_similarChanges.df <-  timingCI_Vis(task_similarChanges.df,'Animation')
timing_CIs_similarChanges.df <- rbind(timing_CIs_similarChanges.df,timingCI_Vis(task_similarChanges.df,'Overlaid'))
timing_CIs_similarChanges.df <- rbind(timing_CIs_similarChanges.df,timingCI_Vis(task_similarChanges.df,'SMultiples'))
timing_CIs_similarChanges.df <- rbind(timing_CIs_similarChanges.df,timingCI_Vis(task_similarChanges.df,'Mix'))
timing_CIs_similarChanges.df$TaskID <- "Similar Changes"
remove(task_similarChanges.df)

#Placement
task_placement.df <- task.df[task.df$TaskID == 12,]

timing_CIs_placement.df <-  timingCI_Vis(task_placement.df,'Animation')
timing_CIs_placement.df <- rbind(timing_CIs_placement.df,timingCI_Vis(task_placement.df,'Overlaid'))
timing_CIs_placement.df <- rbind(timing_CIs_placement.df,timingCI_Vis(task_placement.df,'SMultiples'))
timing_CIs_placement.df <- rbind(timing_CIs_placement.df,timingCI_Vis(task_placement.df,'Mix'))
timing_CIs_placement.df$TaskID <- "Placement"
remove(task_placement.df)


timing_CIs_characteristic.df <- rbind(  timing_CIs_compareDim.df,
                                        timing_CIs_longerTrajectory.df,
                                        timing_CIs_strictCompare.df,
                                        timing_CIs_reversals.df,
                                        timing_CIs_overlaidPoints.df,
                                        timing_CIs_similarChanges.df,
                                        timing_CIs_placement.df)

timing_CIs_characteristic.df$VisModeID <- ordered(timing_CIs_characteristic.df$VisModeID, levels = c('Animation','Overlaid','SMultiples','Mix'))

timing_CIs_characteristic.df$VisModeID <- revalue(timing_CIs_characteristic.df$VisModeID, c("Animation" = "A",
                                                              "Overlaid" = "O",
                                                              "SMultiples" = "S",
                                                              "Mix" = "M"
))

plot_timing_CI2_Characterisitc <- dualChart(timing_CIs_characteristic.df,ymin = -0.5,ymax = 4,yAxisLabel = "",xAxisLabel = "",displayXLabels = T,displayYLabels = T,vLineVal = -30,percentScale=F)
