source("timingDiffCIs.R")

##Characteristic
#CompareDim
task_CompareDim.df <- rbind(task.df[task.df$TaskID == 1,],task.df[task.df$TaskID == 6,])

timing_diff_CIs_CompareDim.df <- timing_diffCI(task_CompareDim.df)
timing_diff_CIs_CompareDim.df$TaskID <- "Compare axes"
remove(task_CompareDim.df)

#LongerTrajectory
task_longerTrajectory.df <- rbind(task.df[task.df$TaskID == 5,],task.df[task.df$TaskID == 11,])

timing_diff_CIs_LongerTrajectory.df <- timing_diffCI(task_longerTrajectory.df)
timing_diff_CIs_LongerTrajectory.df$TaskID <- "Longer trajectory"
remove(task_longerTrajectory.df)

#StrictCompare
task_strictCompare.df <- rbind(task.df[task.df$TaskID == 3,],task.df[task.df$TaskID == 8,],task.df[task.df$TaskID == 9,])

timing_diff_CIs_StrictCompare.df <- timing_diffCI(task_strictCompare.df)
timing_diff_CIs_StrictCompare.df$TaskID <- "Strict compare"
remove(task_strictCompare.df)

#Reversals
task_reversals.df <- rbind(task.df[task.df$TaskID == 4,],task.df[task.df$TaskID == 7,])

timing_diff_CIs_Reversals.df <- timing_diffCI(task_reversals.df)
timing_diff_CIs_Reversals.df$TaskID <- "Reversals"
remove(task_reversals.df)

#OverlaidPoints
task_overlaidPoints.df <- task.df[task.df$TaskID == 2,]

timing_diff_CIs_OverlaidPoints.df <- timing_diffCI(task_overlaidPoints.df)
timing_diff_CIs_OverlaidPoints.df$TaskID <- "Overlaid Points"
remove(task_overlaidPoints.df)

#SimilarChanges
task_similarChanges.df <- task.df[task.df$TaskID == 10,]

timing_diff_CIs_SimilarChanges.df <- timing_diffCI(task_similarChanges.df)
timing_diff_CIs_SimilarChanges.df$TaskID <- "Similar Changes"
remove(task_similarChanges.df)

#Placement
task_placement.df <- task.df[task.df$TaskID == 12,]

timing_diff_CIs_Placement.df <- timing_diffCI(task_placement.df)
timing_diff_CIs_Placement.df$TaskID <- "Placement"
remove(task_placement.df)


timing_diff_CIs_characteristic.df <- rbind( timing_diff_CIs_CompareDim.df,
                                            timing_diff_CIs_LongerTrajectory.df,
                                            timing_diff_CIs_StrictCompare.df,
                                            timing_diff_CIs_Reversals.df,
                                            timing_diff_CIs_OverlaidPoints.df,
                                            timing_diff_CIs_SimilarChanges.df,
                                            timing_diff_CIs_Placement.df)


plot_timing_diff_CI2_Characteristic <- dualChart(timing_diff_CIs_characteristic.df,ymin = 0,ymax = 4,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 1,percentScale=F)
