#libraries
library(dplyr)
library(tidyr)
library(plyr)
library(ggplot2)
library(reshape2)
library(moments)

source('bootCIs.R')

source('dualChart.R')
source('gridChart.R')
#processing CSV
source('processCSVs.R', encoding = 'UTF-8')
source('processForm.R', encoding = 'UTF-8')

#source('processTrackingClean.R') #Temporal
source('processTracking.R', encoding = 'UTF-8')

#CyberSickness and Usability
source('ssq.R')
source('umuxLite.R')


##  By Time  blue color line
source('timingCIsVisualization.R')
source('timingDiffCIsVisualization.R')
source('timingCIsAxes.R')
source('timingDiffCIsAxes.R')
source('timingCIsTask.R')
source('timingDiffCIsTask.R')

source('timingCIsCharacteristic.R')
source('timingDiffCIsCharacteristic.R')

##  By Accuracy  green color line
source('accuracyCIsVisualization.R')
source('accuracy_diffCIVisualization.R')
source('accuracyCIsAxes.R')
source('accuracy_diffCIAxes.R')
source('accuracyCIsTask.R')
source('accuracy_diffCITask.R')

source('accuracyCIsCharacteristic.R')
source('accuracy_diffCICharacteristic.R')


##  By points orange color line
source('pointsCIVisualization.R')
source('pointsDiffCIVisualization.R')
source('pointsCIsAxes.R')
source('pointsDiffCIAxes.R')
source('pointsCIsTask.R')
source('pointsDiffCITask.R')

source('pointsCIsCharacteristic.R')
source('pointsDiffCICharacteristic.R')

##  By subjective red color line
source('subj_CI.R')
source('subjDiffCI.R')




