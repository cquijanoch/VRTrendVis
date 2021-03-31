
ssqCI <- function(result.df, condition) {

    result_subset.df <- subset(result.df,VisModeID==condition)

    CI1 <- bootstrapMeanCI(result_subset.df$ssq,0.95)
    BCI1 <- bootstrapMeanCI(result_subset.df$ssq,0.99)

    exactCI.df <- data.frame('SSQ',condition,CI1[1],CI1[2],CI1[3],BCI1[2],BCI1[3],length(result_subset.df$ssq))
    colnames(exactCI.df) <- c('TaskID','VisModeID','mean','lowerBound_CI','upperBound_CI','lowerBound_BCI','upperBound_BCI','n')
    
    return(exactCI.df)
  
}

#boot dif
diffssqCI <- function(df) {

    b <- attr(smean.cl.boot(df[df$VisModeID=='Before',]$ssq, B=10000, reps=TRUE), 'reps')
    a <- attr(smean.cl.boot(df[df$VisModeID=='After',]$ssq, B=10000, reps=TRUE), 'reps')
    
    meandif <- diff(tapply(df$ssq, df$VisModeID, mean, na.rm=TRUE)) %>% as.numeric() #bootstrapped mean diff
    b.a <- quantile(a-b, c(.05,.95)) #95% CI
    b.ac <- quantile(a-b, c((1-0.99),0.99)) #99% CI
    
    mean_b <- mean(b, na.rm = T) %>% as.numeric()
    mean_a <- mean(a, na.rm = T) %>% as.numeric()
    
    result.df <- data.frame('SSQ','B-A',meandif, b.a[1], b.a[2], b.ac[1], b.ac[2], mean_b, mean_a)
    colnames(result.df) <- c('TaskID','VisModeID','mean','lowerBound_CI','upperBound_CI','lowerBound_BCI','upperBound_BCI','mean_b','mean_a')
    
    return(result.df)
}


form.df$N <- (   form.df$General_discomfort + 
                form.df$Increased_salivation + 
                form.df$Sweating + 
                form.df$Nausea + 
                form.df$Difficulty_concentrating + 
                form.df$Stomach +
                form.df$Burping
) #* 9.54

form.df$O <- (   form.df$General_discomfort + 
                form.df$Fatigue + 
                form.df$Headache + 
                form.df$Eyestrain + 
                form.df$Difficulty_focusing + 
                form.df$Difficulty_concentrating +
                form.df$Blurred_vision
) #* 7.58

form.df$D <- (   form.df$Difficulty_focusing + 
                form.df$Nausea + 
                form.df$Fullness_head + 
                form.df$Blurred_vision + 
                form.df$Dizziness_eyes_open + 
                form.df$Dizziness_eyes_closed +
                form.df$Vertigo
) #* 13.92

form.df$SSQ1 <- (form.df$N + form.df$O + form.df$D) * 3.74

form.df$N2 <- (   form.df$General_discomfort2 + 
                form.df$Increased_salivation2 + 
                form.df$Sweating2 + 
                form.df$Nausea2 + 
                form.df$Difficulty_concentrating2 + 
                form.df$Stomach2 +
                form.df$Burping2
) #* 9.54

form.df$O2 <- (   form.df$General_discomfort2 + 
                form.df$Fatigue2 + 
                form.df$Headache2 + 
                form.df$Eyestrain2 + 
                form.df$Difficulty_focusing2 + 
                form.df$Difficulty_concentrating2 +
                form.df$Blurred_vision2
) #* 7.58

form.df$D2 <- (   form.df$Difficulty_focusing2 + 
                form.df$Nausea2 + 
                form.df$Fullness_head2 + 
                form.df$Blurred_vision2 + 
                form.df$Dizziness_eyes_open2 + 
                form.df$Dizziness_eyes_closed2 +
                form.df$Vertigo2
) #* 13.92

form.df$SSQ2 <- (form.df$N2 + form.df$O2 + form.df$D2) * 3.74

ssqb.df <- data.frame('SSQ', factor('Before'), form.df$SSQ1)
colnames(ssqb.df) <- c('TaskID', 'VisModeID', 'ssq')

ssqa.df <- data.frame('SSQ', factor('After'), form.df$SSQ2)
colnames(ssqa.df) <- c('TaskID', 'VisModeID', 'ssq')

ssq.df <- rbind(ssqb.df,ssqa.df)

remove(ssqb.df)
remove(ssqa.df)

ssq_CI.df <- ssqCI(ssq.df, "Before")
ssq_CI.df <- rbind(ssq_CI.df,ssqCI(ssq.df, "After"))

plot_ssq_CI<- dualChart(ssq_CI.df,ymin = 0,ymax = 100,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_ssq_CI, filename = "plot_ssq_CI.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

ssq_diff_CI.df <- diffssqCI(ssq.df)
plot_ssq_diff_CI <- dualChart(ssq_diff_CI.df,ymin = -50,ymax = 50,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_ssq_diff_CI, filename = "plot_ssq_diff_CI.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)
