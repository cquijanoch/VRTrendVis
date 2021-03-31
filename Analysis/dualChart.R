library(ggplot2)
library(reshape2)

dualChart <- function(resultTable, ymin, ymax, xAxisLabel = "", yAxisLabel = "", vLineVal = 0, displayXLabels = T, displayYLabels = T, percentScale = F){

  tr <- as.data.frame(resultTable)

  #now need to calculate one number for the width of the interval
  tr$CI2 <- tr$upperBound_CI - tr$mean
  tr$CI1 <- tr$mean - tr$lowerBound_CI
  tr$BCI2 <- tr$upperBound_BCI - tr$mean
  tr$BCI1 <- tr$mean - tr$lowerBound_BCI
  
   #print(tr)
  g <- ggplot(tr, aes(x=VisModeID, y=mean))
  
  g <- g + geom_errorbar(aes(ymin=mean-BCI1, ymax=mean+BCI2, color=VisModeID),
                         width=0,                    # Width of the error bars
                         size = 0.25,
                         show.legend = F)
  
  g <- g + geom_errorbar(aes(ymin=mean-CI1, ymax=mean+CI2, color=VisModeID),
                         width=0,                    # Width of the error bars
                         size = 0.75,
                         show.legend = F)
  
  g <- g + geom_point(aes(color=VisModeID), size=4, show.legend = F)

  #print(mean)
  
  if (vLineVal >= ymin & vLineVal <= ymax){
    g <- g + geom_hline(aes(yintercept=vLineVal), colour="#666666", linetype = 2, size=0.5)
  }
  # g <- g + geom_hline(aes(yintercept=12.5), colour="#1F77B4", linetype = 3, size=0.5, alpha=0.5)


###blue
#   cols <- c("A" = "#1f78b4", "O" = "#1f78b4", "S" = "#1f78b4", 
#             "M" = "#1f78b4", "A-S" = "#1f78b4", "A/S" = "#1f78b4",
#             "A-O" = "#1f78b4", "A/O" = "#1f78b4","A-M" = "#1f78b4", "A/M" = "#1f78b4",
#             "O-S" = "#1f78b4", "O/S" = "#1f78b4","O-M" = "#1f78b4", "O/M" = "#1f78b4",
#             "S-M" = "#1f78b4", "S/M" = "#1f78b4","Before" = "#1f78b4", "After" = "#1f78b4","B-A" = "#1f78b4")
###Green
#     cols <- c("A" = "#33a02c", "O" = "#33a02c", "S" = "#33a02c", 
#             "M" = "#33a02c", "A-S" = "#33a02c", "A/S" = "#33a02c",
#             "A-O" = "#33a02c", "A/O" = "#33a02c","A-M" = "#33a02c", "A/M" = "#33a02c",
#             "O-S" = "#33a02c", "O/S" = "#33a02c","O-M" = "#33a02c", "O/M" = "#33a02c",
#             "S-M" = "#33a02c", "S/M" = "#33a02c","Before" = "#33a02c", "After" = "#1f78b4","B-A" = "#33a02c")
###Orange
 #   cols <- c("A" = "#ff7f00", "O" = "#ff7f00", "S" = "#ff7f00", 
 #           "M" = "#ff7f00", "A-S" = "#ff7f00", "A/S" = "#ff7f00",
 #           "A-O" = "#ff7f00", "A/O" = "#ff7f00","A-M" = "#ff7f00", "A/M" = "#ff7f00",
 #           "O-S" = "#ff7f00", "O/S" = "#ff7f00","O-M" = "#ff7f00", "O/M" = "#ff7f00",
 #           "S-M" = "#ff7f00", "S/M" = "#ff7f00","Before" = "#ff7f00", "After" = "#ff7f00","B-A" = "#ff7f00")
  
     cols <- c("A" = "#6a3d9a", "O" = "#6a3d9a", "S" = "#6a3d9a", 
             "M" = "#6a3d9a", "A-S" = "#6a3d9a", "A/S" = "#6a3d9a",
             "A-O" = "#6a3d9a", "A/O" = "#6a3d9a","A-M" = "#6a3d9a", "A/M" = "#6a3d9a",
             "O-S" = "#6a3d9a", "O/S" = "#6a3d9a","O-M" = "#6a3d9a", "O/M" = "#6a3d9a",
             "S-M" = "#6a3d9a", "S/M" = "#6a3d9a","Before" = "#6a3d9a", "After" = "#6a3d9a","B-A" = "#6a3d9a")



  # cols <- c("A" = "#1f78b4", "O" = "#33a02c", "S" = "#e31a1c", 
  #           "M" = "#ff7f00", "A-S" = "#b2df8a", "A/S" = "#b2df8a",
  #           "A-O" = "#a6cee3", "A/O" = "#a6cee3","A-M" = "#fb9a99", "A/M" = "#fb9a99",
  #           "O-S" = "#fdbf6f", "O/S" = "#fdbf6f","O-M" = "#cab2d6", "O/M" = "#cab2d6",
  #           "S-M" = "#6a3d9a", "S/M" = "#6a3d9a","Before" = "#1f78b4", "After" = "#33a02c","B-A" = "#6a3d9a")
  g <- g + scale_color_manual(values = cols) +
    labs(x = xAxisLabel, y = yAxisLabel)
  
  if (percentScale) {
    # g <- g + scale_y_continuous(limits = c(ymin,ymax), labels = scales::percent,breaks = seq(-0.5, 0.5, by = 0.5))
    g <- g + scale_y_continuous(limits = c(ymin,ymax), expand=c(0,0), labels = scales::percent)
  }
  else {
    g <- g + scale_y_continuous(limits = c(ymin,ymax), expand=c(0,0))
  }
  g <- g + coord_flip() +
    # theme(panel.background = element_rect(fill = '#F5F5DC', colour = 'white'),
    theme(panel.background = element_rect(fill = '#EEEEEE', colour = 'white'),
          axis.title=element_blank(),
          axis.ticks.y=element_blank(),
          axis.ticks.x=element_blank(),
          legend.title = element_blank(),
          legend.position = 'bottom',
          panel.grid.major = element_line(colour = "#DDDDDD"),
          panel.grid.minor = element_blank(),
          panel.grid.major.y = element_blank(), 
          axis.ticks.length = unit(0, "lines"),
          # panel.spacing = unit(c(0,0,0,0), "mm"),
          strip.background = element_rect(fill = "NA"),
          plot.margin = unit(c(0,0,0,0), "mm"),
          strip.placement = "outside",
          strip.text.x = element_text(face = "bold",size=7),
          strip.text.y = element_text(face = "bold",size=7,angle = 180))
  
  if (displayXLabels) {
    g <- g + theme(axis.text.x = element_text(size=6))
  }
  else {
    g <- g + theme(axis.text.x = element_blank())
  }
  
  if (displayYLabels) {
    g <- g + theme(axis.text.y=element_text(colour = "black",size=6))
  }
  else {
    g <- g + theme(axis.text.y=element_blank())
  }
  #AXES
  #g <- g + facet_grid(TaskID ~ ., switch='y')
  
  
  return(g)
}