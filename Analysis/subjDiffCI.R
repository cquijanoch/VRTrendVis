#boot Familiarity
bootdif_familiarity <- function(df) {
  
    clm <- smean.cl.boot(df[df$VisModeID=='4',]$Q1, B=10000, reps=TRUE)
    cls <- smean.cl.boot(df[df$VisModeID=='3',]$Q1, B=10000, reps=TRUE)
    clo <- smean.cl.boot(df[df$VisModeID=='2',]$Q1, B=10000, reps=TRUE)
    cla <- smean.cl.boot(df[df$VisModeID=='1',]$Q1, B=10000, reps=TRUE)

    m <- attr(clm, 'reps')
    s <- attr(cls, 'reps')
    o <- attr(clo, 'reps')
    a <- attr(cla, 'reps')

    s.m <- quantile(s-m,c(.05,.95))
    bs.m <- quantile(s-m,c((1-0.9875),0.9875))

    o.m <- quantile(o-m,c(.05,.95))
    bo.m <- quantile(o-m,c((1-0.9875),0.9875))

    o.s <- quantile(o-s,c(.05,.95))
    bo.s <- quantile(o-s,c((1-0.9875),0.9875))

    a.m <- quantile(a-m,c(.05,.95))
    ba.m <- quantile(a-m,c((1-0.9875),0.9875))

    a.s <- quantile(a-s,c(.05,.95))
    ba.s <- quantile(a-s,c((1-0.9875),0.9875))

    a.o <- quantile(a-o,c(.05,.95))
    ba.o <- quantile(a-o,c((1-0.9875),0.9875))

    ratio <- c("S/M","O/M","O/S","A/M","A/S","A/O")

    pointEstimate <- c( cls[1]-clm[1],
                        clo[1]-clm[1],
                        clo[1]-cls[1],
                        cla[1]-clm[1],
                        cla[1]-cls[1],
                        cla[1]-clo[1])

    lowerBound_CI <- c( s.m[1],
                        o.m[1],
                        o.s[1],
                        a.m[1],
                        a.s[1],
                        a.o[1])

    lowerBound_BCI <- c( bs.m[1],
                        bo.m[1],
                        bo.s[1],
                        ba.m[1],
                        ba.s[1],
                        ba.o[1])     

    upperBound_CI <- c( s.m[2],
                        o.m[2],
                        o.s[2],
                        a.m[2],
                        a.s[2],
                        a.o[2])

    upperBound_BCI <- c( bs.m[2],
                        bo.m[2],
                        bo.s[2],
                        ba.m[2],
                        ba.s[2],
                        ba.o[2]) 

    result.df <- data.frame(factor(ratio), pointEstimate, lowerBound_CI, upperBound_CI, lowerBound_BCI, upperBound_BCI)
    colnames(result.df) <- c('VisModeID','mean','lowerBound_CI','upperBound_CI','lowerBound_BCI', 'upperBound_BCI')
 
    return(result.df)
}

#boot Confidence
bootdif_confidence <- function(df) {
  
    clm <- smean.cl.boot(df[df$VisModeID=='4',]$Q2, B=10000, reps=TRUE)
    cls <- smean.cl.boot(df[df$VisModeID=='3',]$Q2, B=10000, reps=TRUE)
    clo <- smean.cl.boot(df[df$VisModeID=='2',]$Q2, B=10000, reps=TRUE)
    cla <- smean.cl.boot(df[df$VisModeID=='1',]$Q2, B=10000, reps=TRUE)

    m <- attr(clm, 'reps')
    s <- attr(cls, 'reps')
    o <- attr(clo, 'reps')
    a <- attr(cla, 'reps')

    s.m <- quantile(s-m,c(.05,.95))
    bs.m <- quantile(s-m,c((1-0.9875),0.9875))

    o.m <- quantile(o-m,c(.05,.95))
    bo.m <- quantile(o-m,c((1-0.9875),0.9875))

    o.s <- quantile(o-s,c(.05,.95))
    bo.s <- quantile(o-s,c((1-0.9875),0.9875))

    a.m <- quantile(a-m,c(.05,.95))
    ba.m <- quantile(a-m,c((1-0.9875),0.9875))

    a.s <- quantile(a-s,c(.05,.95))
    ba.s <- quantile(a-s,c((1-0.9875),0.9875))

    a.o <- quantile(a-o,c(.05,.95))
    ba.o <- quantile(a-o,c((1-0.9875),0.9875))

    ratio <- c("S/M","O/M","O/S","A/M","A/S","A/O")
    #ratio <- c("O/S","A/S","A/O")

    pointEstimate <- c( cls[1]-clm[1],
                        clo[1]-clm[1],
                        clo[1]-cls[1],
                        cla[1]-clm[1],
                        cla[1]-cls[1],
                        cla[1]-clo[1])

    lowerBound_CI <- c( s.m[1],
                        o.m[1],
                        o.s[1],
                        a.m[1],
                        a.s[1],
                        a.o[1])

    lowerBound_BCI <- c( bs.m[1],
                        bo.m[1],
                        bo.s[1],
                        ba.m[1],
                        ba.s[1],
                        ba.o[1])     

    upperBound_CI <- c( s.m[2],
                        o.m[2],
                        o.s[2],
                        a.m[2],
                        a.s[2],
                        a.o[2])

    upperBound_BCI <- c( bs.m[2],
                        bo.m[2],
                        bo.s[2],
                        ba.m[2],
                        ba.s[2],
                        ba.o[2]) 

    result.df <- data.frame(factor(ratio), pointEstimate, lowerBound_CI, upperBound_CI, lowerBound_BCI, upperBound_BCI)
    colnames(result.df) <- c('VisModeID','mean','lowerBound_CI','upperBound_CI','lowerBound_BCI', 'upperBound_BCI')
 
    return(result.df)
}

#boot eASE
bootdif_ease <- function(df) {
  
    clm <- smean.cl.boot(df[df$VisModeID=='4',]$Q3, B=10000, reps=TRUE)
    cls <- smean.cl.boot(df[df$VisModeID=='3',]$Q3, B=10000, reps=TRUE)
    clo <- smean.cl.boot(df[df$VisModeID=='2',]$Q3, B=10000, reps=TRUE)
    cla <- smean.cl.boot(df[df$VisModeID=='1',]$Q3, B=10000, reps=TRUE)

    m <- attr(clm, 'reps')
    s <- attr(cls, 'reps')
    o <- attr(clo, 'reps')
    a <- attr(cla, 'reps')

    s.m <- quantile(s-m,c(.05,.95))
    bs.m <- quantile(s-m,c((1-0.9875),0.9875))

    o.m <- quantile(o-m,c(.05,.95))
    bo.m <- quantile(o-m,c((1-0.9875),0.9875))

    o.s <- quantile(o-s,c(.05,.95))
    bo.s <- quantile(o-s,c((1-0.9875),0.9875))

    a.m <- quantile(a-m,c(.05,.95))
    ba.m <- quantile(a-m,c((1-0.9875),0.9875))

    a.s <- quantile(a-s,c(.05,.95))
    ba.s <- quantile(a-s,c((1-0.9875),0.9875))

    a.o <- quantile(a-o,c(.05,.95))
    ba.o <- quantile(a-o,c((1-0.9875),0.9875))

    ratio <- c("S/M","O/M","O/S","A/M","A/S","A/O")
    #ratio <- c("O/S","A/S","A/O")

    pointEstimate <- c( cls[1]-clm[1],
                        clo[1]-clm[1],
                        clo[1]-cls[1],
                        cla[1]-clm[1],
                        cla[1]-cls[1],
                        cla[1]-clo[1])

    lowerBound_CI <- c( s.m[1],
                        o.m[1],
                        o.s[1],
                        a.m[1],
                        a.s[1],
                        a.o[1])

    lowerBound_BCI <- c( bs.m[1],
                        bo.m[1],
                        bo.s[1],
                        ba.m[1],
                        ba.s[1],
                        ba.o[1])     

    upperBound_CI <- c( s.m[2],
                        o.m[2],
                        o.s[2],
                        a.m[2],
                        a.s[2],
                        a.o[2])

    upperBound_BCI <- c( bs.m[2],
                        bo.m[2],
                        bo.s[2],
                        ba.m[2],
                        ba.s[2],
                        ba.o[2]) 

    result.df <- data.frame(factor(ratio), pointEstimate, lowerBound_CI, upperBound_CI, lowerBound_BCI, upperBound_BCI)
    colnames(result.df) <- c('VisModeID','mean','lowerBound_CI','upperBound_CI','lowerBound_BCI', 'upperBound_BCI')
 
    return(result.df)
}


#subjetive.df$VisModeID <- ordered(subjetive.df$VisModeID, levels = c('3','2','1'))
subjetive.df$VisModeID <- ordered(subjetive.df$VisModeID, levels = c('4','3','2','1'))

#familiarity_diff_CIs.df <- bootdif_familiarity(subjetive.df)
#familiarity_diff_CIs.df$TaskID <- 'Q1'

confidence_diff_CIs.df <- bootdif_confidence(subjetive.df)
confidence_diff_CIs.df$TaskID <- 'Q2'

ease_diff_CIs.df <- bootdif_ease(subjetive.df)
ease_diff_CIs.df$TaskID <- 'Q3'

#subj_diff_CIs.df <- rbind(familiarity_diff_CIs.df,confidence_diff_CIs.df,ease_diff_CIs.df)
#remove(familiarity_diff_CIs.df,confidence_diff_CIs.df,ease_diff_CIs.df)

subj_diff_CIs.df <- rbind(confidence_diff_CIs.df,ease_diff_CIs.df)
remove(confidence_diff_CIs.df,ease_diff_CIs.df)

subj_diff_CIs.df$TaskID <- ordered(subj_diff_CIs.df$TaskID, levels = c('Q2','Q3'))

subj_diff_CIs.df$TaskID <- subj_diff_CIs.df$TaskID %>% as.factor()
subj_diff_CIs.df$TaskID <- revalue(subj_diff_CIs.df$TaskID, c(#"Q1" = "Familiarity",
                                                "Q2" = "Confidence",
                                                "Q3" = "Ease of Use"
))

plot_subj_diff_CI2 <- dualChart(subj_diff_CIs.df,ymin = -2,ymax = 2,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)

plot_subj_diff_CI2_1 <- gridChart(subj_diff_CIs.df,'Confidence',ymin = -2,ymax = 2,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_subj_diff_CI2_1, filename = "plot_subj_diff_CI2_1.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)


plot_subj_diff_CI2_2 <- gridChart(subj_diff_CIs.df,'Ease of Use',ymin = -2,ymax = 2,yAxisLabel = "",xAxisLabel = "",displayXLabels = F,displayYLabels = F,vLineVal = 0,percentScale=F)
ggsave(plot = plot_subj_diff_CI2_2, filename = "plot_subj_diff_CI2_2.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)