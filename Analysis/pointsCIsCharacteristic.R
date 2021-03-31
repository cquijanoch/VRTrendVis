source('pointsCIs.R')

##Characteristic
#CompareDim
task_CompareDim.df <- rbind(task.df[task.df$TaskID == 1,],task.df[task.df$TaskID == 6,])

points_CIs_compareDim.df <- pointsCI(task_CompareDim.df,"Visualization",'Animation')
points_CIs_compareDim.df <- rbind(points_CIs_compareDim.df,pointsCI(task_CompareDim.df,"Visualization",'Overlaid'))
points_CIs_compareDim.df <- rbind(points_CIs_compareDim.df,pointsCI(task_CompareDim.df,"Visualization",'SMultiples'))
points_CIs_compareDim.df <- rbind(points_CIs_compareDim.df,pointsCI(task_CompareDim.df,"Visualization",'Mix'))
points_CIs_compareDim.df$TaskID <- "Compare Axes"
remove(task_CompareDim.df)

#LongerTrajectory
task_longerTrajectory.df <- rbind(task.df[task.df$TaskID == 5,],task.df[task.df$TaskID == 11,])

points_CIs_longerTrajectory.df <- pointsCI(task_longerTrajectory.df,"Visualization",'Animation')
points_CIs_longerTrajectory.df <- rbind(points_CIs_longerTrajectory.df,pointsCI(task_longerTrajectory.df,"Visualization",'Overlaid'))
points_CIs_longerTrajectory.df <- rbind(points_CIs_longerTrajectory.df,pointsCI(task_longerTrajectory.df,"Visualization",'SMultiples'))
points_CIs_longerTrajectory.df <- rbind(points_CIs_longerTrajectory.df,pointsCI(task_longerTrajectory.df,"Visualization",'Mix'))
points_CIs_longerTrajectory.df$TaskID <- "Longer trajectory"
remove(task_longerTrajectory.df)

#Reversals
task_reversals.df <- task.df[task.df$TaskID == 4,]

points_CIs_reversals.df <- pointsCI(task_reversals.df,"Visualization",'Animation')
points_CIs_reversals.df <- rbind(points_CIs_reversals.df,pointsCI(task_reversals.df,"Visualization",'Overlaid'))
points_CIs_reversals.df <- rbind(points_CIs_reversals.df,pointsCI(task_reversals.df,"Visualization",'SMultiples'))
points_CIs_reversals.df <- rbind(points_CIs_reversals.df,pointsCI(task_reversals.df,"Visualization",'Mix'))
points_CIs_reversals.df$TaskID <- "Longer trajectory"
remove(task_reversals.df)

#OverlaidPoints
task_overlaidPoints.df <- task.df[task.df$TaskID == 2,]

points_CIs_overlaidPoints.df <- pointsCI(task_overlaidPoints.df,"Visualization",'Animation')
points_CIs_overlaidPoints.df <- rbind(points_CIs_overlaidPoints.df,pointsCI(task_overlaidPoints.df,"Visualization",'Overlaid'))
points_CIs_overlaidPoints.df <- rbind(points_CIs_overlaidPoints.df,pointsCI(task_overlaidPoints.df,"Visualization",'SMultiples'))
points_CIs_overlaidPoints.df <- rbind(points_CIs_overlaidPoints.df,pointsCI(task_overlaidPoints.df,"Visualization",'Mix'))
points_CIs_overlaidPoints.df$TaskID <- "Overlaid Points"
remove(task_overlaidPoints.df)

#SimilarChanges
task_similarChanges.df <- task.df[task.df$TaskID == 10,]

points_CIs_similarChanges.df <- pointsCI(task_similarChanges.df,"Visualization",'Animation')
points_CIs_similarChanges.df <- rbind(points_CIs_similarChanges.df,pointsCI(task_similarChanges.df,"Visualization",'Overlaid'))
points_CIs_similarChanges.df <- rbind(points_CIs_similarChanges.df,pointsCI(task_similarChanges.df,"Visualization",'SMultiples'))
points_CIs_similarChanges.df <- rbind(points_CIs_similarChanges.df,pointsCI(task_similarChanges.df,"Visualization",'Mix'))
points_CIs_similarChanges.df$TaskID <- "Similar Changes"
remove(task_similarChanges.df)

#Placement
task_placement.df <- task.df[task.df$TaskID == 12,]

points_CIs_placement.df <- pointsCI(task_placement.df,"Visualization",'Animation')
points_CIs_placement.df <- rbind(points_CIs_placement.df,pointsCI(task_placement.df,"Visualization",'Overlaid'))
points_CIs_placement.df <- rbind(points_CIs_placement.df,pointsCI(task_placement.df,"Visualization",'SMultiples'))
points_CIs_placement.df <- rbind(points_CIs_placement.df,pointsCI(task_placement.df,"Visualization",'Mix'))
points_CIs_placement.df$TaskID <- "Placement"
remove(task_placement.df)


points_CIs_characteristic.df <- rbind(  points_CIs_compareDim.df,
                                        points_CIs_longerTrajectory.df, 
                                        points_CIs_reversals.df,
                                        points_CIs_overlaidPoints.df,
                                        points_CIs_similarChanges.df,
                                        points_CIs_placement.df)

points_CIs_characteristic.df$VisModeID <- revalue(points_CIs_characteristic.df$VisModeID, c("Animation" = "A",
                                                              "Overlaid" = "O",
                                                              "SMultiples" = "S",
                                                              "Mix" = "M"
))

points_CIs_characteristic.df$VisModeID <- ordered(points_CIs_characteristic.df$VisModeID, levels = c('M','S','O','A'))

plot_points_CI2_Characteristic <- dualChart(points_CIs_characteristic.df,ymin = -0.1,ymax = 1.1,yAxisLabel = "",xAxisLabel = "",displayXLabels = T,displayYLabels = T,vLineVal = -1,percentScale=T)
