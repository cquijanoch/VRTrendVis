timing_diffCI <- function(result.df,task_num = "Visualization") {
  
    if(task_num == "Visualization") 
    {
        df <- data.frame(result.df)
        df$TaskID <- "Visualization"
    }    
    else
    {
        df <- result.df[result.df$TaskID == task_num,]
    }

    #clm <- smean.cl.boot(log(df[df$VisModeID=='Mix',]$duration), B=10000, reps=TRUE)
    cls <- smean.cl.boot(log(df[df$VisModeID=='SMultiples',]$duration), B=10000, reps=TRUE)
    clo <- smean.cl.boot(log(df[df$VisModeID=='Overlaid',]$duration), B=10000, reps=TRUE)
    cla <- smean.cl.boot(log(df[df$VisModeID=='Animation',]$duration), B=10000, reps=TRUE)

    #m <- attr(clm, 'reps')
    s <- attr(cls, 'reps')
    o <- attr(clo, 'reps')
    a <- attr(cla, 'reps')

    #s.m <- quantile(s-m,c(.05,.95))
    #bs.m <- quantile(s-m,c((1-0.9875),0.9875))

    #o.m <- quantile(o-m,c(.05,.95))
    #bo.m <- quantile(o-m,c((1-0.9875),0.9875))

    o.s <- quantile(o-s,c(.05,.95))
    #bo.s <- quantile(o-s,c((1-0.9875),0.9875))
    bo.s <- quantile(o-s,c(.01,.99))

    #a.m <- quantile(a-m,c(.05,.95))
    #ba.m <- quantile(a-m,c((1-0.9875),0.9875))

    a.s <- quantile(a-s,c(.05,.95))
    #ba.s <- quantile(a-s,c((1-0.9875),0.9875))
    ba.s <- quantile(a-s,c(.01,.99))

    a.o <- quantile(a-o,c(.05,.95))
    #ba.o <- quantile(a-o,c((1-0.9875),0.9875))
    ba.o <- quantile(a-o,c(.01,.99))

    ratio <- c("O/S","A/S","A/O")
    #ratio <- c("S/M","O/M","O/S","A/M","A/S","A/O")

    pointEstimate <- c( #exp(cls[1]-clm[1]),
                        #exp(clo[1]-clm[1]),
                        exp(clo[1]-cls[1]),
                        #exp(cla[1]-clm[1]),
                        exp(cla[1]-cls[1]),
                        exp(cla[1]-clo[1]))

    lowerBound_CI <- c( #exp(s.m[1]),
                        #exp(o.m[1]),
                        exp(o.s[1]),
                        #exp(a.m[1]),
                        exp(a.s[1]),
                        exp(a.o[1]))

    lowerBound_BCI <- c( #exp(bs.m[1]),
                        #exp(bo.m[1]),
                        exp(bo.s[1]),
                        #exp(ba.m[1]),
                        exp(ba.s[1]),
                        exp(ba.o[1]))     

    upperBound_CI <- c( #exp(s.m[2]),
                        #exp(o.m[2]),
                        exp(o.s[2]),
                        #exp(a.m[2]),
                        exp(a.s[2]),
                        exp(a.o[2]))

    upperBound_BCI <- c( #exp(bs.m[2]),
                        #exp(bo.m[2]),
                        exp(bo.s[2]),
                        #exp(ba.m[2]),
                        exp(ba.s[2]),
                        exp(ba.o[2])) 

    result.df <- data.frame(df$TaskID, factor(ratio), pointEstimate, lowerBound_CI, upperBound_CI, lowerBound_BCI, upperBound_BCI)
    colnames(result.df) <- c('TaskID','VisModeID','mean','lowerBound_CI','upperBound_CI','lowerBound_BCI', 'upperBound_BCI')
 
    return(result.df)
  
}
