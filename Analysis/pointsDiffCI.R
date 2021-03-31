library(Hmisc)

#boot dif
bootdif <- function(df) {
  
    #clm <- smean.cl.boot(df[df$VisModeID=='Mix',]$points, B=10000, reps=TRUE)
    cls <- smean.cl.boot(df[df$VisModeID=='SMultiples',]$points, B=10000, reps=TRUE)
    clo <- smean.cl.boot(df[df$VisModeID=='Overlaid',]$points, B=10000, reps=TRUE)
    cla <- smean.cl.boot(df[df$VisModeID=='Animation',]$points, B=10000, reps=TRUE)

    #m <- attr(clm, 'reps')
    s <- attr(cls, 'reps')
    o <- attr(clo, 'reps')
    a <- attr(cla, 'reps')

    #s.m <- quantile(s-m,c(.05,.95))
    #bs.m <- quantile(s-m,c((1-0.9875),0.9875))

    #o.m <- quantile(o-m,c(.05,.95))
    #bo.m <- quantile(o-m,c((1-0.9875),0.9875))

    o.s <- quantile(o-s,c(.05,.95))
    bo.s <- quantile(o-s,c((1-0.9875),0.9875))

    #a.m <- quantile(a-m,c(.05,.95))
    #ba.m <- quantile(a-m,c((1-0.9875),0.9875))

    a.s <- quantile(a-s,c(.05,.95))
    ba.s <- quantile(a-s,c((1-0.9875),0.9875))

    a.o <- quantile(a-o,c(.05,.95))
    ba.o <- quantile(a-o,c((1-0.9875),0.9875))

    #ratio <- c("S/M","O/M","O/S","A/M","A/S","A/O")
    ratio <- c("O/S","A/S","A/O")

    pointEstimate <- c( #cls[1]-clm[1],
                        #clo[1]-clm[1],
                        clo[1]-cls[1],
                        #cla[1]-clm[1],
                        cla[1]-cls[1],
                        cla[1]-clo[1])

    lowerBound_CI <- c( #s.m[1],
                        #o.m[1],
                        o.s[1],
                        #a.m[1],
                        a.s[1],
                        a.o[1])

    lowerBound_BCI <- c( #bs.m[1],
                        #bo.m[1],
                        bo.s[1],
                        #ba.m[1],
                        ba.s[1],
                        ba.o[1])     

    upperBound_CI <- c( #s.m[2],
                        #o.m[2],
                        o.s[2],
                        #a.m[2],
                        a.s[2],
                        a.o[2])

    upperBound_BCI <- c( #bs.m[2],
                        #bo.m[2],
                        bo.s[2],
                        #ba.m[2],
                        ba.s[2],
                        ba.o[2]) 

    result.df <- data.frame(df$TaskID, factor(ratio), pointEstimate, lowerBound_CI, upperBound_CI, lowerBound_BCI, upperBound_BCI)
    colnames(result.df) <- c('TaskID','VisModeID','mean','lowerBound_CI','upperBound_CI','lowerBound_BCI', 'upperBound_BCI')
 
    return(result.df)
}
