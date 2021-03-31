source('pointsDiffCI.R')

##Characteristic
#CompareDim
task_CompareDim.df <- rbind(task.df[task.df$TaskID == 1,],task.df[task.df$TaskID == 6,])

trial_test_by_compareDim.df <- bootdif(task_CompareDim.df)
trial_test_by_compareDim.df$TaskID <- "Compare Axes"
remove(task_CompareDim.df)

#LongerTrajectory
task_longerTrajectory.df <- rbind(task.df[task.df$TaskID == 5,],task.df[task.df$TaskID == 11,])

trial_test_by_longerTrajectory.df <- bootdif(task_longerTrajectory.df)
trial_test_by_longerTrajectory.df$TaskID <- "Longer trajectory"
remove(task_longerTrajectory.df)

#Reversals
task_reversals.df <- task.df[task.df$TaskID == 4,]

trial_test_by_reversals.df <- bootdif(task_reversals.df)
trial_test_by_reversals.df$TaskID <- "Reversals"
remove(task_reversals.df)

#OverlaidPoints
task_overlaidPoints.df <- task.df[task.df$TaskID == 2,]

trial_test_by_overlaidPoints.df <- bootdif(task_overlaidPoints.df)
trial_test_by_overlaidPoints.df$TaskID <- "Overlaid Points"
remove(task_overlaidPoints.df)

#SimilarChanges
task_similarChanges.df <- task.df[task.df$TaskID == 10,]

trial_test_by_similarChanges.df <- bootdif(task_similarChanges.df)
trial_test_by_similarChanges.df$TaskID <- "Similar Changes"
remove(task_similarChanges.df)

#Placement
task_placement.df <- task.df[task.df$TaskID == 12,]

trial_test_by_placement.df <- bootdif(task_placement.df)
trial_test_by_placement.df$TaskID <- "Placement"
remove(task_placement.df)

trial_test_by_characteristic.df <- rbind(   trial_test_by_compareDim.df,
                                            trial_test_by_longerTrajectory.df,
                                            trial_test_by_reversals.df,
                                            trial_test_by_overlaidPoints.df,
                                            trial_test_by_similarChanges.df,
                                            trial_test_by_placement.df)

plot_pointDiffCI2_Characteristic <- dualChart(trial_test_by_characteristic.df,ymin = -2,ymax = 2,yAxisLabel = "",xAxisLabel = "",displayXLabels = T,displayYLabels = T,vLineVal = 0,percentScale=T)
